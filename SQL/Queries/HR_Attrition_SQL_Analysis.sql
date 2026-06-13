-- ============================================================
-- HR ATTRITION ANALYSIS — COMPLETE SQL QUERY DOCUMENTATION
-- Dataset: IBM HR Analytics Employee Attrition & Performance
-- Source: Kaggle (IBM Watson Analytics)
-- Database: PostgreSQL 18/hr_attrition
-- Total Queries: 20 (Q00 Schema + Q01-Q20 Analysis)
-- Author: [Aman Lall]
-- ============================================================
-- BUSINESS QUESTIONS COVERED:
-- BQ1: Attrition rate by Department, Job Role, Gender
-- BQ2: Demographic & job profile of high-risk employees
-- BQ3: Compensation, overtime, job level vs attrition
-- BQ4: Satisfaction scores vs attrition
-- BQ5: Estimated annual cost of attrition
-- Advanced: Compound risk profiling, overtime cross-tab
-- ============================================================





-- ============================================================
-- Q00: CREATE TABLE SCHEMA
-- Purpose: Define table structure for cleaned HR dataset
-- Columns: 44 total
-- Dropped from original 35: EmployeeCount, StandardHours,
--                           Over18, MonthlyRate
-- Added during cleaning: 2 binary flags, 8 labeled columns,
--                        3 grouping columns
-- Run this once before importing data
-- ============================================================

CREATE TABLE hr_attrition (
    Age                        		INTEGER,
    Attrition                  		VARCHAR(3),
    BusinessTravel             		VARCHAR(50),
    DailyRate                  		INTEGER,
    Department                 		VARCHAR(50),
    DistanceFromHome           		INTEGER,
    Education                  		INTEGER,
    EducationField             		VARCHAR(50),
    EmployeeNumber             		INTEGER,
    EnvironmentSatisfaction    		INTEGER,
    Gender                     		VARCHAR(10),
    HourlyRate                 		INTEGER,
    JobInvolvement             		INTEGER,
    JobLevel                   		INTEGER,
    JobRole                    		VARCHAR(50),
    JobSatisfaction            		INTEGER,
    MaritalStatus              		VARCHAR(20),
    MonthlyIncome              		INTEGER,
    NumCompaniesWorked         		INTEGER,
    OverTime                   		VARCHAR(3),
    PercentSalaryHike          		INTEGER,
    PerformanceRating          		INTEGER,
    RelationshipSatisfaction   		INTEGER,
    StockOptionLevel           		INTEGER,
    TotalWorkingYears          		INTEGER,
    TrainingTimesLastYear      		INTEGER,
    WorkLifeBalance            		INTEGER,
    YearsAtCompany             		INTEGER,
    YearsInCurrentRole         		INTEGER,
    YearsSinceLastPromotion    		INTEGER,
    YearsWithCurrManager       		INTEGER,
    Attrition_Flag             		INTEGER,
    OverTime_Flag              		INTEGER,
    Education_Label            		VARCHAR(20),
    EnvironmentSatisfaction_Label  	VARCHAR(20),
    JobInvolvement_Label       		VARCHAR(20),
    JobLevel_Label             		VARCHAR(20),
    JobSatisfaction_Label      		VARCHAR(20),
    RelationshipSatisfaction_Label 	VARCHAR(20),
    StockOptionLevel_Label     		VARCHAR(20),
    WorkLifeBalance_Label      		VARCHAR(20),
    Age_Group                  		VARCHAR(20),
    Income_Band                		VARCHAR(20),
    Tenure_Group               		VARCHAR(20)
);

SELECT COUNT(*) FROM hr_attrition; -- VALIDATION CHECKS (not analysis queries)
SELECT * FROM hr_attrition LIMIT 5; -- VALIDATION CHECKS (not analysis queries)





-- ============================================================
-- Q01: OVERALL ATTRITION RATE
-- Business Question: BQ1
-- Purpose: Establish company-wide attrition benchmark
-- Expected: 16.1% | Validates against Excel PT1
-- Key Concept: AVG of binary 0/1 flag = attrition rate
--              ::NUMERIC cast prevents integer division
-- ============================================================

SELECT	SUM(attrition_flag) AS employees_left,
		COUNT(*) AS total_employees,
		ROUND(AVG(attrition_flag :: NUMERIC)*100,1) AS attrition_rate_pct
FROM hr_attrition;





-- ============================================================
-- Q02: ATTRITION RATE BY DEPARTMENT
-- Business Question: BQ1
-- Purpose: Identify highest risk department
-- Expected: Sales 20.6% | HR 19.0% | R&D 13.8%
-- Finding: Sales is 4.5pp above company benchmark
-- Validates against Excel PT1
-- ============================================================

SELECT 	department,
		SUM(attrition_flag) AS employees_left,
		COUNT(*) AS total_employees,
		ROUND(AVG(attrition_flag :: NUMERIC)*100,1) AS attrition_rate_pct	
FROM hr_attrition
GROUP BY department
ORDER BY attrition_rate_pct DESC;





-- ============================================================
-- Q03: ATTRITION RATE BY JOB ROLE
-- Business Question: BQ1
-- Purpose: Identify highest risk job roles
-- Expected: Sales Rep 39.8% critical | Research Director 2.5% stable
-- Finding: Sales Rep is 23.7pp above benchmark -- retention crisis
-- Validates against Excel PT1
-- ============================================================

SELECT  jobrole,
		SUM(attrition_flag) AS employees_left,
		COUNT(*) AS total_employees,
		ROUND(AVG(attrition_flag :: NUMERIC)*100,1) AS attrition_rate_pct
FROM hr_attrition
GROUP BY jobrole
ORDER BY attrition_rate_pct DESC;





-- ============================================================
-- Q04: ATTRITION RATE BY GENDER
-- Business Question: BQ1
-- Purpose: Identify whether gender affects attrition rate
-- Expected: Male 17.0% | Female 14.8%
-- Finding: 2.2pp gap -- modest difference, not a primary driver
-- Validates against Excel PT1
-- ============================================================

SELECT  gender,
		SUM(attrition_flag) AS employees_left,
		COUNT(*) AS total_employees,
		ROUND(AVG(attrition_flag :: NUMERIC)*100,1) AS attrition_rate_pct
FROM hr_attrition
GROUP BY gender
ORDER BY attrition_rate_pct DESC;





-- ============================================================
-- Q05: ATTRITION RATE BY AGE GROUP
-- Business Question: BQ2
-- Purpose: Identify which career stage has highest flight risk
-- Expected: Under 25 at 39.2% | 35-44 most stable at 10.1%
-- Finding: Attrition drops 29pp between Under 25 and 35-44
-- Validates against Excel PT2
-- ============================================================

SELECT  age_group,
		SUM(attrition_flag) AS employees_left,
		COUNT(*) AS total_employees,
		ROUND(AVG(attrition_flag :: NUMERIC)*100,1) AS attrition_rate_pct
FROM hr_attrition
GROUP BY age_group
ORDER BY attrition_rate_pct DESC;





-- ============================================================
-- Q06: ATTRITION RATE BY MARITAL STATUS
-- Business Question: BQ2
-- Purpose: Test whether personal life stage affects attrition
-- Expected: Single 25.5% | Married 12.5% | Divorced 10.1%
-- Finding: Single employees leave at 2.5x rate of divorced
-- Validates against Excel PT2
-- ============================================================

SELECT  maritalstatus,
		SUM(attrition_flag) AS employees_left,
		COUNT(*) AS total_employees,
		ROUND(AVG(attrition_flag :: NUMERIC)*100,1) AS attrition_rate_pct
FROM hr_attrition
GROUP BY maritalstatus
ORDER BY attrition_rate_pct DESC;





-- ============================================================
-- Q07: ATTRITION RATE BY EDUCATION LEVEL
-- Business Question: BQ2
-- Purpose: Test whether education level affects attrition
-- Expected: Below College 18.2% | Doctor 10.4%
-- Finding: Inverse relationship -- higher education correlates
--          with lower attrition. Effect may be confounded
--          with age and seniority.
-- Validates against Excel PT2
-- ============================================================

SELECT  education_label,
		SUM(attrition_flag) AS employees_left,
		COUNT(*) AS total_employees,
		ROUND(AVG(attrition_flag :: NUMERIC)*100,1) AS attrition_rate_pct
FROM hr_attrition
GROUP BY education_label
ORDER BY attrition_rate_pct DESC;





-- ============================================================
-- Q08: ATTRITION RATE BY TENURE GROUP
-- Business Question: BQ2
-- Purpose: Identify when in the employee lifecycle attrition
--          risk is highest
-- Expected: 0-2 Years 29.8% | 11-20 Years 6.7%
-- Finding: 1 in 3 employees leaves within first 2 years.
--          Attrition drops sharply after the 2-year mark.
-- Validates against Excel PT2
-- ============================================================

SELECT  tenure_group,
		SUM(attrition_flag) AS employees_left,
		COUNT(*) AS total_employees,
		ROUND(AVG(attrition_flag :: NUMERIC)*100,1) AS attrition_rate_pct
FROM hr_attrition
GROUP BY tenure_group
ORDER BY attrition_rate_pct DESC;





-- ============================================================
-- Q09: ATTRITION RATE BY INCOME BAND
-- Business Question: BQ3
-- Purpose: Test whether compensation level drives attrition
-- Expected: Low 28.6% | High 4.9%
-- Finding: Low earners leave at nearly 6x rate of high earners.
--          Upper-Mid anomaly (15.2% > Lower-Mid 12.0%) suggests
--          other stress factors override compensation effect
--          in mid-range earners -- investigated in BQ4.
-- Validates against Excel PT3
-- ============================================================

SELECT  income_band,
		SUM(attrition_flag) AS employees_left,
		COUNT(*) AS total_employees,
		ROUND(AVG(attrition_flag :: NUMERIC)*100,1) AS attrition_rate_pct
FROM hr_attrition
GROUP BY income_band
ORDER BY attrition_rate_pct DESC;





-- ============================================================
-- Q10: ATTRITION RATE BY OVERTIME STATUS
-- Business Question: BQ3
-- Purpose: Quantify overtime impact on attrition
-- Expected: OT Yes 30.5% | OT No 10.4%
-- Finding: OT employees leave at 3x the rate of non-OT.
--          Overtime is the strongest binary predictor tested.
-- Validates against Excel PT3
-- ============================================================

SELECT  overtime,
		SUM(attrition_flag) AS employees_left,
		COUNT(*) AS total_employees,
		ROUND(AVG(attrition_flag :: NUMERIC)*100,1) AS attrition_rate_pct
FROM hr_attrition
GROUP BY overtime
ORDER BY attrition_rate_pct DESC;





-- ============================================================
-- Q11: ATTRITION RATE BY JOB LEVEL
-- Business Question: BQ3
-- Purpose: Test whether seniority protects against attrition
-- Expected: Entry 26.3% | Senior 4.7%
-- Finding: Clear inverse relationship between seniority
--          and attrition. Entry level is 10.2pp above benchmark.
-- Validates against Excel PT3
-- ============================================================

SELECT  joblevel_label,
		SUM(attrition_flag) AS employees_left,
		COUNT(*) AS total_employees,
		ROUND(AVG(attrition_flag :: NUMERIC)*100,1) AS attrition_rate_pct
FROM hr_attrition
GROUP BY joblevel_label
ORDER BY attrition_rate_pct DESC;





-- ============================================================
-- Q12: ATTRITION RATE BY JOB SATISFACTION
-- Business Question: BQ4
-- Purpose: Test whether job satisfaction predicts attrition
-- Expected: Low 22.8% | Very High 11.3%
-- Finding: 11.5pp spread. Low satisfaction clearly elevated
--          but High and Medium nearly identical at benchmark.
-- Validates against Excel PT4
-- ============================================================

SELECT  jobsatisfaction_label,
		SUM(attrition_flag) AS employees_left,
		COUNT(*) AS total_employees,
		ROUND(AVG(attrition_flag :: NUMERIC)*100,1) AS attrition_rate_pct
FROM hr_attrition
GROUP BY jobsatisfaction_label
ORDER BY attrition_rate_pct DESC;




-- ============================================================
-- Q13: ATTRITION RATE BY ENVIRONMENT SATISFACTION
-- Business Question: BQ4
-- Purpose: Test whether workplace environment predicts attrition
-- Expected: Low 25.4% | Very High 13.5%
-- Finding: Cleanest monotonic pattern of all satisfaction
--          variables. Moving from Low to Medium drops
--          attrition by 10.4pp -- most actionable threshold.
-- Validates against Excel PT4
-- ============================================================

SELECT  environmentsatisfaction_label,
		SUM(attrition_flag) AS employees_left,
		COUNT(*) AS total_employees,
		ROUND(AVG(attrition_flag :: NUMERIC)*100,1) AS attrition_rate_pct
FROM hr_attrition
GROUP BY environmentsatisfaction_label
ORDER BY attrition_rate_pct DESC;





-- ============================================================
-- Q14: ATTRITION RATE BY WORK LIFE BALANCE
-- Business Question: BQ4
-- Purpose: Test whether work-life balance predicts attrition
-- Expected: Bad 31.3% | Better 14.2%
-- Finding: Bad WLB nearly matches overtime attrition (30.5%).
--          Best WLB anomaly (17.6% > Better 14.2%) suggests
--          disengagement effect in low-pressure roles.
-- Validates against Excel PT4
-- ============================================================

SELECT  worklifebalance_label,
		SUM(attrition_flag) AS employees_left,
		COUNT(*) AS total_employees,
		ROUND(AVG(attrition_flag :: NUMERIC)*100,1) AS attrition_rate_pct
FROM hr_attrition
GROUP BY worklifebalance_label
ORDER BY attrition_rate_pct DESC;





-- ============================================================
-- Q15: ATTRITION RATE BY RELATIONSHIP SATISFACTION
-- Business Question: BQ4
-- Purpose: Test whether workplace relationships predict attrition
-- Expected: Low 20.7% | Very High 14.8%
-- Finding: Weakest satisfaction predictor -- only 5.9pp spread.
--          Improving relationships beyond Medium has minimal
--          additional retention impact.
-- Validates against Excel PT4
-- ============================================================

SELECT  relationshipsatisfaction_label,
		SUM(attrition_flag) AS employees_left,
		COUNT(*) AS total_employees,
		ROUND(AVG(attrition_flag :: NUMERIC)*100,1) AS attrition_rate_pct
FROM hr_attrition
GROUP BY relationshipsatisfaction_label
ORDER BY attrition_rate_pct DESC;





-- ============================================================
-- Q16: ATTRITION RATE BY JOB INVOLVEMENT
-- Business Question: BQ4
-- Purpose: Test whether psychological engagement predicts
--          attrition better than compensation
-- Expected: Low 33.7% | Very High 9.0%
-- Finding: Strongest satisfaction predictor -- 24.7pp spread.
--          Low involvement outranks overtime (30.5% vs 33.7%)
--          as single highest attrition driver in the dataset.
-- Validates against Excel PT4
-- ============================================================

SELECT  jobinvolvement_label,
		SUM(attrition_flag) AS employees_left,
		COUNT(*) AS total_employees,
		ROUND(AVG(attrition_flag :: NUMERIC)*100,1) AS attrition_rate_pct
FROM hr_attrition
GROUP BY jobinvolvement_label
ORDER BY attrition_rate_pct DESC;





-- ============================================================
-- Q17: ESTIMATED ANNUAL ATTRITION COST BY DEPARTMENT
-- Business Question: BQ5
-- Purpose: Convert attrition into financial impact by dept
-- Assumption: Replacement cost = 100% of annual salary
--             (SHRM industry standard midpoint)
-- Expected: R&D ~$6.5M | Sales ~$6.5M | HR ~$535K
-- Finding: R&D costs more than Sales despite lower rate --
--          volume of departures drives total cost
-- Note: SUM(monthlyincome)*12 used for precision over
--       COUNT*AVG*12 to avoid averaging averages
-- Validates against Excel PT5
-- ============================================================

SELECT
    department,
    COUNT(*)                          AS employees_lost,
    ROUND(AVG(monthlyincome), 0)      AS avg_monthly_income,
    ROUND(SUM(monthlyincome) * 12, 0) AS est_annual_attrition_cost
FROM hr_attrition
WHERE attrition = 'Yes'
GROUP BY department
ORDER BY est_annual_attrition_cost DESC;





-- ============================================================
-- Q18: ESTIMATED ANNUAL ATTRITION COST BY JOB ROLE
-- Business Question: BQ5
-- Purpose: Identify which role carries highest financial risk
-- Assumption: Replacement cost = 100% of annual salary
-- Expected: Sales Executive highest at ~$5.1M
-- Finding: Sales Executive costs 5x more than Sales Rep
--          despite lower attrition rate -- salary multiplier
--          effect means high earners cost far more to replace
-- Validates against Excel PT5
-- ============================================================

SELECT
    jobrole,
    COUNT(*)                          AS employees_lost,
    ROUND(AVG(monthlyincome), 0)      AS avg_monthly_income,
    ROUND(SUM(monthlyincome) * 12, 0) AS est_annual_attrition_cost
FROM hr_attrition
WHERE attrition = 'Yes'
GROUP BY jobrole
ORDER BY est_annual_attrition_cost DESC;





-- ============================================================
-- Q19: COMPOUND HIGH RISK PROFILE ANALYSIS
-- Business Question: BQ2 Advanced
-- Purpose: Quantify attrition rate for employees matching
--          ALL four high-risk demographic factors simultaneously
-- High risk profile: Single + Under 25 + Entry + 0-2 Years
-- Profile identified from individual segment analysis in PT2
-- SQL Advantage: This compound filtering is not efficiently
--          achievable in Excel pivot tables -- demonstrates
--          SQL capability beyond pivot table analysis
-- Key Concept: AND chains multiple WHERE conditions --
--          every condition must be true for row inclusion
-- ============================================================

SELECT maritalstatus,
	   age_group,
	   joblevel_label,
	   tenure_group,
	   SUM(attrition_flag) AS employees_left,
	   COUNT(*) AS total_employees,
	   ROUND(AVG(attrition_flag :: NUMERIC)*100,1) AS attrition_rate_pct
FROM hr_attrition
WHERE	maritalstatus = 'Single'
 AND 	age_group = 'Under 25'
 AND	joblevel_label = 'Entry'
 AND	tenure_group = '0-2 Years'
GROUP BY maritalstatus, age_group, joblevel_label, tenure_group;





-- ============================================================
-- Q20: OVERTIME AND ATTRITION RATE BY DEPARTMENT
-- Business Question: BQ3 Advanced
-- Purpose: Test whether overtime risk is uniform across
--          departments or concentrated in specific areas
-- Expected: R&D OT 27.3% vs R&D No OT 8.6% (3.2x ratio)
--           Sales OT 37.5% vs Sales No OT 13.8% (2.7x ratio)
-- Finding: R&D most sensitive to overtime despite lowest
--          overall attrition -- stable department becomes
--          high risk when overtime is introduced
-- Key Concept: GROUP BY two columns creates one row per
--          unique combination of both columns
-- Validates against Excel PT3 cross-tab
-- ============================================================

SELECT department,
       overtime,
	   SUM(attrition_flag) AS employees_left,
	   COUNT(*) AS total_employees,
	   ROUND(AVG(attrition_flag :: NUMERIC)*100,1) AS attrition_rate_pct
FROM hr_attrition
GROUP BY department, overtime
ORDER BY department, attrition_rate_pct DESC;



