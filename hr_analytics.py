from pathlib import Path
import argparse
import re
import pandas as pd
import numpy as np

ROOT = Path(__file__).resolve().parents[1]
DATA_DIR = ROOT / "data"
OUTPUT_DIR = ROOT / "output"
CLEAN_DIR = OUTPUT_DIR / "cleaned_data"

TABLES = [
    "dim_employees",
    "dim_employee_demographics",
    "dim_departments",
    "dim_jobs",
    "dim_locations",
    "fact_employee_current",
    "fact_compensation_history",
    "fact_performance_reviews",
    "fact_engagement_surveys",
    "fact_learning_completions",
    "fact_leave_events",
    "fact_promotions",
    "fact_requisitions",
    "fact_candidates",
    "fact_headcount_monthly",
    "fact_manager_span",
]

DATE_COLUMNS = {
    "dim_employees": ["BirthDate", "HireDate", "TerminationDate"],
    "fact_employee_current": ["HireDate", "TerminationDate"],
    "fact_compensation_history": ["EffectiveDate"],
    "fact_performance_reviews": ["ReviewDate"],
    "fact_engagement_surveys": ["SurveyDate"],
    "fact_learning_completions": ["CompletionDate"],
    "fact_leave_events": ["LeaveStartDate", "LeaveEndDate"],
    "fact_promotions": ["PromotionDate"],
    "fact_requisitions": ["OpenDate", "CloseDate"],
    "fact_candidates": ["ApplicationDate"],
    "fact_headcount_monthly": ["SnapshotDate"],
}

def clean_table(name: str, df: pd.DataFrame) -> pd.DataFrame:
    df = df.copy()
    df.columns = [re.sub(r"[^A-Za-z0-9_]", "_", c.strip()) for c in df.columns]

    # Trim text fields and normalize obvious blank strings.
    for col in df.select_dtypes(include="object").columns:
        df[col] = df[col].astype("string").str.strip()
        df[col] = df[col].replace({"": pd.NA, "nan": pd.NA, "None": pd.NA})

    # Parse dates using the real dataset's column names.
    for col in DATE_COLUMNS.get(name, []):
        if col in df.columns:
            df[col] = pd.to_datetime(df[col], errors="coerce")

    # Convert known numeric columns where applicable.
    for col in df.columns:
        if col in {
            "Age", "FTE", "CurrentSalary", "CurrentBonusTarget",
            "BaseSalary", "BonusTargetPct", "AnnualBonusTarget",
            "PerformanceRating", "PotentialRating", "GoalCompletionPct",
            "MeritIncreasePct", "EngagementScore", "ManagerEffectivenessScore",
            "InclusionScore", "IntentToStayScore", "LearningHours",
            "LeaveDays", "InterviewScore", "DaysToFill", "Headcount",
            "DirectReports", "CostIndex"
        }:
            if col in df.columns:
                df[col] = pd.to_numeric(df[col], errors="coerce")

    # Remove exact duplicate records only.
    df = df.drop_duplicates().reset_index(drop=True)
    return df

def data_quality_report(tables):
    rows = []
    for name, df in tables.items():
        for col in df.columns:
            rows.append({
                "table": name,
                "column": col,
                "rows": len(df),
                "null_count": int(df[col].isna().sum()),
                "null_pct": round(float(df[col].isna().mean() * 100), 2),
                "unique_count": int(df[col].nunique(dropna=True)),
                "dtype": str(df[col].dtype),
            })
    return pd.DataFrame(rows)

def build_summary(tables):
    employees = tables["dim_employees"]
    current = tables["fact_employee_current"]
    comp = tables["fact_compensation_history"]
    perf = tables["fact_performance_reviews"]
    candidates = tables["fact_candidates"]
    req = tables["fact_requisitions"]
    learning = tables["fact_learning_completions"]
    leave = tables["fact_leave_events"]

    active = current["EmploymentStatus"].astype("string").str.lower().eq("active").sum()
    terminated = current["TerminationDate"].notna().sum()

    metrics = pd.DataFrame([
        ["Total Employees", len(employees)],
        ["Active Employees", int(active)],
        ["Employees with Termination Date", int(terminated)],
        ["Compensation Events", len(comp)],
        ["Performance Reviews", len(perf)],
        ["Candidates", len(candidates)],
        ["Requisitions", len(req)],
        ["Learning Completions", len(learning)],
        ["Leave Events", len(leave)],
        ["Departments", tables["dim_departments"]["DepartmentID"].nunique()],
        ["Jobs", tables["dim_jobs"]["JobID"].nunique()],
        ["Locations", tables["dim_locations"]["LocationID"].nunique()],
    ], columns=["Metric", "Value"])
    return metrics

def load_mysql(tables, args):
    try:
        from sqlalchemy import create_engine
    except ImportError:
        raise SystemExit("Install SQLAlchemy first: pip install sqlalchemy pymysql")

    url = (
        f"mysql+pymysql://{args.mysql_user}:{args.mysql_password}"
        f"@{args.mysql_host}:{args.mysql_port}/{args.mysql_db}"
    )
    engine = create_engine(url, pool_pre_ping=True)

    # replace=True is intentional for a repeatable portfolio ETL run.
    for name, df in tables.items():
        out = df.copy()
        for col in out.columns:
            if pd.api.types.is_datetime64_any_dtype(out[col]):
                out[col] = out[col].where(out[col].notna(), None)
        out.to_sql(name, engine, if_exists="replace", index=False, chunksize=5000, method="multi")
        print(f"Loaded {name}: {len(df):,} rows")
    print("MySQL load completed.")

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--mysql-host")
    parser.add_argument("--mysql-port", type=int, default=3306)
    parser.add_argument("--mysql-user")
    parser.add_argument("--mysql-password")
    parser.add_argument("--mysql-db", default="hr_analytics")
    args = parser.parse_args()

    OUTPUT_DIR.mkdir(exist_ok=True)
    CLEAN_DIR.mkdir(parents=True, exist_ok=True)

    tables = {}
    for name in TABLES:
        path = DATA_DIR / f"{name}.csv"
        if not path.exists():
            raise FileNotFoundError(f"Missing dataset file: {path}")
        raw = pd.read_csv(path, low_memory=False)
        clean = clean_table(name, raw)
        tables[name] = clean
        clean.to_csv(CLEAN_DIR / f"{name}.csv", index=False)
        print(f"{name}: {len(raw):,} raw -> {len(clean):,} cleaned rows")

    quality = data_quality_report(tables)
    summary = build_summary(tables)

    with pd.ExcelWriter(OUTPUT_DIR / "hr_data_quality_report.xlsx", engine="openpyxl") as writer:
        quality.to_excel(writer, sheet_name="Data Quality", index=False)
        summary.to_excel(writer, sheet_name="Summary Metrics", index=False)
        for name, df in tables.items():
            df.head(1000).to_excel(writer, sheet_name=name[:31], index=False)

    summary.to_excel(OUTPUT_DIR / "summary_metrics.xlsx", index=False)

    if args.mysql_password and args.mysql_user and args.mysql_host:
        load_mysql(tables, args)

    print("\nETL completed.")
    print(f"Cleaned CSVs: {CLEAN_DIR}")
    print(f"Quality report: {OUTPUT_DIR / 'hr_data_quality_report.xlsx'}")

if __name__ == "__main__":
    main()
