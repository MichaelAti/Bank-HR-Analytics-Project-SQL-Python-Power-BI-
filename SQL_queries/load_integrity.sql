-- Check for employees who didn't make it to the Fact table
SELECT s.Employee_ID, s.Department, s.Branch_ID
FROM Stage_Employee_Performance s
LEFT JOIN Fact_Employees f ON s.Employee_ID = f.Employee_ID
WHERE f.Employee_ID IS NULL;

-- "Balance Sheet" of your data movement for your documentation:
SELECT 
    'Stage_Total' AS Metric, COUNT(*) AS Record_Count FROM Stage_Employee_Performance
UNION ALL
SELECT 
    'Fact_Total' AS Metric, COUNT(*) FROM Fact_Employees
UNION ALL
SELECT 
    'Dim_Personal_Total' AS Metric, COUNT(*) FROM Dim_Employee_Personal;
	

-- Logic Check: Tenure vs. Hire Date (did not work)
SELECT 
    p.Employee_ID, 
    p.Hire_Date, 
    f.Years_at_Bank,
    EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM p.Hire_Date) AS Calculated_Years
FROM Dim_Employee_Personal p
JOIN Fact_Employees f ON p.Employee_ID = f.Employee_ID
WHERE (EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM p.Hire_Date)) != f.Years_at_Bank
LIMIT 10;

-- Logic Check: Tenure vs. Hire Date (AGE) (worked)
SELECT 
    p.Employee_ID, 
    p.Hire_Date, 
    f.Years_at_Bank,
    -- Extract only the 'years' part of the exact age interval
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, p.Hire_Date)) AS Exact_Calculated_Years
FROM Dim_Employee_Personal p
JOIN Fact_Employees f ON p.Employee_ID = f.Employee_ID
-- This will only show rows where even the exact age doesn't match
WHERE EXTRACT(YEAR FROM AGE(CURRENT_DATE, p.Hire_Date)) != f.Years_at_Bank
LIMIT 10;


-- Logic FIX: Tenure vs. Hire Date
UPDATE Dim_Employee_Personal p
SET Hire_Date = CURRENT_DATE 
                - (f.Years_at_Bank * INTERVAL '1 year') 
                - (floor(random() * 364) * INTERVAL '1 day')
FROM Fact_Employees f
WHERE p.Employee_ID = f.Employee_ID;