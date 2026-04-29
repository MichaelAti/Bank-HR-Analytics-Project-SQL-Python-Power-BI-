-- Inserting into Departments Dimension table
INSERT INTO Dim_Departments (Department_Name)
SELECT DISTINCT Department FROM Stage_Employee_Performance;

select * from Dim_Departments;

-- Inserting into Employee Personal Infomation Dimension table
INSERT INTO Dim_Employee_Personal (Employee_ID, Full_Name, Gender, Email, Date_of_Birth)
SELECT Employee_ID, Full_Name, Gender, Email, Date_of_Birth
FROM Stage_Employee_Personal;

select * from Dim_Employee_Personal limit 10;