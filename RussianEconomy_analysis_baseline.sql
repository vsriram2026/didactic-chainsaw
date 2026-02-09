USE Russian_Economy
GO

--=======================================

--Project: Russia Oil & Gas Economic Analysis

--File:RussianEconomy_analysis_baseline.sql

--Purpose: Create a full joined view

--=======================================

--Row counts per table (all tables should have the same number of rows)

SELECT 'years' AS Table_name, COUNT(*) AS row_count FROM years
UNION
SELECT 'prices', COUNT(*) FROM prices
UNION
SELECT 'production ', COUNT(*) FROM production
UNION
SELECT 'exports', COUNT(*) FROM exports
UNION
SELECT 'macro_economy', COUNT(*) FROM macro_economy
UNION
SELECT 'population_indicators', COUNT(*) FROM population_indicators
UNION
SELECT 'military_expenditure', COUNT(*) FROM military_expenditure

--Full joined view

GO

CREATE VIEW Full_Joined_View AS
SELECT y.year,
pri.oil_price_usd,
pri.gas_price_usd,
pro.oil_production_volume_million,
pro.gas_production_volume_billion,
e.oil_export_volume_million_tons,
e.gas_export_volume_billion_c_m,
m.oil_gas_revenue_share_pct,
m.trade_balance_usd,
m.fdi_usd,
m.import_volume_billion_usd,
m.key_rate,
m.tax_rates_VAT,
m.tax_receipts_billion_USD,
po.population_size,
po.unemployment_rate,
po.per_capita_income_thousands_usd,
po.non_oil_gdp,
po.cpi,
mil.military_expenditure_pct_gdp
FROM years y
JOIN prices pri ON pri.year=y.year
JOIN production pro ON pro.year=y.year
JOIN exports e ON e.year=y.year
JOIN macro_economy m ON m.year=y.year
JOIN population_indicators po ON po.year=y.year
JOIN military_expenditure mil ON mil.year=y.year

GO

SELECT * FROM Full_Joined_View