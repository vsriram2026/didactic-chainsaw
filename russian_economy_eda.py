#   Project: Russia Oil and Gas Economic Analysis
#   File: russian_economy_eda.py
#   Purpose: Perform EDA using Pandas


import pandas as pd

import pyodbc

conn = pyodbc.connect(
    "DRIVER={ODBC Driver 18 for SQL Server};"
    "SERVER=localhost;"
    "DATABASE=Russian_Economy;"
    "Trusted_Connection=yes;"
    "Encrypt=no;"
)

print ("Server connection works")

query = """SELECT * 
FROM Full_Joined_View ORDER BY year"""

df = pd.read_sql(query,conn)

print(df.head())

df.columns

df.info()

print(df.tail)

print(df.shape)

df.describe().to_csv("describe_output.csv")

#For each year, compute the average CPI 
#over the current year
#and the previous 4 years.

#Keep only the columns we need. This is like creating
#a separate CPI table or CPI view in SQL.

cpi_df=df[["year","cpi"]].copy()

cpi_df=cpi_df.sort_values("year")

cpi_df["cpi_5yr_avg"]=cpi_df["cpi"].rolling(window=5).mean()

cpi_df.to_csv("rolling_cpi.csv", index=False)




