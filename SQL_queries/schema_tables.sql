-- 1. Create Branch Dimension Table
CREATE TABLE Dim_Branches (
    Branch_ID INT PRIMARY KEY,
    Branch_Name VARCHAR(50),
    Region VARCHAR(50)
);

-- 2. Create Department Dimension Table
CREATE TABLE Dim_Departments (
    Department_ID INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    Department_Name VARCHAR(50)
);

-- 3. Create Employee Fact Table
CREATE TABLE Fact_Employees (
    Employee_ID INT PRIMARY KEY,
    Branch_ID INT,
    Department_ID INT,
    Sales_Target_Met DECIMAL(5,4),
    Years_at_Bank INT,
    Performance_Rating INT,
    Annual_Salary DECIMAL(12,2),
    CONSTRAINT FK_Branch FOREIGN KEY (Branch_ID) REFERENCES Dim_Branches(Branch_ID),
    CONSTRAINT FK_Dept FOREIGN KEY (Department_ID) REFERENCES Dim_Departments(Department_ID)
);

-- 4. Create Employee Personal data Dimension Table
CREATE TABLE Dim_Employee_Personal (
    Employee_ID INT PRIMARY KEY,
    Full_Name VARCHAR(100),
    Gender VARCHAR(10),
    Date_of_Birth DATE,
    Email VARCHAR(100),
    Hire_Date DATE
);

-- Fact table now just focuses on the numbers
ALTER TABLE Fact_Employees 
ADD CONSTRAINT FK_Personal_Info 
FOREIGN KEY (Employee_ID) REFERENCES Dim_Employee_Personal(Employee_ID);

-- 4. Create Employee Date Dimension Table
DROP TABLE IF EXISTS Dim_Date;

CREATE TABLE Dim_Date (
    Date_Key INT PRIMARY KEY,
    Full_Date DATE,
    Year INT,
    Quarter INT,
    Month INT,
    Month_Name VARCHAR(15),
    Day_of_Week VARCHAR(15),
    Is_Weekend BOOLEAN,
    Fiscal_Year INT
);

-- Populate the table using generate_series
INSERT INTO Dim_Date (Date_Key, Full_Date, Year, Quarter, Month, Month_Name, Day_of_Week, Is_Weekend, Fiscal_Year)
SELECT 
    to_char(datum, 'YYYYMMDD')::INT AS Date_Key,
    datum AS Full_Date,
    EXTRACT(YEAR FROM datum) AS Year,
    EXTRACT(QUARTER FROM datum) AS Quarter,
    EXTRACT(MONTH FROM datum) AS Month,
    to_char(datum, 'Month') AS Month_Name,
    to_char(datum, 'Day') AS Day_of_Week,
    CASE WHEN EXTRACT(ISODOW FROM datum) IN (6, 7) THEN TRUE ELSE FALSE END AS Is_Weekend,
    CASE 
        WHEN EXTRACT(MONTH FROM datum) >= 7 THEN EXTRACT(YEAR FROM datum) 
        ELSE EXTRACT(YEAR FROM datum) - 1 
    END AS Fiscal_Year -- Example: Fiscal year starting in July
FROM generate_series('1960-01-01'::DATE, '2030-12-31'::DATE, '1 day'::interval) AS datum;