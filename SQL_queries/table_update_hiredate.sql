TRUNCATE TABLE Stage_Employee_Performance;
TRUNCATE TABLE Stage_Employee_Personal;

-- Ensure your staging table has the Hire_Date column
ALTER TABLE Stage_Employee_Personal ADD COLUMN IF NOT EXISTS Hire_Date DATE;
ALTER TABLE Stage_Employee_Personal DROP COLUMN Address;


TRUNCATE TABLE Fact_Employees CASCADE;
TRUNCATE TABLE Dim_Employee_Personal CASCADE;

-- Reload Personal Dim (with the new Hire_Date)
INSERT INTO Dim_Employee_Personal (Employee_ID, Full_Name, Gender, Email, Date_of_Birth, Hire_Date)
SELECT Employee_ID, Full_Name, Gender, Email, Date_of_Birth, Hire_Date 
FROM Stage_Employee_Personal;



-- 1. Clear the branch table if it has partial data
TRUNCATE TABLE Dim_Branches CASCADE;

-- 2. Populate Dim_Branches with all IDs present in your 1M records
INSERT INTO Dim_Branches (Branch_ID, Branch_Name, Region)
SELECT DISTINCT 
    Branch_ID, 
    'Branch ' || Branch_ID AS Branch_Name, -- Using || for Postgres concatenation
    CASE 
        WHEN Branch_ID <= 125 THEN 'North'
        WHEN Branch_ID <= 250 THEN 'South'
        WHEN Branch_ID <= 375 THEN 'East'
        ELSE 'West' 
    END AS Region
FROM Stage_Employee_Performance
ORDER BY Branch_ID;

-- Verify it worked
SELECT COUNT(*) FROM Dim_Branches; -- Should be around 500


-- 1. Clear existing data to avoid primary key conflicts (if re-running)
TRUNCATE TABLE Fact_Employees;

-- 2. Insert and Transform data
INSERT INTO Fact_Employees (
    Employee_ID, 
    Branch_ID, 
    Department_ID, 
    Sales_Target_Met, 
    Years_at_Bank, 
    Performance_Rating, 
    Annual_Salary
)
SELECT 
    s.Employee_ID,
    s.Branch_ID,
    d.Department_ID,
    s.Sales_Target_Met,
    s.Years_at_Bank,
    s.Performance_Rating,
    s.Annual_Salary
FROM Stage_Employee_Performance s
INNER JOIN Dim_Departments d ON s.Department = d.Department_Name;

-- 3. Verify the load
SELECT COUNT(*) FROM Fact_Employees;