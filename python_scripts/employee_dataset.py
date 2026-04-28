import pandas as pd
import numpy as np

# Configuration
records = 1000000

def generate_employee_data(n):
    # Setting a seed ensures the "random" data is reproducible if you run it again
    np.random.seed(42) 
    
    data = {
        'Employee_ID': np.arange(100000, 100000 + n),
        'Branch_ID': np.random.randint(1, 501, n),  # Simulating 500 different branches
        'Department': np.random.choice(
            ['Retail', 'Corporate', 'Risk', 'IT', 'Legal'], 
            n, 
            p=[0.45, 0.20, 0.15, 0.15, 0.05] # Realistic banking distribution
        ),
        # Sales target met as a percentage (0 to 120%)
        'Sales_Target_Met': np.round(np.random.uniform(0.5, 1.2, n), 4),
        'Years_at_Bank': np.random.randint(1, 26, n),
        # Adding Performance Rating (1-5) to enhance your Power BI visuals
        'Performance_Rating': np.random.choice([1, 2, 3, 4, 5], n, p=[0.05, 0.15, 0.50, 0.20, 0.10]),
        # Adding Salary for cost-to-income ratio analysis
        'Annual_Salary': np.round(np.random.normal(60000, 15000, n), 2)
    }
    
    return pd.DataFrame(data)

# Generate and Save
df_emp = generate_employee_data(records)

# Quick check: Ensure salaries aren't negative due to normal distribution
df_emp['Annual_Salary'] = df_emp['Annual_Salary'].clip(lower=30000)

df_emp.to_csv('bank_employees_1M.csv', index=False)

print("File 'bank_employees_1M.csv' created successfully.")
print(df_emp.head()) # Preview the first few rows