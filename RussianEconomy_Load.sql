USE Russian_Economy
GO

--=======================================

--Project: Russia Oil & Gas Economic Analysis

--File:RussianEconomy_Load.sql

--Purpose: Load data into tables

--=======================================

--SELECT * FROM Raw_Data
--sp_help Raw_Data

--Load data into Years

INSERT INTO years 
SELECT DISTINCT year FROM Raw_Data

--Load data into Prices

INSERT INTO prices (year, oil_price_usd, gas_price_usd)
SELECT 
year, oil_prices_barrel_USD, gas_prices_MMBtu_USD
FROM Raw_Data

--Load data into Production

INSERT INTO production (year, oil_production_volume_million, gas_production_volume_billion)
SELECT
year, Oil_production_volume_million_b_y, Gas_production_volume_billion_c_m_y
FROM Raw_Data

--Load data into Exports

INSERT INTO exports (year, oil_export_volume_million_tons, gas_export_volume_billion_c_m)
SELECT
year, Oil_export_volume_million_tons, Gas_export_volume_billion_c_m
FROM Raw_Data

--Load data into Macro_economy

INSERT INTO macro_economy (year, oil_gas_revenue_share_pct, trade_balance_usd, fdi_usd,
import_volume_billion_usd, key_rate, tax_rates_VAT, tax_receipts_billion_USD)
SELECT
year, 
Share_of_oil_and_gas_revenues, 
TB_billion_USD, 
FDI_billion_USD, 
Import_volume_billion_USD, 
Key_rate, 
tax_rates_VAT, 
tax_receipts_billion_USD
FROM Raw_Data

--Load data into Population_indicators

INSERT INTO population_indicators (year, population_size, unemployment_rate, per_capita_income_thousands_usd, non_oil_gdp, cpi)
SELECT
year,
population_size_p,
unemployment_rate,
per_c_i_thousands_USD,
Non_oil_GDP,
CPI
FROM Raw_Data

--Load data into Military_expenditure

INSERT INTO military_expenditure (year, military_expenditure_pct_gdp)
SELECT
year,
Military_expenditures_of_GDP
FROM Raw_Data

--=================
--Validation query (Check if more than one record exists for any year in the raw data)
--=================

SELECT year, COUNT(*)
FROM Raw_Data
GROUP BY year
HAVING COUNT(*) > 1



