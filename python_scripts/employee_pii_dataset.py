import pandas as pd
import numpy as np
from faker import Faker
from datetime import datetime, timedelta

# Configuration
records = 1000000
fake = Faker()

def generate_personal_data(n):
    # Use the same starting ID as your previous script (100,000)
    employee_ids = np.arange(100000, 100000 + n)
    
    print("Generating names and emails... this may take a minute for 1M records.")
    
    # Using list comprehension for speed
    data = {
        'Employee_ID': employee_ids,
        'Full_Name': [fake.name() for _ in range(n)],
        'Gender': np.random.choice(['Male', 'Female', 'Non-Binary'], n, p=[0.49, 0.49, 0.02]),
        'Email': [fake.ascii_free_email() for _ in range(n)],
        # Generate DOB between 22 and 65 years ago
        'Date_of_Birth': [fake.date_of_birth(minimum_age=22, maximum_age=65) for _ in range(n)],
        'Address': [fake.city() for _ in range(n)]
    }
    
    return pd.DataFrame(data)

# Execution
df_personal = generate_personal_data(records)

# Save to CSV
df_personal.to_csv('bank_employees_personal_1M.csv', index=False)

print("File 'bank_employees_personal_1M.csv' created successfully.")
print(df_personal.head())