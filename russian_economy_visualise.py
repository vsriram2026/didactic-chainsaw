#   Project: Russia Oil and Gas Economic Analysis
#   File: russian_economy_visualise.py
#   Purpose: Perform visualisation using Matplotlib

import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

df = pd.read_csv("russian_economy_full.csv")

#df.info()
#df.describe()
#print(df.columns)

##Oil price vs trade balance

print(df.head())

plt.figure()
plt.scatter(df["oil_price_usd"], df["trade_balance_usd"])

for index, row in df.iterrows():
    if row["trade_balance_usd"] > 20:
        plt.text(row["oil_price_usd"], 
                row["trade_balance_usd"], 
                str(row["year"]),
                fontsize=8)

plt.xlabel("Oil Price (USD)")
plt.ylabel("Trade Balance (USD)")
plt.title("Oil Price vs Trade Balance")
plt.show()

#While oil prices vary significantly over time, Russia’s trade balance remains relatively stable in most years, with a few large surplus outliers. This suggests that oil prices alone do not explain trade balance dynamics, and that other factors such as export volumes, import demand, and external shocks play a significant role.

##Oil price vs government dependence on oil and gas

#Calculate the best-fit line
subset = df[["year","oil_price_usd","oil_gas_revenue_share_pct"]].dropna() #dropna to remove null values that will break the visualisation
x = subset["oil_price_usd"]
y = subset["oil_gas_revenue_share_pct"]

m,b=np.polyfit(x,y,1)


plt.figure() #So that a new plot is created and an old one is not reused or overwritten.
plt.scatter(x,y) #Replacing column names with x and y
plt.plot(x, m*x + b)

plt.xlabel("Oil Price (USD)")
plt.ylabel("Percentage of revenue share of oil and gas")
plt.title("Oil price vs government dependence on oil and gas")
plt.show()

##Non-oil GDP vs Oil Price

subset = df[["year","non_oil_gdp","oil_price_usd"]].dropna()
x = subset["non_oil_gdp"]
y = subset["oil_price_usd"]

m1,b1=np.polyfit(x,y,1)
m2,b2=np.polyfit(y,x,1)

plt.figure()
plt.scatter(x,y)
plt.plot(x, m1*x + b1)
plt.plot(y, m2*y + b2)
plt.xlabel("Non-Oil GDP")
plt.ylabel("Oil-Price (USD)")
for index,row in subset.iterrows():
    plt.text(row["non_oil_gdp"],
             row["oil_price_usd"],
             row["year"])
plt.show()

#Story: "Periods of high oil prices coincide with weaker non-oil GDP growth, suggesting limited economic diversification."

##Trade balance components over time

#A note on the units: Because the variables are measured in different units, the chart is intended to compare direction and timing rather than absolute levels. A dual-axis or indexed chart would be more appropriate for precise comparison.

subset = df[["year","oil_export_volume_million_tons","import_volume_billion_usd"]].dropna()
subset = subset.sort_values("year")

plt.figure()

plt.plot(subset["year"], subset["oil_export_volume_million_tons"], label="Oil Export Volume in Millions of Tons") #plots a simple line connecting all the points
plt.plot(subset["year"], subset["import_volume_billion_usd"], label = "Import volume in billions of USD")
plt.xlabel("Year")
plt.ylabel("Values")
plt.title("Oil export volumes and import volumes over time")
plt.legend()
plt.show()

#Story: This chart compares the trends in oil export volumes and import values over time. While the units differ, the visualization highlights how both series evolve across economic periods.
#Interpretation:
#Blue line: Russia increased physical oil export capacity through the 2000s, but volumes stagnated and later declined, possibly due to market saturation, sanctions, or production constraints.
#Orange line: Import values are highly sensitive to macroeconomic shocks, exchange rates, sanctions, and oil price cycles.
#Relationship insight: Despite relatively stable oil export volumes, import values fluctuate significantly, suggesting that Russia’s import capacity is driven more by prices, revenues, and external constraints than by export volume alone.


##CPI vs key rate (inflation response)

subset = df[["year","cpi","key_rate"]].dropna()
subset=subset.sort_values("year")

plt.figure()

plt.plot(subset["year"],subset["cpi"],label="CPI")
plt.plot(subset["year"],subset["key_rate"],label="Key Rate")
plt.xlabel("Years")
plt.ylabel("Values")
plt.legend()
plt.show()

#Story: This visualization explores whether Russia’s central bank responds to inflation by adjusting the key interest rate. CPI is used as a proxy for inflation, while the key rate represents monetary policy stance. While the two series use different units, plotting them together allows a qualitative assessment of co-movement and response timing.

##CPI vs key rate (using two y-axes)

fig, ax1 = plt.subplots()

ax1.plot(subset["year"],subset["cpi"],color="tab:blue",label="CPI")
ax1.set_xlabel("Years")
ax1.set_ylabel("CPI")
ax1.tick_params(axis="y",labelcolor="tab:blue")
plt.legend()

ax2 = ax1.twinx()
ax2.plot(subset["year"],subset["key_rate"],color="tab:red",label="Key Rate")
ax2.set_xlabel("Years")
ax2.set_ylabel("Key Rate")
ax2.tick_params(axis="y",labelcolor="tab:red")
plt.legend()

plt.title("CPI vs Key Rate over Time")
plt.show()

##Military expenditure vs oil price

subset = df[["year","military_expenditure_pct_gdp","oil_price_usd"]].dropna()
subset = subset.sort_values("year")

#plt.figure()

fig, ax1 = plt.subplots()

ax1.plot(subset["year"],subset["military_expenditure_pct_gdp"],color="tab:blue",label="Military expenditure")
ax1.set_xlabel("Years")
ax1.set_ylabel("Military expenditure in percentage of GDP")
plt.legend()

ax2 = ax1.twinx()

ax2.plot(subset["year"],subset["oil_price_usd"],color="tab:red",label="Oil price")
ax2.set_xlabel("Years")
ax2.set_ylabel("Oil price in USD")
plt.legend()

plt.title("Military expenditure vs oil price")
plt.show()

#Story: In the 1990s, military expenditure increased sharply 
#despite a decrease in oil price. From 2000 onwards, spikes in oil price
#appear to correlate with spikes in military spending, albeit with a lag.

##Population vs unemployment (social stability)

subset = df[["year","population_size","unemployment_rate"]].dropna()
subset = subset.sort_values("year")

#plt.figure()

fig, (ax1, ax2) = plt.subplots(2, sharex=True)

ax1.plot(subset["year"],subset["population_size"],color="tab:blue",label="Population size")
ax1.set_xlabel("Years")
ax1.set_ylabel("Population size")
plt.legend()

ax2.plot(subset["year"],subset["unemployment_rate"],color="tab:red",label="Unemployment rate")
ax2.set_xlabel("Years")
ax2.set_ylabel("Unemployment rate")
plt.legend()

plt.title("Population size vs unemployment rate",pad=150)
plt.show()

#Story: This chart compares long-term demographic trends with labor market volatility, not to imply causation but to provide context.
#Population in Russia declines steadily through the 1990s and 2000s, likely reflecting demographic and migration factors. Unemployment, however, shows sharp cyclical spikes during economic crises, particularly in the late 1990s. The lack of synchronized movement suggests that short-term labor market volatility is largely independent of long-term population change.

##Rolling averages to show regime shifts

subset = df[["year","oil_price_usd","cpi","military_expenditure_pct_gdp"]].dropna()
subset = subset.sort_values("year")

#plt.figure()

fig, (ax1, ax2, ax3) = plt.subplots(nrows=3,ncols=1,sharex=True,sharey=False) 
plt.title("Rolling averages of Oil Price, CPI, and Military Expenditure", pad=200)

ax1.plot(subset["year"],subset["oil_price_usd"].rolling(5).mean())
ax1.set_xlabel("Years")
ax1.set_ylabel("Oil Price in USD")

ax2.plot(subset["year"],subset["cpi"].rolling(5).mean())
ax2.set_xlabel("Years")
ax2.set_ylabel("CPI")

ax3.plot(subset["year"],subset["military_expenditure_pct_gdp"].rolling(5).mean())
ax3.set_xlabel("Years")
ax3.set_ylabel("Military Expenditure")

plt.show()

#Story:
#Regime shifts in macroeconomic conditions are visible when using five-year rolling averages.
#Oil prices exhibit pronounced long-term cycles, with a sustained rise during the 2000s followed by a decline after the global financial crisis. CPI remains relatively stable in earlier periods but enters a higher-inflation regime in the 2010s. Military expenditure as a share of GDP decreases during the oil-boom period and gradually rises during later periods marked by higher inflation and geopolitical uncertainty. While causality cannot be inferred, the alignment of these trends suggests that macroeconomic regimes influence fiscal and policy priorities over time.





