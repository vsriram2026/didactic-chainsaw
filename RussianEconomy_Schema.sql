USE Russian_Economy
GO

--sp_help Raw_Data
--SELECT * FROM Raw_Data

/* Year is set as Primary Key because each record pertains to exactly one year and we do not have data at any other timescale
However, Year would have to be removed as Primary Key in case data at other timescales become available*/

--=======================================

--Project: Russia Oil & Gas Economic Analysis

--File:RussianEconomy_Schema.sql

--Purpose: Database schema definition

--=======================================

--Drop tables if they exist (For clean re-runs)

DROP TABLE IF EXISTS population_indicators;
DROP TABLE IF EXISTS military_expenditure;
DROP TABLE IF EXISTS macro_economy;
DROP TABLE IF EXISTS exports;
DROP TABLE IF EXISTS production;
DROP TABLE IF EXISTS prices;
DROP TABLE IF EXISTS years;

--=======================================
--Core dimension table
--=======================================

CREATE TABLE years
(year INT PRIMARY KEY);

--=======================================
--Prices table
--=======================================

CREATE TABLE prices
(year INT PRIMARY KEY,
oil_price_usd DECIMAL(10,2),
gas_price_usd DECIMAL(10,2),
CONSTRAINT fk_prices_year
	FOREIGN KEY (year) REFERENCES years(year)
);

--======================================
--Production table
--======================================

CREATE TABLE production
(year INT PRIMARY KEY,
oil_production_volume_million DECIMAL(10,2),
gas_production_volume_billion DECIMAL(10,2),
CONSTRAINT fk_production_year
	FOREIGN KEY (year) REFERENCES years(year)
);

--======================================
--Export table
--======================================

CREATE TABLE exports
(year INT PRIMARY KEY,
oil_export_volume_million_tons DECIMAL(10,2),
gas_export_volume_billion_c_m DECIMAL(10,2),
CONSTRAINT fk_exports_year
	FOREIGN KEY (year) REFERENCES years(year)
);

--=====================================
--Macroeconomic indicators
--=====================================

CREATE TABLE macro_economy
(year INT PRIMARY KEY,
oil_gas_revenue_share_pct DECIMAL(5,2),
trade_balance_usd DECIMAL(12,2),
fdi_usd DECIMAL(12,2),
import_volume_billion_usd DECIMAL(12,2),
key_rate DECIMAL(12,2),
tax_rates_VAT DECIMAL(12,2),
tax_receipts_billion_USD DECIMAL(12,2),

CONSTRAINT
	fk_macro_year
FOREIGN KEY (year) REFERENCES years(year)
);

--===================================
--Population indicators
--===================================

CREATE TABLE population_indicators
(year INT PRIMARY KEY,
population_size INT,
unemployment_rate DECIMAL(10,2),
per_capita_income_thousands_usd DECIMAL(10,2),
non_oil_gdp DECIMAL(10,2),
cpi DECIMAL(10,2),
CONSTRAINT
	fk_population_year
FOREIGN KEY (year) REFERENCES years(year)
);

--===================================
--Military expenditure
--===================================

CREATE TABLE military_expenditure
(year INT PRIMARY KEY,
military_expenditure_pct_gdp DECIMAL(10,2),
CONSTRAINT
	fk_military_year
FOREIGN KEY (year) REFERENCES years(year)
);



--===================================
--Indexes
--===================================

CREATE INDEX idx_prices_year ON prices(year);
CREATE INDEX idx_production_year ON production(year);
CREATE INDEX idx_exports_year ON exports(year);
CREATE INDEX idx_macro_year ON macro_economy(year);
CREATE INDEX idx_population_year ON population_indicators(year);
CREATE INDEX idx_military_year ON military_expenditure(year);


