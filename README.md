# Portfolio

Three case studies, each taking raw data through cleaning, analysis, and a decision ready
recommendation.

## Projects

### [Marketing Mix & Channel Efficiency Analysis](./studies/market_mix_model/README.md)
Tests whether ad spend across TikTok, Facebook, and Google Ads is allocated efficiently. Google Ads
outperforms the other two channels per dollar spent, but two independent models disagree nearly 2x on
the exact size of that effect. Recommendation is an incrementality test before a large reallocation,
not a precise dollar figure.

**Dashboard preview**
![Marketing Mix & Channel Efficiency Dashboard](https://public.tableau.com/static/images/ma/market_mix_final/Dashboard1/1.png)

### [Consumer Loan Portfolio Risk & Profitability Analysis](./studies/loan-pf-risk/README.md)
Tests whether declining high risk loan segments would improve profitability. Across 1.04M resolved
loans, net expected value per loan rises from \$2,382 to \$5,121 across risk tiers, because pricing
compensates for risk on average. But tested against each loan's actual realized cash flow, 2 of 4 high
risk segments would have added value if declined (up to \$2.1M), while the other 2 would have cost as
much as $75.2M. Recommendation: decline the small business plus high DTI segment, treat one rule as
inconclusive, and keep current pricing on the rest.

**Dashboard preview**
![Consumer Loan Portfolio Risk & Profitability Dashboard](https://public.tableau.com/static/images/lo/loan-pf-risk/Dashboard2/1.png)

### [Retail Inventory Optimization & Demand Forecasting](./studies/retail_opt_forecast/README.md)
Tests whether the current inventory policy is losing more money to stockouts or to excess holding cost.
Across 100 store and product combinations, stockouts are the entire problem, an estimated \$2.4M in lost
revenue against $0 in holding cost. The current process already beats every formulaic service level
tested, including a 99% target. Recommendation: no policy change, direct attention to Groceries
specifically, the category with both the highest stockout rate and the most revenue.

**Dashboard preview**
![Retail Inventory Optimization & Demand Forecasting Dashboard](https://public.tableau.com/static/images/re/retailinventoryoptforecast/Dashboard1/1.png)

## Tools
Python (pandas, numpy, statsmodels, scipy), SQL (DuckDB), Tableau.

## Repo structure
```
studies/
├── market_mix_model/       -- notebooks, SQL, dashboard, README
├── loan-pf-risk/           -- notebooks, SQL, dashboard, README
└── retail_opt_forecast/    -- notebooks, SQL, dashboard, README
```