CREATE DATABASE IF NOT EXISTS hr_analytics;
USE hr_analytics;

CREATE TABLE IF NOT EXISTS dim_departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(150),
    FunctionGroup VARCHAR(150)
);

CREATE TABLE IF NOT EXISTS dim_locations (
    LocationID INT PRIMARY KEY,
    LocationName VARCHAR(150),
    State VARCHAR(100),
    Region VARCHAR(100),
    CostIndex DECIMAL(10,2)
);

CREATE TABLE IF NOT EXISTS dim_jobs (
    JobID INT PRIMARY KEY,
    DepartmentID INT,
    JobTitle VARCHAR(200),
    JobLevel VARCHAR(100),
    Exempt VARCHAR(20),
    DepartmentName VARCHAR(150),
    FunctionGroup VARCHAR(150),
    BaseSalaryMin DECIMAL(15,2),
    BaseSalaryMax DECIMAL(15,2)
);

CREATE TABLE IF NOT EXISTS dim_employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    Email VARCHAR(255),
    Gender VARCHAR(100),
    BirthDate DATE,
    Age INT,
    DepartmentID INT,
    JobID INT,
    JobTitle VARCHAR(200),
    JobLevel VARCHAR(100),
    LocationID INT,
    HireDate DATE,
    TerminationDate DATE,
    EmploymentStatus VARCHAR(50),
    TerminationType VARCHAR(100),
    WorkerType VARCHAR(100),
    EmploymentType VARCHAR(100),
    Exempt VARCHAR(20),
    FTE DECIMAL(8,2),
    RemoteStatus VARCHAR(100),
    ManagerID INT,
    ManagerName VARCHAR(200),
    FinalTenureYears DECIMAL(10,2),
    CurrentSalary DECIMAL(15,2),
    CurrentBonusTarget DECIMAL(15,2)
);

CREATE TABLE IF NOT EXISTS dim_employee_demographics (
    EmployeeID INT PRIMARY KEY,
    GenderIdentity VARCHAR(100),
    Ethnicity VARCHAR(100),
    VeteranStatus VARCHAR(100),
    DisabilityStatus VARCHAR(100),
    MaritalStatus VARCHAR(100),
    EducationLevel VARCHAR(150)
);

CREATE TABLE IF NOT EXISTS fact_employee_current (
    EmployeeID INT PRIMARY KEY,
    DepartmentID INT,
    JobID INT,
    LocationID INT,
    ManagerID INT,
    HireDate DATE,
    TerminationDate DATE,
    EmploymentStatus VARCHAR(50),
    TerminationType VARCHAR(100),
    WorkerType VARCHAR(100),
    EmploymentType VARCHAR(100),
    FTE DECIMAL(8,2),
    RemoteStatus VARCHAR(100),
    FinalTenureYears DECIMAL(10,2)
);

CREATE TABLE IF NOT EXISTS fact_compensation_history (
    CompensationEventID INT PRIMARY KEY,
    EmployeeID INT,
    EffectiveDate DATE,
    BaseSalary DECIMAL(15,2),
    BonusTargetPct DECIMAL(8,4),
    AnnualBonusTarget DECIMAL(15,2),
    PayGrade VARCHAR(50),
    CompensationChangeReason VARCHAR(150)
);

CREATE TABLE IF NOT EXISTS fact_performance_reviews (
    ReviewID INT PRIMARY KEY,
    EmployeeID INT,
    ReviewDate DATE,
    PerformanceRating DECIMAL(8,2),
    PotentialRating DECIMAL(8,2),
    GoalCompletionPct DECIMAL(8,2),
    MeritIncreasePct DECIMAL(8,2),
    PromotionRecommended VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS fact_engagement_surveys (
    SurveyResponseID INT PRIMARY KEY,
    EmployeeID INT,
    SurveyDate DATE,
    EngagementScore DECIMAL(8,2),
    ManagerEffectivenessScore DECIMAL(8,2),
    InclusionScore DECIMAL(8,2),
    IntentToStayScore DECIMAL(8,2),
    SurveyParticipationFlag VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS fact_learning_completions (
    LearningEventID INT PRIMARY KEY,
    EmployeeID INT,
    CourseID INT,
    CompletionDate DATE,
    LearningHours DECIMAL(10,2),
    CompletionStatus VARCHAR(100),
    CourseName VARCHAR(255),
    CourseCategory VARCHAR(150)
);

CREATE TABLE IF NOT EXISTS fact_leave_events (
    LeaveEventID INT PRIMARY KEY,
    EmployeeID INT,
    LeaveType VARCHAR(100),
    LeaveStartDate DATE,
    LeaveEndDate DATE,
    LeaveDays DECIMAL(10,2),
    PaidFlag VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS fact_promotions (
    PromotionEventID INT PRIMARY KEY,
    EmployeeID INT,
    PromotionDate DATE,
    PriorJobLevel VARCHAR(100),
    NewJobLevel VARCHAR(100),
    PromotionType VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS fact_requisitions (
    RequisitionID INT PRIMARY KEY,
    JobID INT,
    OpenDate DATE,
    Recruiter VARCHAR(200),
    RequisitionStatus VARCHAR(100),
    Openings INT,
    DepartmentID INT,
    JobTitle VARCHAR(200),
    JobLevel VARCHAR(100),
    HiringManagerID INT,
    HiringManagerName VARCHAR(200),
    CloseDate DATE
);

CREATE TABLE IF NOT EXISTS fact_candidates (
    CandidateID INT PRIMARY KEY,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    Gender VARCHAR(100),
    RequisitionID INT,
    ApplicationDate DATE,
    Source VARCHAR(150),
    CurrentStage VARCHAR(100),
    JobID INT,
    DepartmentID INT,
    JobTitle VARCHAR(200),
    JobLevel VARCHAR(100),
    Recruiter VARCHAR(200),
    InterviewScore DECIMAL(8,2),
    OfferAccepted VARCHAR(50),
    DaysToFill DECIMAL(10,2)
);

CREATE TABLE IF NOT EXISTS fact_headcount_monthly (
    DepartmentID INT,
    LocationID INT,
    Headcount INT,
    SnapshotDate DATE,
    DepartmentName VARCHAR(150),
    LocationName VARCHAR(150),
    Region VARCHAR(100),
    PRIMARY KEY (DepartmentID, LocationID, SnapshotDate)
);

CREATE TABLE IF NOT EXISTS fact_manager_span (
    ManagerID INT PRIMARY KEY,
    DirectReports INT,
    ManagerName VARCHAR(200),
    ManagerDepartmentID INT,
    ManagerJobID INT
);

-- ============================================================
-- INDEXES
-- ============================================================

CREATE INDEX idx_emp_department ON dim_employees(DepartmentID);
CREATE INDEX idx_emp_job ON dim_employees(JobID);
CREATE INDEX idx_emp_location ON dim_employees(LocationID);
CREATE INDEX idx_comp_employee_date ON fact_compensation_history(EmployeeID, EffectiveDate);
CREATE INDEX idx_perf_employee_date ON fact_performance_reviews(EmployeeID, ReviewDate);
CREATE INDEX idx_eng_employee_date ON fact_engagement_surveys(EmployeeID, SurveyDate);
CREATE INDEX idx_learning_employee_date ON fact_learning_completions(EmployeeID, CompletionDate);
CREATE INDEX idx_leave_employee_date ON fact_leave_events(EmployeeID, LeaveStartDate);
CREATE INDEX idx_promo_employee_date ON fact_promotions(EmployeeID, PromotionDate);
CREATE INDEX idx_req_department ON fact_requisitions(DepartmentID);
CREATE INDEX idx_candidate_req ON fact_candidates(RequisitionID);
CREATE INDEX idx_candidate_department ON fact_candidates(DepartmentID);
CREATE INDEX idx_headcount_date ON fact_headcount_monthly(SnapshotDate);

-- ============================================================
-- ANALYTICAL VIEWS
-- ============================================================

CREATE OR REPLACE VIEW vw_employee_overview AS
SELECT
    e.EmployeeID,
    CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName,
    e.Age,
    e.Gender,
    d.DepartmentName,
    j.JobTitle,
    j.JobLevel,
    l.LocationName,
    l.Region,
    e.HireDate,
    e.TerminationDate,
    e.EmploymentStatus,
    e.WorkerType,
    e.EmploymentType,
    e.RemoteStatus,
    e.FTE,
    e.FinalTenureYears,
    e.CurrentSalary,
    e.CurrentBonusTarget
FROM dim_employees e
LEFT JOIN dim_departments d ON e.DepartmentID = d.DepartmentID
LEFT JOIN dim_jobs j ON e.JobID = j.JobID
LEFT JOIN dim_locations l ON e.LocationID = l.LocationID;

CREATE OR REPLACE VIEW vw_latest_compensation AS
SELECT c.*
FROM fact_compensation_history c
JOIN (
    SELECT EmployeeID, MAX(EffectiveDate) AS MaxDate
    FROM fact_compensation_history
    GROUP BY EmployeeID
) x ON c.EmployeeID = x.EmployeeID AND c.EffectiveDate = x.MaxDate;

CREATE OR REPLACE VIEW vw_recruitment_funnel AS
SELECT
    CurrentStage,
    COUNT(*) AS Candidates,
    SUM(CASE WHEN OfferAccepted IN ('1','1.0','Yes','YES','True','TRUE') THEN 1 ELSE 0 END) AS OffersAccepted,
    AVG(InterviewScore) AS AvgInterviewScore,
    AVG(DaysToFill) AS AvgDaysToFill
FROM fact_candidates
GROUP BY CurrentStage;

CREATE OR REPLACE VIEW vw_department_workforce AS
SELECT
    d.DepartmentID,
    d.DepartmentName,
    COUNT(e.EmployeeID) AS Employees,
    SUM(CASE WHEN LOWER(e.EmploymentStatus) = 'active' THEN 1 ELSE 0 END) AS ActiveEmployees,
    AVG(e.CurrentSalary) AS AvgSalary,
    AVG(e.FinalTenureYears) AS AvgTenure
FROM dim_departments d
LEFT JOIN dim_employees e ON d.DepartmentID = e.DepartmentID
GROUP BY d.DepartmentID, d.DepartmentName;

-- ============================================================
-- PORTFOLIO ANALYSIS QUERIES
-- ============================================================

-- 1. Workforce by department
SELECT * FROM vw_department_workforce
ORDER BY ActiveEmployees DESC;

-- 2. Attrition by department
SELECT
    d.DepartmentName,
    COUNT(*) AS Employees,
    SUM(CASE WHEN e.TerminationDate IS NOT NULL THEN 1 ELSE 0 END) AS Exits,
    ROUND(
        100 * SUM(CASE WHEN e.TerminationDate IS NOT NULL THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*),0), 2
    ) AS AttritionPct
FROM dim_employees e
JOIN dim_departments d ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName
ORDER BY AttritionPct DESC;

-- 3. Salary by job level
SELECT
    JobLevel,
    COUNT(*) AS Employees,
    ROUND(AVG(CurrentSalary),2) AS AvgSalary,
    ROUND(MIN(CurrentSalary),2) AS MinSalary,
    ROUND(MAX(CurrentSalary),2) AS MaxSalary
FROM dim_employees
GROUP BY JobLevel
ORDER BY AvgSalary DESC;

-- 4. Promotion performance
SELECT
    p.PromotionType,
    COUNT(*) AS Promotions,
    AVG(e.CurrentSalary) AS AvgCurrentSalary
FROM fact_promotions p
JOIN dim_employees e ON p.EmployeeID = e.EmployeeID
GROUP BY p.PromotionType
ORDER BY Promotions DESC;

-- 5. Performance vs compensation
SELECT
    ROUND(AVG(pr.PerformanceRating),2) AS AvgPerformance,
    ROUND(AVG(pr.MeritIncreasePct),2) AS AvgMeritIncreasePct
FROM fact_performance_reviews pr;

-- 6. Training participation
SELECT
    CourseCategory,
    COUNT(*) AS Completions,
    ROUND(SUM(LearningHours),2) AS LearningHours,
    ROUND(AVG(LearningHours),2) AS AvgHoursPerCompletion
FROM fact_learning_completions
GROUP BY CourseCategory
ORDER BY LearningHours DESC;

-- 7. Recruitment source effectiveness
SELECT
    Source,
    COUNT(*) AS Applicants,
    AVG(InterviewScore) AS AvgInterviewScore,
    SUM(CASE WHEN OfferAccepted IN ('1','1.0','Yes','YES','True','TRUE')
             THEN 1 ELSE 0 END) AS OffersAccepted
FROM fact_candidates
GROUP BY Source
ORDER BY OffersAccepted DESC;

-- 8. Recruitment funnel
SELECT * FROM vw_recruitment_funnel
ORDER BY Candidates DESC;

-- 9. Average leave days by leave type
SELECT
    LeaveType,
    COUNT(*) AS LeaveEvents,
    ROUND(SUM(LeaveDays),2) AS TotalLeaveDays,
    ROUND(AVG(LeaveDays),2) AS AvgLeaveDays
FROM fact_leave_events
GROUP BY LeaveType
ORDER BY TotalLeaveDays DESC;

-- 10. Engagement and intent to stay
SELECT
    ROUND(AVG(EngagementScore),2) AS AvgEngagement,
    ROUND(AVG(ManagerEffectivenessScore),2) AS AvgManagerEffectiveness,
    ROUND(AVG(IntentToStayScore),2) AS AvgIntentToStay
FROM fact_engagement_surveys;

-- 11. Employees with high performance but low intent to stay
SELECT
    e.EmployeeID,
    CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName,
    d.DepartmentName,
    pr.PerformanceRating,
    s.IntentToStayScore
FROM dim_employees e
JOIN dim_departments d ON e.DepartmentID = d.DepartmentID
JOIN (
    SELECT EmployeeID, MAX(ReviewDate) AS MaxReviewDate
    FROM fact_performance_reviews
    GROUP BY EmployeeID
) lp ON e.EmployeeID = lp.EmployeeID
JOIN fact_performance_reviews pr
  ON pr.EmployeeID = lp.EmployeeID AND pr.ReviewDate = lp.MaxReviewDate
JOIN (
    SELECT EmployeeID, MAX(SurveyDate) AS MaxSurveyDate
    FROM fact_engagement_surveys
    GROUP BY EmployeeID
) ls ON e.EmployeeID = ls.EmployeeID
JOIN fact_engagement_surveys s
  ON s.EmployeeID = ls.EmployeeID AND s.SurveyDate = ls.MaxSurveyDate
WHERE pr.PerformanceRating >= 4
  AND s.IntentToStayScore <= 2
ORDER BY s.IntentToStayScore, pr.PerformanceRating DESC;

-- 12. Manager span
SELECT
    ManagerName,
    DirectReports,
    ManagerDepartmentID,
    ManagerJobID
FROM fact_manager_span
ORDER BY DirectReports DESC;

-- 13. Headcount trend
SELECT
    SnapshotDate,
    SUM(Headcount) AS TotalHeadcount
FROM fact_headcount_monthly
GROUP BY SnapshotDate
ORDER BY SnapshotDate;

-- 14. Compensation changes
SELECT
    CompensationChangeReason,
    COUNT(*) AS Events,
    AVG(BaseSalary) AS AvgSalaryAfterChange,
    AVG(BonusTargetPct) AS AvgBonusTargetPct
FROM fact_compensation_history
GROUP BY CompensationChangeReason
ORDER BY Events DESC;

-- 15. Candidate conversion by stage
SELECT
    CurrentStage,
    COUNT(*) AS Candidates,
    ROUND(100 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS ShareOfCandidates
FROM fact_candidates
GROUP BY CurrentStage
ORDER BY Candidates DESC;
