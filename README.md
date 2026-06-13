# HR Employee Attrition & Workforce Analytics

![Excel](https://img.shields.io/badge/Excel-Data%20Cleaning%20%26%20Analysis-217346?style=flat&logo=microsoft-excel&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL%2018-SQL%20Analysis-336791?style=flat&logo=postgresql&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-F2C811?style=flat&logo=powerbi&logoColor=black)
![DAX](https://img.shields.io/badge/DAX-12%20Measures-F2C811?style=flat&logo=powerbi&logoColor=black)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen?style=flat)

---

![Dashboard Preview](5_Screenshots/PBI_Dashboard/PBI_P1_Attrition_Overview.png)

## Quick Stats

| | |
|---|---|
| **Dataset** | IBM HR Analytics — 1,470 employees, 35 columns |
| **Tools** | Excel · PostgreSQL 18 · Power BI · DAX · Power Query |
| **Analysis** | 5 pivot tables · 20 SQL queries · 5 dashboard pages · 12 DAX measures |
| **Headline Finding** | $13.61M annual attrition cost · 57.1% compound risk profile |
| **Key Technique** | Cross-tool validation — all Excel findings verified in SQL |

---

## Table of Contents

- [Project Overview](#project-overview)
- [Tools Used](#tools-used)
- [Business Context & Problem Statement](#business-context--problem-statement)
- [Key Findings](#key-findings)
- [Dashboard Walkthrough](#dashboard-walkthrough)
- [Data Cleaning Process](#data-cleaning-process)
- [SQL Analysis](#sql-analysis)
- [DAX Measures](#dax-measures)
- [Assumptions & Limitations](#assumptions--limitations)
- [Strategic Recommendations](#strategic-recommendations)
- [How To Reproduce](#how-to-reproduce)
- [Repository Structure](#repository-structure)
- [Methodology Notes](#methodology-notes)
- [Key Learnings](#key-learnings)
- [Contact](#contact)

---

## Project Overview

This project delivers an end-to-end HR attrition analysis for a mid-size technology company experiencing significant employee turnover. Acting as a Data Analyst engaged by the Chief People Officer, the analysis moves from raw data through structured cleaning, multi-tool analysis, and a five-page interactive Power BI dashboard — culminating in a $13.61M annual cost quantification and actionable retention recommendations.

The analysis demonstrates cross-tool validation methodology: every finding produced in Excel pivot tables was independently verified in PostgreSQL SQL queries, ensuring analytical integrity across the full project.

**Tools Used:** Microsoft Excel · PostgreSQL 18 · Power BI Desktop · DAX · Power Query

**Dataset:** [IBM HR Analytics Employee Attrition & Performance](https://www.kaggle.com/datasets/pavansubhasht/ibm-hr-analytics-attrition-dataset) — Kaggle · 1,470 rows · 35 columns

---

## Tools & Technologies

| Tool | Version | Purpose |
|---|---|---|
| Microsoft Excel | Office 2021 | Data cleaning, pivot table analysis, CHOOSE/IF formulas |
| PostgreSQL | 18 | Relational database, SQL analysis, compound risk profiling |
| Power BI Desktop | Latest | Interactive dashboard, DAX measures, Power Query transformations |
| DAX | — | 12 custom measures across 4 display folders |
| Power Query | — | Custom grouping columns, sort columns, calculated columns |
| GitHub | — | Version control, portfolio hosting |

---

## Business Context & Problem Statement

> *"Who is leaving, why are they leaving, and what will it cost us if we don't act?"*
> — Chief People Officer

Employee attrition has reached a point where it is visibly impacting productivity and project continuity. This analysis answers five core business questions:

| # | Business Question | Answered In |
|---|---|---|
| BQ1 | What is the overall attrition rate, and how does it vary by Department, Job Role, and Gender? | Excel PT1 · SQL Q01–Q04 · Power BI P1 |
| BQ2 | What demographic and job profile characterizes employees most likely to leave? | Excel PT2 · SQL Q05–Q08 · Power BI P2 |
| BQ3 | Do compensation, overtime, and job level significantly correlate with attrition? | Excel PT3 · SQL Q09–Q11 · Power BI P2 |
| BQ4 | Do satisfaction scores predict attrition better than compensation? | Excel PT4 · SQL Q12–Q16 · Power BI P3 |
| BQ5 | What is the estimated annual cost of attrition, and which department and role carries the highest financial risk? | Excel PT5 · SQL Q17–Q18 · Power BI P4 |

---

## Key Findings

### Headline Numbers

| Metric | Value |
|---|---|
| Overall Attrition Rate | 16.1% |
| Employees Left | 237 of 1,470 |
| Estimated Annual Attrition Cost | $13,614,492 |
| Compound Risk Profile Attrition Rate | **57.1%** |
| Average Replacement Cost Per Leaver | $57,445 |
| Estimated Savings (20% Attrition Reduction) | $2,722,898 |

### Finding 1 — Sales Representative: A Structural Retention Crisis (BQ1)

Sales Representative attrition sits at **39.8%** — 23.7 percentage points above the company benchmark of 16.1%. Nearly 2 in every 5 Sales Representatives leave annually. This is not a performance issue — it is a structural retention failure in one specific role that warrants immediate HR intervention.

The Sales department as a whole shows 20.6% attrition (4.5pp above benchmark), while Research & Development at 13.8% is the most stable department despite being the largest (961 employees).

Gender attrition shows a modest gap: Males leave at 17.0% vs Females at 14.8% — a 2.2pp difference that does not represent a primary driver on its own but warrants monitoring when cross-tabbed with overtime and job role.

### Finding 2 — The Compound Risk Profile: 57.1% (BQ2)

Single-variable analysis identifies risk factors individually. Compound analysis reveals their combined effect. Employees matching all four high-risk demographic factors simultaneously:

> **Single + Under 25 + Entry Level + 0–2 Years Tenure**

...leave at a rate of **57.1%** — 41 percentage points above the company benchmark. Of 42 employees matching this profile, 24 left. This finding was identified through SQL compound filtering (Q19) — a capability not efficiently achievable in Excel pivot tables, demonstrating a key advantage of SQL in workforce analytics.

**Individual risk factors ranked by attrition rate:**
- Under 25: 39.2% (+23.1pp)
- Single: 25.5% (+9.4pp)
- 0-2 Years tenure: 29.8% (+13.7pp)
- Entry Level: 26.3% (+10.2pp)
- Below College education: 18.2% (+2.1pp)

The tenure finding is particularly actionable: nearly 1 in 3 employees leaves within their first 2 years. After the 2-year mark, attrition drops sharply and stabilizes — meaning every retention investment in the 0-2 year cohort carries the highest possible ROI.

### Finding 3 — Overtime is the Strongest Binary Predictor (BQ3)

Employees working overtime leave at **30.5%** — nearly 3× the rate of non-overtime employees (10.4%). The 20.1pp gap between these two groups is the largest binary split in the entire dataset.

The overtime effect is not uniform across departments:

| Department | OT Yes | OT No | Multiplier |
|---|---|---|---|
| R&D | 27.3% | 8.6% | 3.2× |
| Sales | 37.5% | 13.8% | 2.7× |
| Human Resources | 29.4% | 15.2% | 1.9× |

R&D presents a particularly important finding: it has the lowest overall attrition (13.8%) but the highest overtime-to-attrition multiplier (3.2×). R&D's stability is entirely dependent on managing overtime exposure — a stable department becomes high-risk when overtime is introduced.

**Compensation also shows a strong signal:** Low income band employees leave at 28.6% versus 4.9% for High income band employees — a 23.7pp spread. An income anomaly was identified: Upper-Mid earners (15.2%) show higher attrition than Lower-Mid earners (12.0%), suggesting other stress factors override compensation effects in mid-range earners — confirmed by satisfaction analysis in BQ4.

### Finding 4 — Job Involvement Outranks Compensation as Attrition Predictor (BQ4)

**Do satisfaction scores predict attrition better than compensation?** Yes — for specific variables, and the effect is comparable or stronger.

**Satisfaction variables ranked by predictive strength (spread between worst and best segment):**

| Rank | Variable | Worst Segment | Best Segment | Spread |
|---|---|---|---|---|
| 1 | Job Involvement | 33.7% (Low) | 9.0% (Very High) | 24.7pp |
| 2 | Work-Life Balance | 31.3% (Bad) | 14.2% (Better) | 17.1pp |
| 3 | Environment Satisfaction | 25.4% (Low) | 13.5% (Very High) | 11.9pp |
| 4 | Job Satisfaction | 22.8% (Low) | 11.3% (Very High) | 11.5pp |
| 5 | Relationship Satisfaction | 20.7% (Low) | 14.8% (Very High) | 5.9pp |

**Key insight:** Low job involvement (33.7%) outranks even overtime (30.5%) as the single highest attrition driver in the dataset. Psychological disengagement is a more powerful attrition force than financial or workload factors alone.

**Notable anomalies documented:**

*Work-Life Balance "Best" anomaly:* Employees rating WLB as "Best" (17.6%) show higher attrition than "Better" (14.2%) — counterintuitive but consistent with a disengagement effect: employees with minimal work pressure may lack the challenge and growth that drives long-term retention.

*Environment Satisfaction threshold effect:* Moving from Low to Medium satisfaction drops attrition by 10.4pp — the single largest improvement achievable from one satisfaction-level upgrade across all variables. The most actionable threshold in the entire analysis.

*Relationship Satisfaction weak signal:* Only a 5.9pp spread between Low and Very High — the weakest predictor of all five satisfaction variables. Once employees rate relationships Medium or above, attrition is essentially flat at ~14.8–15.5%. HR should prioritize addressing toxic relationship situations rather than investing in general team-building programs.

**Stock Option Level finding:** Employees with no stock options leave at 24.4% — 8.3pp above benchmark. Employees with Low stock options leave at only 9.4% — suggesting even small equity grants have a substantial retention effect. The anomalous High option level rate (17.6%) may reflect senior employees with stronger external market demand.

### Finding 5 — Financial Impact: R&D Costs More Than Sales Despite Lower Attrition Rate (BQ5)

| Department | Employees Lost | Avg Monthly Income | Est. Annual Cost |
|---|---|---|---|
| Research & Development | 133 | $4,108 | $6,556,488 |
| Sales | 92 | $5,908 | $6,522,936 |
| Human Resources | 12 | $3,716 | $535,068 |

R&D costs more than Sales despite a 6.8pp lower attrition rate — because R&D loses 41 more employees annually. Volume of departures drives total cost even when rate is lower. This demonstrates why attrition rate alone is insufficient for financial risk assessment: headcount context is essential.

**The salary multiplier effect:** Sales Executive (17.5% attrition, $7,489 avg income) costs $5,122,476 total — 5.5× more than Sales Representative ($936,432) despite Sales Rep having a dramatically higher attrition rate (39.8%). High earners cost disproportionately more to replace, making senior role retention economically critical.

### Finding 6 — Additional Risk Signals (Extended Analysis)

**Business Travel:** Frequent travelers leave at 24.9% (+8.8pp) while non-travelers leave at only 8.0% (-8.1pp). Travel frequency is a clear workload and work-life balance proxy.

**Manager Relationship:** Employees in their first year with a new manager show 28.3% attrition — nearly matching the 0-2 year tenure finding (29.8%). Manager transitions are a high-risk event requiring active HR management. Employees with the same manager for 10+ years show only 4.1% attrition.

**Career Stagnation:** Employees without promotion for 6-10 years show 18.1% attrition — higher than recently promoted employees (17.0%) despite the intuition that settled employees are more stable. This non-monotonic pattern suggests a mid-career plateau effect where career stagnation eventually drives departure.

**Training Investment:** Employees receiving zero training sessions show 27.8% attrition — comparable to overtime employees. Development investment absence is as powerful an attrition driver as workload excess. The non-monotonic spike at 3 sessions (21.1%) may reflect employees being trained for roles they ultimately take elsewhere.

**Job Hopping Profile:** Employees with 6+ prior companies show 20.8% attrition (+4.7pp). First-job employees show only 11.7% attrition — the most stable cohort, likely because they have not yet developed the job-switching habit.

---

## Dashboard Walkthrough

### Page 1 — Attrition Overview (BQ1)
![Page 1](5_Screenshots/PBI_Dashboard/PBI_P1_Attrition_Overview.png)

Five headline KPI cards anchor the page: 16.1% overall attrition rate, 1,470 total employees, 237 employees left, 1,233 retained, and $13.61M estimated annual cost. Two conditional bar charts show attrition by Department and Job Role — bars colored red above the 16.1% benchmark line and blue below, enabling instant risk identification. A donut chart confirms the Yes/No attrition split (16.1% / 83.9%). A Gender bar chart shows the modest 2.2pp gap between Male (17.0%) and Female (14.8%) attrition.

### Page 2 — Attrition Risk Profile & Structural Drivers (BQ2 + BQ3)
![Page 2](5_Screenshots/PBI_Dashboard/PBI_P2_Risk_Profile.png)

Three KPI cards lead the page: the 57.1% compound risk profile (the project's most powerful finding), 30.5% overtime attrition rate, and 10.4% non-overtime rate. Nine bar charts cover all structural risk variables: Age Group, Marital Status, Tenure Group, Overtime Status, Education Level, Job Level, and Income Band. All charts use the same red/blue conditional coloring with benchmark lines for consistency.

### Page 3 — Additional Risk Factors & Career Signals (BQ2 + BQ3 Extended)
![Page 3](5_Screenshots/PBI_Dashboard/PBI_P3_Extended_Risk_Profile.png)

Five additional analyses covering variables not included in the core risk profile: Training Times Last Year, Business Travel frequency, Years Under Current Manager, Years Since Last Promotion, and Number of Companies Worked. Each reveals a distinct attrition signal not visible in the core segmentation — particularly the manager transition risk (28.3% in first year) and the career stagnation plateau effect (6-10 years without promotion: 18.1%).

### Page 4 — Satisfaction & Engagement Drivers (BQ4)
![Page 4](5_Screenshots/PBI_Dashboard/PBI_P4_Satisfaction_Drivers.png)

Three KPI cards highlight the most extreme satisfaction-based attrition rates: Low Job Involvement (33.7%), Bad Work-Life Balance (31.3%), and No Stock Options (24.4%). Six bar charts cover all satisfaction and engagement variables: Job Involvement, Work-Life Balance, Job Satisfaction, Stock Option Level, Environment Satisfaction, and Relationship Satisfaction. The page answers the BQ4 headline question: job involvement outranks compensation as an attrition predictor.

### Page 5 — Financial Impact of Employee Attrition (BQ5)
![Page 5](5_Screenshots/PBI_Dashboard/PBI_P5_Financial_Impact.png)

Four KPI cards: total $13.61M annual cost, $57.45K average replacement cost per leaver, $2.72M cost savings potential from 20% attrition reduction, and $5.12M Sales Executive total attrition cost. Two bar charts show cost by Job Role and by Department. A detailed table provides the full cost breakdown by role with employees lost, average monthly income, and estimated annual cost per role. Conditional gradient formatting on the cost column creates a heat map effect highlighting the most expensive roles.

---

## Data Cleaning Process

### Dataset Overview
- **Source:** IBM HR Analytics Employee Attrition & Performance (Kaggle)
- **Raw dataset:** 1,470 rows · 35 columns
- **Cleaned dataset:** 1,470 rows · 44 columns
- **Tool:** Microsoft Excel

### Structural Validation
Before any transformation, three checks were performed:
- **Duplicates:** 0 found across all 1,470 EmployeeNumber values
- **Null values:** 0 found across all 35 columns
- **Data types:** All columns correctly typed (numeric columns right-aligned, text columns left-aligned)

This validation confirmed the dataset was structurally clean — a finding worth documenting as it demonstrates thoroughness rather than assuming cleanliness.

### Columns Dropped (4)

| Column | Reason |
|---|---|
| EmployeeCount | All values = 1. No analytical value. |
| StandardHours | All values = 80. No analytical value. |
| Over18 | All values = Y. No analytical value. |
| MonthlyRate | Undefined metric — cannot be reliably interpreted or reconciled with MonthlyIncome. Documented and excluded. |

### Binary Flag Columns Created (2)

| Column | Formula | Purpose |
|---|---|---|
| Attrition_Flag | `=IF(B2="Yes",1,0)` | Converts Yes/No text to 1/0 for numeric rate calculations. Ground truth: SUM = 237. |
| OverTime_Flag | `=IF(K2="Yes",1,0)` | Converts Yes/No text to 1/0 for overtime frequency analysis. SUM = 416 (28.3% of workforce). |

**Why binary flags:** Text columns cannot be averaged or summed. A binary flag enables `Attrition Rate % = SUM(Attrition_Flag) / COUNT(Attrition_Flag)` — the foundational rate calculation used throughout the project.

### Labeled Columns Created (8)

Eight coded numeric columns were given text label companions using Excel CHOOSE formula:

```excel
=CHOOSE(C2,"Below College","College","Bachelor","Master","Doctor")
```

| Labeled Column | Source Column | Values |
|---|---|---|
| Education_Label | Education | Below College, College, Bachelor, Master, Doctor |
| EnvironmentSatisfaction_Label | EnvironmentSatisfaction | Low, Medium, High, Very High |
| JobInvolvement_Label | JobInvolvement | Low, Medium, High, Very High |
| JobLevel_Label | JobLevel | Entry, Junior, Mid-Level, Senior, Executive |
| JobSatisfaction_Label | JobSatisfaction | Low, Medium, High, Very High |
| RelationshipSatisfaction_Label | RelationshipSatisfaction | Low, Medium, High, Very High |
| StockOptionLevel_Label | StockOptionLevel | No Options, Low, Medium, High |
| WorkLifeBalance_Label | WorkLifeBalance | Bad, Good, Better, Best |

**Note on CHOOSE:** Works cleanly when codes are consecutive integers starting at 1. StockOptionLevel starts at 0 so the formula uses `=CHOOSE(X2+1,...)` to shift the index.

### Grouping Columns Created (3)

| Column | Bands | Rationale |
|---|---|---|
| Age_Group | Under 25, 25-34, 35-44, 45-54, 55+ | Standard HR workforce segmentation bands |
| Income_Band | Low (<$3K), Lower-Mid ($3K–$7K), Upper-Mid ($7K–$13K), High ($13K+) | Distribution-based quartile-style segmentation |
| Tenure_Group | 0-2 Years, 3-5 Years, 6-10 Years, 11-20 Years, 20+ Years | HR research lifecycle bands — aligns with known attrition risk windows |

### Power Query Columns Created (Power BI Only)

Six additional grouping and sort columns were created in Power BI Power Query for extended analysis:

| Column | Type | Purpose |
|---|---|---|
| NumCompaniesWorked_Group | Text | Groups 0–9 prior employers into: First Job, 1-2, 3-5, 6+ |
| NumCompaniesWorked_Group_Sort | Whole Number | Chronological sort key for above |
| Promotion_Group | Text | Groups YearsSinceLastPromotion into: 0-1, 2-5, 6-10, 10+ Years |
| Promotion_Group_Sort | Whole Number | Chronological sort key for above |
| YearsWithCurrManager_Group | Text | Groups YearsWithCurrManager into: 0-1, 2-5, 6-10, 10+ Years |
| YearsWithCurrManager_Group_Sort | Whole Number | Chronological sort key for above |

**Note:** These columns exist only in the Power BI data model and were not added back to the Excel cleaned dataset.

### DAX Calculated Column (Power BI Only)

| Column | Formula | Purpose |
|---|---|---|
| BusinessTravel_Label | `SWITCH('Cleaned_Data'[BusinessTravel], "Travel_Frequently", "Frequent Travel", "Travel_Rarely", "Rare Travel", "Non-Travel", "No Travel")` | Removes underscores from raw values for readable chart axis labels |

---

## SQL Analysis

**Database:** PostgreSQL 18  
**File:** `3_SQL/Queries/HR_Attrition_SQL_Analysis.sql`  
**Query Results:** `3_SQL/Query_Results/` (20 CSV files)

### Query Index

| Query | Topic | Business Question | Key Finding |
|---|---|---|---|
| Q01 | Overall Attrition Rate | BQ1 | 16.1% — project benchmark |
| Q02 | Attrition by Department | BQ1 | Sales 20.6%, R&D 13.8% |
| Q03 | Attrition by Job Role | BQ1 | Sales Rep 39.8% — critical |
| Q04 | Attrition by Gender | BQ1 | Male 17.0%, Female 14.8% |
| Q05 | Attrition by Age Group | BQ2 | Under 25: 39.2% |
| Q06 | Attrition by Marital Status | BQ2 | Single: 25.5% |
| Q07 | Attrition by Education Level | BQ2 | Below College: 18.2% |
| Q08 | Attrition by Tenure Group | BQ2 | 0-2 Years: 29.8% |
| Q09 | Attrition by Income Band | BQ3 | Low: 28.6%, High: 4.9% |
| Q10 | Attrition by Overtime Status | BQ3 | OT Yes: 30.5% (3× No OT) |
| Q11 | Attrition by Job Level | BQ3 | Entry: 26.3%, Senior: 4.7% |
| Q12 | Attrition by Job Satisfaction | BQ4 | Low: 22.8%, Very High: 11.3% |
| Q13 | Attrition by Environment Satisfaction | BQ4 | Low: 25.4%, Very High: 13.5% |
| Q14 | Attrition by Work-Life Balance | BQ4 | Bad: 31.3%, Better: 14.2% |
| Q15 | Attrition by Relationship Satisfaction | BQ4 | Low: 20.7% — weakest predictor |
| Q16 | Attrition by Job Involvement | BQ4 | Low: 33.7% — strongest predictor |
| Q17 | Cost by Department | BQ5 | R&D $6.56M highest cost |
| Q18 | Cost by Job Role | BQ5 | Sales Executive $5.12M |
| Q19 | Compound Risk Profile | BQ2 Advanced | **57.1%** — SQL-exclusive finding |
| Q20 | Overtime × Department Cross-tab | BQ3 Advanced | R&D: 3.2× overtime multiplier |

### SQL Techniques Used

- `GROUP BY` with `COUNT`, `SUM`, `AVG` for segment-level aggregation
- `AVG(attrition_flag::NUMERIC)` pattern for attrition rate calculation — `::NUMERIC` cast prevents integer division truncation
- `WHERE` filtering for leaver-only cost analysis
- `ROUND()` for consistent 1 decimal place output
- `SUMX`-equivalent approach using `SUM(monthlyincome) * 12` for individual-level cost precision
- Multi-condition `WHERE` with `AND` for compound risk profile isolation (Q19)
- Multi-column `GROUP BY` for cross-tabulation (Q20)

### Cross-Validation

All SQL query results were validated against corresponding Excel pivot table outputs. Zero discrepancies found across all 20 queries — confirming analytical integrity across both tools.

---

## DAX Measures

All measures organized in `HR Measures` table with display folders and descriptions.

### Attrition Core

```dax
Total Employees = COUNTROWS('Cleaned_Data')

Employees Left = SUM('Cleaned_Data'[Attrition_Flag])

Attrition Rate % = DIVIDE([Employees Left], [Total Employees], 0)

Attrition Rate % Label = FORMAT([Attrition Rate %], "0.0%")
```

### Workforce Segments

```dax
OT Employees = SUM('Cleaned_Data'[OverTime_Flag])

OT Attrition Rate % = 
CALCULATE([Attrition Rate %], 'Cleaned_Data'[OverTime] = "Yes")

Non-OT Attrition Rate % = 
CALCULATE([Attrition Rate %], 'Cleaned_Data'[OverTime] = "No")

Low Involvement Attrition Rate = 
CALCULATE([Attrition Rate %], 'Cleaned_Data'[JobInvolvement_Label] = "Low")

Bad WLB Attrition Rate = 
CALCULATE([Attrition Rate %], 'Cleaned_Data'[WorkLifeBalance_Label] = "Bad")
```

### Financial Impact

```dax
Total Annual Attrition Cost = 
SUMX(
    FILTER('Cleaned_Data', 'Cleaned_Data'[Attrition] = "Yes"),
    'Cleaned_Data'[MonthlyIncome] * 12
)

Avg Replacement Cost = DIVIDE([Total Annual Attrition Cost], [Employees Left], 0)

Cost Savings Potential = [Total Annual Attrition Cost] * 0.20
```

### Benchmarks

```dax
Benchmark Line = 0.161

High Risk Segment Rate = 
CALCULATE(
    [Attrition Rate %],
    'Cleaned_Data'[MaritalStatus] = "Single",
    'Cleaned_Data'[Age_Group] = "Under 25",
    'Cleaned_Data'[JobLevel_Label] = "Entry",
    'Cleaned_Data'[Tenure_Group] = "0-2 Years"
)
```

---

## Assumptions & Limitations

### Cost Model Assumptions

**Replacement cost = 100% of annual salary** — Based on SHRM (Society for Human Resource Management) industry standard midpoint. Academic and HR practitioner research consistently estimates replacement costs at 50–200% of annual salary depending on role seniority. A single conservative midpoint was chosen over tiered estimates to maintain methodological transparency and avoid compounding assumption errors.

**20% attrition reduction target** — The $2.72M cost savings potential assumes retaining approximately 47 of the 237 annual leavers through targeted intervention. This is a conservative 12-month program target consistent with industry benchmarks for structured retention initiatives. Actual savings may be higher or lower depending on intervention effectiveness.

**Cost calculations use individual-level SUMX** — `SUM(monthlyincome) * 12` at the employee level rather than `COUNT × AVG × 12` to avoid rounding errors introduced when averaging non-integer salary values before multiplication.

### Dataset Limitations

**Synthetic data:** This dataset was generated by IBM for Watson Analytics demonstration purposes. Numbers follow real HR patterns but were not collected from actual employees. Directional findings are reliable; precise percentages should be interpreted as indicative rather than exact.

**PerformanceRating:** Only values 3 (Excellent) and 4 (Outstanding) exist in this dataset — no employee has a rating of 1 or 2. This eliminates performance rating as a meaningful attrition predictor and was documented but excluded from analysis.

**Compensation columns:** DailyRate, HourlyRate, and MonthlyRate were retained with a documented note that they do not reconcile mathematically with MonthlyIncome. IBM generated these independently. MonthlyIncome was used as the sole compensation metric for all financial calculations.

**Currency:** All monetary values are in USD. Locale formatting in Power BI table visuals defaults to regional system settings — numbers in the financial table reflect whole number format without thousand separators due to a known Power BI locale override behavior.

**Confounding variables:** Several findings likely reflect correlated variables rather than independent effects. Education level and age are positively correlated — higher education holders tend to be older and more senior, so the education attrition gradient may partially reflect age and seniority effects rather than education itself. Multivariate regression would be required to isolate independent effects, which is beyond the scope of this project.

---

## Strategic Recommendations

Based on the analysis findings, the following targeted interventions are recommended in priority order:

**Priority 1 — Early Career Retention Program (Highest ROI)**
The 0-2 year tenure cohort (29.8% attrition, 102 leavers) represents the single highest-volume intervention opportunity. Structured onboarding, assigned mentors, 90-day check-ins, and clear 12-month career path visibility can address the primary drivers of early departure. The compound risk profile (57.1% for Single + Under 25 + Entry + 0-2 Years) identifies the most critical sub-segment for targeted outreach.

**Priority 2 — Overtime Management (Immediate Impact)**
Overtime employees leave at 3× the rate of non-overtime employees. A structured overtime monitoring program — capping sustained overtime at defined thresholds and triggering HR review for employees exceeding limits — addresses the strongest binary attrition predictor identified. R&D is the priority department given its 3.2× overtime multiplier despite overall low attrition.

**Priority 3 — Sales Representative Retention Review**
At 39.8% attrition, Sales Representative is experiencing a structural retention crisis. A dedicated compensation, territory, and workload review for this role is warranted. The average monthly income for Sales Rep leavers is only $2,365 — suggesting compensation may be a primary driver in conjunction with high-pressure targets.

**Priority 4 — Job Involvement & Engagement Programs**
Low job involvement (33.7% attrition) outranks all other single predictors including overtime. Employee engagement initiatives — meaningful project assignment, involvement in decision-making, professional development investment — address the psychological disengagement that drives departure independent of financial factors.

**Priority 5 — Manager Transition Support**
Employees in their first year with a new manager show 28.3% attrition. A structured manager transition program — introduction meetings, 30-60-90 day check-ins, HR facilitated relationship-building — directly addresses this risk window.

**Priority 6 — Equity Compensation Expansion**
Employees with no stock options leave at 24.4% versus 9.4% for Low option holders — a 15pp drop from even a minimal equity grant. Expanding stock option eligibility to currently excluded employees represents a potentially high-impact, relatively low-cost retention lever.

---

## How to Reproduce This Analysis

### Excel Analysis
1. Open `2_Excel_Analysis/HR_Attrition_Cleaned.xlsx`
2. Navigate to sheets PT1 through PT5 for pivot table analysis
3. Raw data preserved in `Raw_Data` sheet — `Cleaned_Data` sheet contains all transformations

### SQL Analysis
1. Install PostgreSQL 18 and pgAdmin
2. Create a database named `hr_attrition`
3. Run `3_SQL/Queries/HR_Attrition_SQL_Analysis.sql` — execute Q00 first to create the table
4. Import `1_Data/Cleaned/HR_Attrition_Cleaned.csv` using pgAdmin Import/Export tool
5. Run Q01–Q20 individually by highlighting each query and pressing F5
6. Expected outputs available in `3_SQL/Query_Results/` for validation

### Power BI Dashboard
1. Open `4_PowerBI/Hr_Attrition.pbix` in Power BI Desktop
2. If data source path error appears: Transform Data → Data Source Settings → update path to your local `HR_Attrition_Cleaned.xlsx` location
3. All 12 DAX measures are in the `HR Measures` table organized by display folder

---

## Repository Structure
HR-Attrition-Workforce-Analytics/

│

├── 1_Data/

│   ├── Raw/

│   │   └── WA_Fn-UseC_-HR-Employee-Attrition.csv

│   └── Cleaned/

│       ├── HR_Attrition_Cleaned.xlsx

│       └── HR_Attrition_Cleaned.csv

│

├── 2_Excel_Analysis/

│   └── HR_Attrition_Cleaned.xlsx

│

├── 3_SQL/
│   ├── Queries/

│   │   └── HR_Attrition_SQL_Analysis.sql

│   └── Query_Results/

│       └── Q01–Q20 CSV files (20 files)

│

├── 4_PowerBI/

│   └── Hr_Attrition.pbix

│

├── 5_Screenshots/

│   ├── DC_Data_Cleaning/

│   ├── Excel_Analysis/

│   ├── SQL_Queries/

│   └── PBI_Dashboard/

│

└── README.md

---

## Methodology Notes

### Why Cross-Tool Validation?
Every Excel pivot table finding was independently reproduced in PostgreSQL SQL. This cross-validation approach serves two purposes: it builds confidence in findings by confirming consistency across different calculation engines, and it demonstrates proficiency in multiple tools on the same analytical problem. Zero discrepancies were found across all 20 validated queries.

### Why Binary Flags Over Text Columns?
The `Attrition` and `OverTime` columns were stored as Yes/No text. Text cannot be averaged or summed in pivot tables or DAX without calculated fields — which have known aggregation errors for percentage calculations. Binary flags (Attrition_Flag: 1/0, OverTime_Flag: 1/0) enable clean rate calculations: `Rate = SUM(Flag) / COUNT(Flag)`. This approach was used consistently across Excel, SQL, and DAX.

### Why Adjacent Formula Columns Instead of Calculated Fields?
Excel Calculated Fields in pivot tables operate on row-level data before aggregation, not on the aggregated values. This produces incorrect results for percentage subtraction (e.g., Delta vs Benchmark). Adjacent cell formula columns referencing the already-aggregated pivot values are always correct. This is a common error in portfolio projects — documenting the correct approach demonstrates deeper analytical maturity.

### Why SUMX for Cost Calculations?
`SUMX(FILTER(...), MonthlyIncome * 12)` calculates each individual leaver's annual salary before summing. The alternative `COUNT × AVG × 12` introduces rounding errors when the average produces a non-integer value — small per employee but meaningful at scale across 237 leavers. Individual-level iteration via SUMX mirrors the SQL `SUM(monthlyincome) * 12` approach used in Q17 and Q18.

---

---

## Key Learnings

**Cross-tool validation builds confidence** — Validating every Excel finding in SQL and finding zero discrepancies confirmed analytical integrity and demonstrated that both tools were being used correctly. Consistency across tools is a portfolio strength.

**Compound segmentation reveals what single-variable analysis misses** — The 57.1% compound risk profile (Q19) was the most powerful finding in the project and could not have been efficiently produced by Excel pivot tables alone. SQL compound filtering unlocked insights invisible to standard BI analysis.

**Calculated Fields in Excel pivot tables are unreliable for rate calculations** — They operate on row-level data before aggregation, producing incorrect percentage subtraction results. Adjacent cell formula columns referencing aggregated pivot values are the correct approach — a lesson that applies to all pivot-based rate analysis.

**Volume drives cost more than rate** — R&D costs more than Sales in total attrition cost despite a 6.8pp lower attrition rate, because it loses 41 more employees annually. Rate-only analysis is insufficient for financial risk prioritization.

**Not all satisfaction variables predict equally** — Relationship satisfaction (5.9pp spread) is a far weaker attrition predictor than job involvement (24.7pp spread). Resource-constrained HR teams should prioritize engagement programs over team-building activities based on this evidence.

**Anomalies are findings, not errors** — The WLB "Best" group showing higher attrition than "Better," the Upper-Mid income inversion, and the 3-session training spike were all documented as analytical findings rather than dismissed. Every anomaly has a plausible business explanation that strengthens the narrative.

---

## Contact

**Aman Lall** — Data Analyst Portfolio  
[GitHub Profile](https://github.com/amannngpt) 
[LinkedIn](https://www.linkedin.com/in/amanlall94/)
[P1: Superstore Sales Analysis](https://github.com/amannngpt/Superstore-Sales-Analysis)

---

*Dataset: IBM HR Analytics Employee Attrition & Performance via Kaggle. Synthetic dataset generated for demonstration purposes.*
