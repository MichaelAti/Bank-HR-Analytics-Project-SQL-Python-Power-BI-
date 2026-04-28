# 🏦 Bank HR Analytics Project: 1M Record Enterprise Solution
### **Full-Stack Data Pipeline: Python → SQL → Power BI**

## 📖 Project Overview
This project demonstrates the development of a scalable, end-to-end HR analytics solution for a global banking institution. Using a synthetic dataset of **1,000,000 employees**, I engineered a data pipeline to transform raw data into actionable executive insights.

The dashboard focuses on three critical pillars: **Workforce Growth**, **Departmental Efficiency**, and **Financial Risk Mitigation**.

---

## 🛠️ Technical Stack
* **Data Generation:** Python (Pandas, NumPy, faker)
* **Database Management:** SQL Server / PostgreSQL (Star Schema Design)
* **Data Visualization:** Power BI Desktop
* **Language:** DAX (Data Analysis Expressions) for advanced measures

---

## 🚀 Step-by-Step Implementation

### 1. Data Generation (Python)
To simulate a real-world enterprise environment, I authored a Python script to generate a high-volume dataset.
* **Scale:** 1,000,000 unique employee records.
* **Logic:** Integrated realistic constraints for hiring dates (60-year span), department-specific salary ranges, and performance distributions.
* **Output:** Generated optimized CSV files for database ingestion.

### 2. Data Engineering & Modeling (SQL)
I designed a **Star Schema** to ensure high-performance querying and report responsiveness.
* **Fact Table:** `Fact_Employees` (containing salaries, ratings, and keys).
* **Dimension Tables:** `Dim_Department`, `Dim_Location`, `Dim_Date`. `Dim_Employee_Personal`.
* **Key Action:** Implemented primary/foreign key relationships to maintain data integrity across a 1M row volume.

### 3. Advanced Analytics & UI (Power BI)
The report is divided into a 4-page interactive application:

* **Executive Landing Page:** A centralized hub with custom **Page Navigation** for enhanced user experience.
* **Workforce Overview:** Features a **60-year Cumulative Hiring Trend** using complex DAX to visualize bank growth.
* **Performance Quadrant:** A scatter plot mapping *Average Salary* vs. *Performance Rating* to identify high-value departments.
* **Financial Risk Analysis:** * **Salary Histogram:** Used **Data Binning** ($10k increments) to visualize payroll distribution.
    * **Outlier Table:** A targeted "Action List" identifying the Top 500 earners with low performance ratings (1-2).

---

## 📊 Key Insights & Business Value
* **Efficiency Analysis:** Identified that while the **IT Department** has the highest overhead, it also maintains the highest performance density.
* **Risk Mitigation:** Pinpointed 500 specific high-salary contracts that require HR performance reviews.
* **Payroll Stability:** Confirmed the bank’s "Bell Curve" salary distribution, ensuring market competitiveness in the $50k–$60k bracket.

---

## 📂 Repository Structure
* `Python_Scripts/`: Python code used for data synthesis.
* `SQL_Queries/`: Table creation scripts and schema architecture.
* `PowerBI_Report/`: The `.pbix` file (contains the final dashboard).
* `Documentation/`: Screenshots and UI/UX design previews.

## 👤 Developer
**Michael Ati** *Data Analyst | SQL & Power BI Specialist* [https://linkedin.com/in/michael-ati-74a703167]