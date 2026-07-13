CREATE OR REPLACE TABLE inventory AS
SELECT * FROM read_csv_auto('../notebooks/data/processed/retail_inventory_clean.csv');

SELECT category,
  ROUND(100.0 * AVG(CASE WHEN inventory_level = 0 THEN 1 ELSE 0 END), 1) AS stockout_rate_pct,
  SUM(revenue) AS total_revenue
FROM inventory GROUP BY category ORDER BY stockout_rate_pct DESC;

SELECT region,
  ROUND(AVG(inventory_level), 1) AS avg_inventory,
  ROUND(AVG(units_sold), 1) AS avg_units_sold
FROM inventory GROUP BY region ORDER BY avg_inventory DESC;
