CREATE OR REPLACE TABLE loans AS
SELECT * FROM read_csv_auto('../notebooks/data/processed/lending_club_clean.csv');

WITH q AS (
  SELECT quantile_cont(int_rate, 0.25) AS q25,
         quantile_cont(int_rate, 0.50) AS q50,
         quantile_cont(int_rate, 0.75) AS q75
  FROM loans
)
SELECT
  CASE WHEN l.int_rate <= q.q25 THEN 'A: Lowest rate'
       WHEN l.int_rate <= q.q50 THEN 'B'
       WHEN l.int_rate <= q.q75 THEN 'C'
       ELSE 'D: Highest rate' END AS risk_tier,
  COUNT(*) AS n_loans,
  ROUND(100.0 * AVG(l.bad_loan), 1) AS default_rate_pct,
  ROUND(AVG(l.int_rate), 2) AS avg_int_rate
FROM loans l, q GROUP BY 1 ORDER BY 1;

SELECT purpose, COUNT(*) AS n, ROUND(100.0 * AVG(bad_loan), 1) AS default_rate_pct, SUM(loan_amnt) AS total_exposure
FROM loans GROUP BY purpose ORDER BY default_rate_pct DESC;
