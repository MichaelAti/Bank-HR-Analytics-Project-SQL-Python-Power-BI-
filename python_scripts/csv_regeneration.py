import pandas as pd
import numpy as np
from faker import Faker
from datetime import datetime, timedelta

# Configuration
records = 1000000
fake = Faker()
np.random.seed(42)

def generate_unified_employee_data(n):
    print("Generating 1M records... please wait.")
    
    # 1. Generate Performance Data First
    emp_ids = np.arange(100000, 100000 + n)
    years_at_bank = np.random.randint(1, 26, n)
    
    df_perf = pd.DataFrame({
        'Employee_ID': emp_ids,
        'Branch_ID': np.random.randint(1, 501, n),
        'Department': np.random.choice(['Retail', 'IT', 'Risk', 'Corporate', 'Legal'], n),
        'Sales_Target_Met': np.round(np.random.uniform(0.5, 1.2, n), 4),
        'Years_at_Bank': years_at_bank,
        'Performance_Rating': np.random.choice([1, 2, 3, 4, 5], n),
        'Annual_Salary': np.round(np.random.normal(60000, 15000, n), 2)
    })

    # 2. Generate Personal Data based on Performance Data
    today = datetime.now()
    
    # Logic: Hire Date = Today - (Years_at_Bank)
    hire_dates = [
        (today - timedelta(days=int(y * 365.25) + np.random.randint(0, 365))).date() 
        for y in years_at_bank
    ]

    df_pers = pd.DataFrame({
        'Employee_ID': emp_ids,
        'Full_Name': [fake.name() for _ in range(n)],
        'Gender': np.random.choice(['Male', 'Female', 'Non-Binary'], n),
        'Email': [fake.ascii_free_email() for _ in range(n)],
        'Date_of_Birth': [fake.date_of_birth(minimum_age=22, maximum_age=65) for _ in range(n)],
        'Hire_Date': hire_dates
    })

    return df_perf, df_pers

# Execute
df_performance, df_personal = generate_unified_employee_data(records)

# Overwrite previous CSVs
df_performance.to_csv('bank_employees_1M.csv', index=False)
df_personal.to_csv('bank_employees_personal_1M.csv', index=False)

print("Both CSVs regenerated and synchronized successfully.")