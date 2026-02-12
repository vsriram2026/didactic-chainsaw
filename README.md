# didactic-chainsaw

Russia Oil & Gas Economic Analysis
Overview

This project explores long-term trends in the Russian economy with a focus on oil and gas dependence, macroeconomic stability, and structural change over time. Using a combination of SQL for data preparation and Python (pandas + matplotlib) for exploratory data analysis and visualization, the project examines relationships between energy prices, fiscal indicators, inflation, military expenditure, trade dynamics, and demographic variables.

The analysis is descriptive and exploratory in nature and does not attempt to establish causal relationships.

Data Source and Preparation

Data was extracted from a normalized SQL Server database (Russian_Economy)

A consolidated view (Full_Joined_View) was used to combine economic indicators across time

SQL was used to:

Select and compare key macroeconomic indicators

Segment years into economic periods (1990s Transition, Oil Boom, Post-Crisis, 2020s Volatility)

Compute rolling averages using window functions

Perform descriptive correlation analysis

The final dataset was exported to CSV and loaded into Python as
russian_economy_full.csv

Tools and Libraries

SQL Server (T-SQL) – data extraction, rolling averages, correlations

Python

pandas – data cleaning and manipulation

matplotlib – data visualization

numpy – linear regression (trend lines)

Visual Analyses Included
1. Oil Price vs Trade Balance

Scatter plot with year annotations for large trade surpluses

Highlights that trade balance remains relatively stable despite large oil price swings

2. Oil Price vs Government Dependence on Oil & Gas

Scatter plot with linear trend line

Examines whether higher oil prices are associated with increased fiscal reliance on oil and gas revenues

3. Non-Oil GDP vs Oil Price

Scatter plot with regression line

Used to explore economic diversification dynamics during periods of high oil prices

4. Oil Export Volumes vs Import Values Over Time

Line chart comparing physical export volumes with import values

Focuses on direction and timing rather than absolute magnitude due to differing units

5. CPI vs Key Interest Rate

Single-axis and dual-axis line charts

Used to qualitatively assess monetary policy response to inflation over time

6. Military Expenditure vs Oil Price

Dual-axis line chart

Explores whether oil price movements coincide with changes in military spending

7. Population Size vs Unemployment Rate

Two vertically stacked subplots with shared x-axis

Provides demographic context for labor market volatility

8. Rolling Averages and Regime Shifts

Five-year rolling averages for:

Oil price

CPI

Military expenditure (% of GDP)

Used to smooth short-term volatility and highlight longer-term macroeconomic regimes

Key Notes on Interpretation

Several charts combine variables with different units; these visualizations are intended for trend comparison, not direct magnitude comparison

Correlation and co-movement are explored descriptively

No causal claims are made

How to Run

Ensure russian_economy_full.csv is in the same directory

Run:

python russian_economy_visualise.py


Charts will be displayed sequentially using matplotlib

Project Summary
Objective

The objective of this project is to examine how oil and gas dynamics intersect with broader economic indicators in Russia over time, with particular attention to structural shifts, fiscal dependence, and macroeconomic stability.

Methodology

Economic indicators were extracted from a normalized SQL schema using a consolidated view

SQL was used for:

Period classification

Rolling averages

Descriptive correlation calculations

Python was used for:

Data cleaning and filtering

Exploratory visualization

Trend line estimation using linear regression

Five-year rolling averages were applied to reduce short-term noise and highlight regime-level patterns

Key Insights

Fiscal Dependence: Government revenue from oil and gas increases strongly during periods of higher oil prices, indicating structural exposure to commodity cycles.

Military Expenditure: Military spending (as % of GDP) rises during extended oil price booms, suggesting increased fiscal flexibility during high-revenue periods.

Inflation & Monetary Policy: CPI exhibits a structural upward shift after 2011–2012. The key interest rate shows reactive spikes during inflationary or crisis periods, indicating active monetary stabilization efforts.

Trade Balance: Oil price movements do not show a consistently strong linear relationship with trade balance, suggesting additional influencing factors beyond commodity prices.

Non-Oil GDP: The fitted trend line indicates an inverse relationship between oil prices and non-oil GDP over the sample period. This is descriptive and does not imply causation.

Regime Shifts: Five-year rolling averages highlight multi-year structural transitions rather than short-term volatility, particularly in oil prices, inflation levels, and military expenditure.

Population Size vs Unemployment Rate: Population size does not exhibit a clear linear relationship with unemployment rate, indicating that fluctuations in unemployment are likely driven by economic factors rather than population levels alone.

Overall Conclusion: The analysis suggests that oil prices are closely linked to fiscal revenue composition and certain expenditure patterns, while broader macroeconomic outcomes (trade balance, non-oil GDP) appear influenced by additional structural and external factors.

All findings are descriptive and based on exploratory analysis; no causal claims are made.

Scope and Limitations

The analysis is exploratory and descriptive

Visual correlations do not imply causation

Results are sensitive to data availability and aggregation choices

The project prioritizes interpretability over formal econometric modeling
