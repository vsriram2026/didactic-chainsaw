USE Russian_Economy
GO

--=======================================

--Project: Russia Oil & Gas Economic Analysis

--File:RussianEconomy_trend_analysis.sql

--Purpose: Analyse trends in the Russian economy across time and compare various economic periods

--=======================================

--SELECT * FROM Full_Joined_View

--Oil and gas prices over time

SELECT
	year,
	oil_price_usd,
	gas_price_usd
FROM Full_Joined_View
ORDER BY year

--Production trends

SELECT
	year,
	oil_production_volume_million,
	gas_production_volume_billion
FROM Full_Joined_View
ORDER BY year

--Period comparisons
	--Label years into economic periods
			
		SELECT
			year,
			CASE
			WHEN year BETWEEN 1991 AND 1999 THEN '1990s Transition'
			WHEN year BETWEEN 2000 AND 2008 THEN 'Oil Boom'
			WHEN year BETWEEN 2009 AND 2019 THEN 'Post-Crisis'
			ELSE '2020s Volatility'
		END AS Period,
		oil_price_usd,
		trade_balance_usd
	    FROM Full_Joined_View
		ORDER BY year

	--Average indicators by period

		SELECT
		CASE
			WHEN year BETWEEN 1991 AND 1999 THEN '1990s Transition'
			WHEN year BETWEEN 2000 AND 2008 THEN 'Oil Boom'
			WHEN year BETWEEN 2009 AND 2019 THEN 'Post-Crisis'
			ELSE '2020s Volatility'
			END AS Period,
			AVG(oil_price_usd) AS Avg_Oil_Price,
			AVG(gas_price_usd) AS Avg_Gas_Price,
			AVG(trade_balance_usd) AS Avg_Trade_Balance
		FROM Full_Joined_View
		GROUP BY 
		CASE
			WHEN year BETWEEN 1991 AND 1999 THEN '1990s Transition'
			WHEN year BETWEEN 2000 AND 2008 THEN 'Oil Boom'
			WHEN year BETWEEN 2009 AND 2019 THEN 'Post-Crisis'
			ELSE '2020s Volatility'
			END

--Five-year rolling average of oil price and gas price

SELECT
	year,
	oil_price_usd,
	gas_price_usd,
	AVG(oil_price_usd) OVER (ORDER BY year ROWS BETWEEN 4 PRECEDING AND CURRENT ROW) AS avg_oil_price_usd,
	AVG(gas_price_usd) OVER (ORDER BY year ROWS BETWEEN 4 PRECEDING AND CURRENT ROW) AS avg_gas_price_usd
FROM Full_Joined_View
ORDER BY year


--Five-year rolling average of military expenditure

--Five-year rolling average of tax receipts

--Year-over-year change in oil production

SELECT
	year,
	oil_production_volume_million,
	oil_production_volume_million - LAG(oil_production_volume_million) OVER (ORDER BY year) AS yoy_change
FROM Full_Joined_View
ORDER BY year

--Pearson correlation between oil price and trade balance

SELECT
(
	AVG(oil_price_usd * trade_balance_usd)
	- AVG(oil_price_usd) * AVG(trade_balance_usd)
)
/
(
	STDEV(oil_price_usd) * STDEV(trade_balance_usd)
) AS correlation
FROM Full_Joined_View
WHERE oil_price_usd IS NOT NULL
AND trade_balance_usd IS NOT NULL;

--Military expenditure across periods

SELECT
CASE
WHEN year BETWEEN 1991 AND 1999 THEN '1990s Transition'
WHEN year BETWEEN 2000 AND 2008 THEN 'Oil Boom'
WHEN year BETWEEN 2009 AND 2019 THEN 'Post-Crisis'
ELSE '2020s Volatility'
END AS Period,
AVG(military_expenditure_pct_gdp)
FROM Full_Joined_View
GROUP BY
CASE
WHEN year BETWEEN 1991 AND 1999 THEN '1990s Transition'
WHEN year BETWEEN 2000 AND 2008 THEN 'Oil Boom'
WHEN year BETWEEN 2009 AND 2019 THEN 'Post-Crisis'
ELSE '2020s Volatility'
END

/* Military expenditure was at its lowest during the Oil Boom, then gradually increased Post-Crisis, 
and then increased sharply during the 2020s volatility, corresponding with the Ukraine War */ 


--Oil-price and non-oil GDP across periods

SELECT
CASE
WHEN year BETWEEN 1991 AND 1999 THEN '1990s Transition'
WHEN year BETWEEN 2000 AND 2008 THEN 'Oil Boom'
WHEN year BETWEEN 2009 AND 2019 THEN 'Post-Crisis'
ELSE '2020s Volatility'
END AS Period,
AVG(oil_price_usd) AS Oil_Price,
AVG(non_oil_gdp) AS Non_Oil_GDP_Pct
FROM Full_Joined_View
GROUP BY
CASE
WHEN year BETWEEN 1991 AND 1999 THEN '1990s Transition'
WHEN year BETWEEN 2000 AND 2008 THEN 'Oil Boom'
WHEN year BETWEEN 2009 AND 2019 THEN 'Post-Crisis'
ELSE '2020s Volatility'
END


--Pearson correlation between oil price and military expenditure

SELECT
(
	AVG(oil_price_usd * military_expenditure_pct_gdp)
	- AVG(oil_price_usd) * AVG(military_expenditure_pct_gdp)
)
/
(
	STDEV(oil_price_usd) * STDEV(military_expenditure_pct_gdp)
)
AS oil_price_military_expenditure_correlation
FROM Full_Joined_View
WHERE oil_price_usd IS NOT NULL
AND military_expenditure_pct_gdp IS NOT NULL

/* Oil price correlates inversely with military expenditure */

--Pearson correlation between trade balance and military expenditure

SELECT
(
	AVG(trade_balance_usd * military_expenditure_pct_gdp)
	- AVG(trade_balance_usd) * AVG(military_expenditure_pct_gdp)
)
/
(
	STDEV(trade_balance_usd) * STDEV(military_expenditure_pct_gdp)
) AS trade_military_correlation
FROM Full_Joined_View
WHERE trade_balance_usd IS NOT NULL
AND military_expenditure_pct_gdp IS NOT NULL

/* Trade balance correlates positively with military expenditure */

--Pearson correlation between oil price and non-oil GDP

SELECT
(
	AVG(oil_price_usd * non_oil_gdp)
	- AVG(oil_price_usd) * AVG(non_oil_gdp)
)
/
(
	STDEV(oil_price_usd) * STDEV(non_oil_gdp)
) AS oil_gdp_correlation
FROM Full_Joined_View
WHERE oil_price_usd IS NOT NULL
AND non_oil_gdp IS NOT NULL

/* The correlation suggests an inverse relationship between oil prices
   and non-oil GDP over this period. This is descriptive and does not
   imply causation. */


--Population size and unemployment rate across periods

SELECT
CASE
WHEN year BETWEEN 1991 AND 1999 THEN '1990s Transition'
WHEN year BETWEEN 2000 AND 2008 THEN 'Oil Boom'
WHEN year BETWEEN 2009 AND 2019 THEN 'Post-Crisis'
ELSE '2020s Volatility'
END AS Period,
AVG(population_size) AS population_size,
AVG(unemployment_rate) AS unemployment_rate
FROM Full_Joined_View
GROUP BY
CASE
WHEN year BETWEEN 1991 AND 1999 THEN '1990s Transition'
WHEN year BETWEEN 2000 AND 2008 THEN 'Oil Boom'
WHEN year BETWEEN 2009 AND 2019 THEN 'Post-Crisis'
ELSE '2020s Volatility'
END

--Pearson correlation between population size and unemployment rate

SELECT
(
	AVG(CAST(population_size AS float) * unemployment_rate)
	- AVG(CAST(population_size AS float)) * AVG(unemployment_rate)
)
/
(
	STDEV(CAST(population_size AS float)) * STDEV(unemployment_rate)
)
AS population_unemployment_rate_correlation
FROM Full_Joined_View
WHERE population_size IS NOT NULL
AND unemployment_rate IS NOT NULL;

--Rolling average of CPI over a 5-year window
-- Rolling average used to smooth short-term inflation volatility
-- and highlight longer-term price trends

SELECT
year,
cpi,
AVG(cpi) OVER (ORDER BY year ROWS BETWEEN 4 PRECEDING AND CURRENT ROW) AS Avg_CPI
FROM Full_Joined_View
WHERE CPI IS NOT NULL









