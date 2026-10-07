# HR Workforce & Talent Analytics

## Project Overview

**HR Workforce & Talent Analytics** is an end-to-end Data Analyst
project built to analyze workforce composition, employee performance,
talent development, compensation, recruitment effectiveness, employee
engagement, and attrition.

The project combines **Python, MySQL, Power BI, DAX and Excel** to
transform a multi-table HR dataset into an interactive four-page
executive analytics solution.

### Dashboard Story

**WORKFORCE → TALENT → COMPENSATION & RECRUITMENT → RETENTION**

------------------------------------------------------------------------

## Dashboard Screenshots

### Page 1 --- Executive Workforce Overview

![Executive Workforce
Overview]("D:\data_analyst_projects\hr_analytics_project\main\powerbi\screenshots\01-executive-workforce-overview.png")

### Page 2 --- Employee & Talent Analytics

![Employee & Talent
Analytics]("D:\data_analyst_projects\hr_analytics_project\main\powerbi\screenshots\02-employee-talent-analytics.png")

### Page 3 --- Compensation & Recruitment

![Compensation &
Recruitment]("D:\data_analyst_projects\hr_analytics_project\main\powerbi\screenshots\03-compensation-recruitment.png")

### Page 4 --- Attrition & Retention

![Attrition & Retention]("D:\data_analyst_projects\hr_analytics_project\main\powerbi\screenshots\04-attrition-retention.png")


------------------------------------------------------------------------

## Business Objectives

-   Analyze workforce size, structure and employee status.
-   Identify departments and locations with the largest employee
    populations.
-   Measure and compare employee attrition.
-   Analyze employee performance and high performers.
-   Evaluate promotions, training and engagement.
-   Analyze salary, bonus and total compensation.
-   Evaluate recruitment funnel performance and recruitment sources.
-   Identify potential retention risks.
-   Turn HR data into actionable business insights.

------------------------------------------------------------------------

## Technology Stack

  Tool       Purpose
  ---------- -----------------------------------------------------
  Python     Data cleaning, preparation, validation and analysis
  MySQL      SQL analysis,Business analysis, queries and analytical views
  Power BI   Interactive dashboards and visualization
  DAX        KPI calculations and analytical measures
  Excel      Data-quality checks and supporting analysis
  GitHub     Portfolio presentation and version control

------------------------------------------------------------------------

# Dataset

The project uses a synthetic enterprise HR analytics dataset containing
multiple dimension and fact tables.

The dataset covers:

-   Employees
-   Employee demographics
-   Departments
-   Jobs
-   Locations
-   Current employee information
-   Compensation history
-   Performance reviews
-   Engagement surveys
-   Learning completions
-   Leave events
-   Promotions
-   Requisitions
-   Candidates
-   Monthly headcount
-   Manager span

The project contains approximately **229K records across 16 tables**,
providing a realistic multi-table environment for an HR analytics
portfolio project.

### Data Modeling

**Dimension tables** contain descriptive information about entities such
as employees, departments, jobs and locations.

**Fact tables** contain measurable events and records such as
compensation changes, performance reviews, promotions, training,
recruitment activity, engagement and headcount.

------------------------------------------------------------------------

# Dashboard Structure & Real Results

## Page 1 --- Executive Workforce Overview

### Business Question

> **What does our workforce look like?**

### KPI Results

  KPI                  Real Dashboard Value
  ------------------ ----------------------
  Total Employees                **10,000**
  Active Employees                **9,087**
  Attrition Rate                   **9.1%**
  Average Salary                   **106K**
  Average Tenure                   **6.42**
  Total Promotions                **1,985**

### Employees by Department

  Department           Employees
  ------------------ -----------
  Engineering           **2.7K**
  Sales                 **1.4K**
  Operations            **1.1K**
  Customer Support      **0.9K**
  IT                    **0.8K**
  Marketing             **0.8K**
  Product               **0.7K**
  HR                    **0.7K**
  Finance               **0.6K**
  Legal                 **0.1K**
  Executive             **0.1K**

### Workforce by Location

  Location           Employees
  ---------------- -----------
  Austin             **1,164**
  Las Vegas          **1,012**
  Seattle              **851**
  Remote-East          **827**
  Chicago              **818**
  Remote-Central       **811**
  Phoenix              **800**
  Miami                **793**
  Remote-West          **762**
  Atlanta              **748**
  Denver               **725**
  Nashville            **689**

### Attrition Rate by Department

  Department           Attrition Rate
  ------------------ ----------------
  Sales                     **12.2%**
  Marketing                 **11.6%**
  Customer Support          **10.8%**
  HR                         **9.6%**
  IT                         **9.3%**
  Engineering                **8.4%**
  Legal                      **7.4%**
  Operations                 **6.9%**
  Finance                    **6.9%**
  Product                    **6.8%**
  Executive                  **4.9%**

------------------------------------------------------------------------

# Page 2 --- Employee & Talent Analytics

### Business Question

> **How are employees performing, developing and progressing?**

### KPI Results

  KPI                           Real Dashboard Value
  --------------------------- ----------------------
  Average Performance Score             **3.42 / 5**
  High Performers                          **7,617**
  Total Promotions                         **1,985**
  Training Completion Rate                **100.0%**
  Average Engagement Score              **3.72 / 5**

### Promotions by Department

  Department           Promotions
  ------------------ ------------
  Engineering             **545**
  Sales                   **285**
  Operations              **216**
  Customer Support        **194**
  Marketing               **172**
  HR                      **148**
  IT                      **147**
  Product                 **143**
  Finance                 **117**
  Legal                    **18**

### Promotion Trend

  Month         Promotions
  ----------- ------------
  January          **189**
  February         **128**
  March            **160**
  April            **164**
  May              **135**
  June             **148**
  July             **172**
  August           **191**
  September        **180**
  October          **163**
  November         **174**
  December         **181**

The monthly promotion values total **1,985**, matching the dashboard
KPI.

### Training Participation by Department

  Department           Training Records
  ------------------ ------------------
  Engineering                  **7.6K**
  Sales                        **4.1K**
  Operations                   **3.3K**
  Customer Support             **2.6K**
  Marketing                    **2.3K**
  IT                           **2.3K**
  Product                      **2.2K**
  HR                           **1.9K**
  Finance                      **1.9K**
  Legal                        **0.4K**
  Executive                    **0.2K**

------------------------------------------------------------------------

# Page 3 --- Compensation & Recruitment

### Business Question

> **How much are we paying employees, and how effective is recruitment?**

### KPI Results

  KPI                    Real Dashboard Value
  -------------------- ----------------------
  Average Salary                     **115K**
  Average Bonus                        **9K**
  Total Compensation                **1.2bn**
  Highest Salary                     **832K**
  Hires                             **2,345**

### Recruitment Funnel

  Recruitment Stage     Candidates
  ------------------- ------------
  Applied                **4,623**
  Interview              **4,143**
  Rejected               **3,790**
  Phone Screen           **3,572**
  Final Interview        **2,579**
  Hired                  **2,345**
  Offer Extended         **1,969**
  Withdrawn                **979**

### Candidates by Source

  Recruitment Source     Candidates
  -------------------- ------------
  LinkedIn                 **5.6K**
  Indeed                   **4.6K**
  Career Site              **3.8K**
  Referral                 **3.3K**
  Agency                   **1.9K**
  Campus                   **1.7K**
  Internal                 **1.6K**
  Network                  **1.4K**

### Hires by Source

  Recruitment Source       Hires
  -------------------- ---------
  LinkedIn               **510**
  Indeed                 **471**
  Career Site            **386**
  Referral               **329**
  Agency                 **175**
  Campus                 **174**
  Internal               **153**
  Network                **147**

### Average Salary by Department

  Department           Average Salary
  ------------------ ----------------
  Executive                 **0.44M**
  Legal                     **0.14M**
  Product                   **0.13M**
  Operations                **0.13M**
  Finance                   **0.13M**
  Engineering               **0.11M**
  HR                        **0.11M**
  Sales                     **0.10M**
  Marketing                 **0.10M**
  Customer Support          **0.10M**
  IT                        **0.10M**

------------------------------------------------------------------------

# Page 4 --- Attrition & Retention

### Business Question

> **Why are employees leaving and which employees are at risk?**

### KPI Results

  KPI                         Real Dashboard Value
  ------------------------- ----------------------
  Attrition Rate                          **9.1%**
  Churned Employees                        **913**
  Average Tenure of Exits                 **6.04**
  High Performers at Risk                **3,597**
  Average Engagement                  **3.72 / 5**

### Attrition Rate by Department

  Department           Attrition Rate
  ------------------ ----------------
  Sales                     **12.2%**
  Marketing                 **11.6%**
  Customer Support          **10.8%**
  HR                         **9.6%**
  IT                         **9.3%**
  Engineering                **8.4%**
  Legal                      **7.4%**
  Operations                 **6.9%**
  Finance                    **6.9%**
  Product                    **6.8%**
  Executive                  **4.9%**

------------------------------------------------------------------------

# Key Insights from the Dashboards

## 1. Workforce size and active workforce

The organization has **10,000 employees**, of whom **9,087 are active**.
The dashboard reports **913 churned employees** and an overall attrition
rate of **9.1%**.

## 2. Engineering is the largest department

Engineering has approximately **2.7K employees**, making it the largest
department. It also has the highest number of promotions at **545**.

## 3. Sales has the highest attrition

Sales has the highest departmental attrition at **12.2%**, followed by
Marketing at **11.6%** and Customer Support at **10.8%**. These
departments should be prioritized for deeper retention analysis.

## 4. Executive has the lowest attrition

Executive has the lowest displayed attrition at **4.9%**, while Product
(**6.8%**), Operations (**6.9%**) and Finance (**6.9%**) also have
comparatively lower attrition.

## 5. High performers are a major talent segment

The Talent dashboard reports **7,617 high performers**. Relative to
10,000 total employees, that is approximately **76.2%** of the workforce
based on the dashboard figures.

## 6. High-performer retention is a major risk

The Retention dashboard identifies **3,597 high performers at risk**.
This is a critical finding because losing high-performing employees can
affect productivity, knowledge retention and leadership capacity.

## 7. Engagement and performance

Average engagement is **3.72 / 5**, while average performance is **3.42
/ 5**. The scatter visuals allow HR teams to investigate how engagement
and performance vary across departments and how they relate to
attrition.

## 8. Training completion is very high

Training completion is reported as **100.0%** for the records included
in the dashboard calculation. Engineering has approximately **7.6K
training records**, followed by Sales at **4.1K** and Operations at
**3.3K**.

## 9. Promotions are concentrated in Engineering

Engineering leads with **545 promotions**, followed by Sales (**285**)
and Operations (**216**). Total promotions are **1,985**.

## 10. August has the highest monthly promotion count

The promotion trend peaks at **191 promotions in August**, while
February has the lowest displayed monthly value at **128**.

## 11. LinkedIn is the leading recruitment source

LinkedIn generates approximately **5.6K candidates** and **510 hires**,
making it the leading recruitment source shown. Indeed follows with
**4.6K candidates** and **471 hires**.

## 12. Compensation is significant at organizational scale

The Compensation dashboard reports **115K average salary**, **9K average
bonus**, **1.2bn total compensation**, and **832K highest salary**.

------------------------------------------------------------------------

# Dashboard Features

The four Power BI pages include:

-   Executive KPI cards
-   Interactive slicers
-   Department analysis
-   Location analysis
-   Attrition analysis
-   Performance analysis
-   Promotion analysis
-   Training analysis
-   Engagement analysis
-   Compensation analysis
-   Recruitment funnel
-   Recruitment-source analysis
-   Performance vs Attrition analysis
-   Consistent page navigation

### Common Filters

-   Department
-   Job
-   Location
-   Employment Status
-   Gender

------------------------------------------------------------------------

# Analytical Workflow

``` text
Raw HR CSV Files
        ↓
Python Data Cleaning & Validation
        ↓
Cleaned HR Data
        ↓
MySQL Database
        ↓
SQL Queries & Analytical Views
        ↓
Power BI Data Model
        ↓
DAX Measures
        ↓
Interactive 4-Page Dashboard
        ↓
Business Insights
```

------------------------------------------------------------------------

# Skills Demonstrated

-   Data cleaning and preprocessing
-   Exploratory data analysis
-   Data quality validation
-   MySQL database management
-   SQL querying
-   Relational data modeling
-   DAX measure development
-   Power BI dashboard development
-   KPI design
-   Workforce analytics
-   HR analytics
-   Attrition and retention analysis
-   Talent analytics
-   Recruitment analytics
-   Compensation analytics
-   Employee engagement analysis
-   Business storytelling
-   Dashboard design

------------------------------------------------------------------------

# Portfolio Value

This project demonstrates the ability to work with a complex multi-table
enterprise-style HR dataset and convert raw HR information into an
executive-level business intelligence solution.

**Core stack: Python + MySQL + Power BI + DAX + Excel**

The project is suitable for Data Analyst, Business Intelligence, HR
Analytics, People Analytics and Reporting roles.

------------------------------------------------------------------------

# Final Business Takeaways

  Area                              Key Finding
  --------------------------------- --------------------------------------
  Workforce                         **10,000 employees**
  Active Workforce                  **9,087 employees**
  Attrition                         **9.1%**
  Churned Employees                 **913**
  Largest Department                **Engineering --- \~2.7K employees**
  Highest Attrition                 **Sales --- 12.2%**
  Lowest Attrition                  **Executive --- 4.9%**
  High Performers                   **7,617**
  High Performers at Risk           **3,597**
  Average Performance               **3.42 / 5**
  Average Engagement                **3.72 / 5**
  Training Completion               **100.0%**
  Total Promotions                  **1,985**
  Highest Promotion Month           **August --- 191**
  Average Salary --- Overview       **106K**
  Average Salary --- Compensation   **115K**
  Average Bonus                     **9K**
  Highest Salary                    **832K**
  Total Compensation                **1.2bn**
  Total Hires                       **2,345**
  Leading Recruitment Source        **LinkedIn --- 510 hires**

------------------------------------------------------------------------

# Conclusion

The **HR Workforce & Talent Analytics** project transforms complex HR
data into a four-page interactive decision-support solution.

The dashboards show a workforce of **10,000 employees**, with **9.1%
attrition** and **913 churned employees**. Engineering is the largest
department, while Sales has the highest attrition at **12.2%**.

The talent analysis shows **7,617 high performers**, while **3,597 high
performers are identified as at risk**, making retention a major
management priority. Employee engagement stands at **3.72/5**, while
average performance is **3.42/5**.

The recruitment analysis shows LinkedIn as the leading source by
candidate volume and hires. The compensation analysis reports **115K
average salary, 9K average bonus, 1.2bn total compensation and 832K
highest salary**.

Overall, the project demonstrates how a Data Analyst can combine
**Python, MySQL, DAX and Power BI** to transform raw enterprise HR
data into clear, actionable business insights.
