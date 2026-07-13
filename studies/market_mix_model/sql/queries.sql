CREATE OR REPLACE TABLE mmm AS
SELECT * FROM read_csv_auto('../notebooks/data/processed/mmm_clean.csv');

SELECT year, ROUND(SUM(Sales) / SUM(total_spend), 2) AS revenue_per_dollar
FROM mmm GROUP BY year ORDER BY year;

SELECT year,
  ROUND(100.0 * SUM(TikTok)     / SUM(total_spend), 1) AS tiktok_pct,
  ROUND(100.0 * SUM(Facebook)   / SUM(total_spend), 1) AS facebook_pct,
  ROUND(100.0 * SUM("Google Ads") / SUM(total_spend), 1) AS google_pct
FROM mmm GROUP BY year ORDER BY year;