# Retail Inventory Optimization & Demand Forecasting

## Executive Summary
Across 76,000 store product days, only 0.53% saw zero inventory on hand, an estimated \$2.4 million in lost
revenue against $0 in holding cost, no store product combination in the data carries excess stock above
its calculated reorder point. Testing three formulaic safety stock policies against what is actually
happening today, the current process already wins: total cost stays at \$2.4 million versus \$4.7 million
at a 99% service level target, \$21.8 million at 95%, and \$44.0 million at 80%. A demand forecast built
from trend alone lands at 9.8% error, essentially tied with a plain same period last week guess at 9.0%,
both clearly ahead of the dataset's own bundled forecast at 17.0%. Recommendation: keep the current
process as is and direct any further attention toward Groceries, the category with both the highest
stockout rate and the most revenue on the line.

## Business Context
Reorder decisions in this business are made through whatever informal process generated this data,
without a stated safety stock target or an explicit service level goal. Before recommending a formal,
formula based reorder policy, this analysis tests whether that formal approach would actually beat what
is already happening, rather than assuming a textbook policy is automatically an improvement.

## Data & Methodology
Source: Kaggle's Retail Store Inventory and Demand Forecasting dataset, 76,000 daily records across 5
stores, 20 products, 5 categories, and 4 regions, January 1 2022 through January 30 2024, a complete
panel with every store carrying every product every day. Demand was forecast with a trend only Holt
Winters model, the date range falls short of the two full 52 week cycles a seasonal fit would need, and
benchmarked against both a naive same period baseline and a demand figure already bundled with the
dataset. Reorder points and safety stock assume a 7 day lead time and a 95% service level, both stated
planning figures rather than values pulled from the data, sensitivity tested against 80% and 99% targets.

| Field | Business Meaning | Type | Notes |
|---|---|---|---|
| `date` | Reporting period | date | daily |
| `store_id`, `product_id` | Unit of analysis | categorical | 5 stores, 20 products |
| `category`, `region` | Segmentation | categorical | 5 categories, 4 regions |
| `inventory_level` | Stock on hand | numeric | 0 means a stockout day |
| `units_sold` | Daily demand | numeric | |
| `price`, `discount` | Unit economics | numeric, $ / % | used to estimate revenue |

## Key Findings
1. **Scale of the problem is small and one sided**: 0.53% of store product days had zero inventory on
   hand, an estimated $2.4 million in lost revenue. Zero of the 100 store product combinations in the
   data carry inventory above twice their calculated reorder point, so excess stock is not a measurable
   problem here at all.
2. **Stockouts concentrate by category and region, and Groceries is the segment that matters most**:
   Groceries runs the highest stockout rate at 68%, roughly double Furniture's 34%, and Groceries is
   also the highest revenue category in the data at \$153.0 million. By region, South runs highest at
   61% against North's 49%, even though North carries the most regional revenue at \$154.1 million,
   meaning North's process already performs well relative to its size while South is the region worth a
   closer look.
3. **No formulaic reorder policy beats the current process**: total cost stays at \$2.4 million under what
   is actually happening, versus \$4.7 million at a 99% service level target, $21.8 million at 95%, and
   \$44.0 million at 80%. Every formulaic candidate costs more because the real stockout rate, 53%,
   already beats what even a 99% target allows, which is up to a 1% stockout rate by construction.
4. **The business's own demand forecast is not the best one available**: a trend based model comes in at
   9.8% mean absolute percentage error, a plain naive guess at 9.0%, and the demand figure already bundled
   with this dataset at 17.0%. The naive guess essentially ties the trend model here, and both clearly
   beat the bundled forecast.

## Recommendations
1. Keep the current inventory process as is. None of the three formulaic safety stock policies tested
   here reduce total cost versus what is already happening.
2. Direct any further inventory attention to Groceries specifically, it combines the highest stockout
   rate with the most revenue of any category, making it the highest value target if stockouts are ever
   worth reducing further.
3. Do not adopt the dataset's bundled demand figure as a planning input. A same period last week estimate
   is simpler and more accurate on this data.
4. Revisit the 7 day lead time and 95% service level assumptions with real supplier and planning data
   before treating the cost comparison above as final, this analysis treats both as planning estimates,
   not measured values.

## Dashboard

![Retail Inventory Optimization & Demand Forecasting Dashboard](https://public.tableau.com/static/images/re/retailinventoryoptforecast/Dashboard1/1.png)

[View the interactive version](https://public.tableau.com/views/retailinventoryoptforecast/Dashboard1)

## Limitations
The 7 day lead time is a stated assumption, not a value in the data, actual supplier lead times may
differ by product or region. The date range falls short of two full seasonal cycles, so the forecast
comparison is trend only rather than seasonally aware, a longer running version of this dataset would
support the fuller model. This is a correlational estimate of lost revenue and holding cost, not a live
experiment, a piloted policy change on a subset of stores would be the way to confirm these numbers hold.