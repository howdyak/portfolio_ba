# Consumer Loan Portfolio Risk & Profitability Analysis

## Executive Summary
Net expected value per loan rises from \$2,382 at the lowest rate tier to \$5,121 at the highest, because
risk based pricing compensates for added default risk on average. That average hides real variation
within tiers. Four narrower underwriting rules were tested against each loan's actual realized cash flow
rather than an assumed interest figure, and the result splits two ways. Declining small business loans
with DTI above 20 would have added \$2.1M in value, \$538 per loan across 3,845 loans. Declining loans with
DTI above 30 generally would have added \$1.5M, but only \$13 per loan across 123,487 loans, too thin a
margin to act on with confidence. The other two rules tested still destroy value if declined: DTI above 25
combined with revolving utilization above 80 would have cost \$27.1M, and the worst rule, revolving
utilization above 90 alone, would have cost $75.2M. Recommendation: decline the small business plus DTI
above 20 segment, treat the DTI above 30 result as inconclusive, and keep current pricing on the two
segments that still lose money if declined.

## Business Context
The underwriting team has periodically considered declining loans in higher risk segments outright,
specifically high DTI, high revolving utilization, and certain loan purposes, on the logic that these
borrowers default more often and represent avoidable risk. That instinct treats default rate as the only
signal that matters, without weighing it against the interest premium already charged on those same loans.
This analysis tests that instinct against the portfolio's actual historical outcomes, using each loan's
real realized payments rather than an assumed interest figure, before it becomes policy: do these
segments' higher default rates actually make them unprofitable to keep, or does current pricing already
compensate for the additional risk?

## Data & Methodology
Source: Kaggle Lending Club Loan Data, 1,041,952 resolved loans (Fully Paid, Charged Off, or Default;
loans still Current or in a grace period were excluded since they have no final outcome yet). Risk tiers
built from interest rate quartiles use the standard credit risk framework Expected Loss = PD x LGD x EAD,
with LGD assumed at 60% (industry standard planning figure for unsecured consumer credit). The
underwriting rule simulation in Key Finding 2 does not use LGD or an assumed interest rate; it compares
each loan's actual realized cash flow, total amount paid plus any recoveries after charge off, against its
original principal, so the result reflects what actually happened rather than a modeled assumption.

| Field | Business Meaning | Type | Notes |
|---|---|---|---|
| `loan_amnt` | Amount funded | numeric, $ | exposure (EAD) |
| `int_rate` | Annual interest rate | numeric, % | basis for risk tiers |
| `bad_loan` | Target: charged off/defaulted | binary | derived from `loan_status`; 20% overall rate |
| `dti`, `revol_util`, `delinq_2yrs` | Risk factors | numeric | used in the underwriting simulation |
| `purpose` | Loan purpose | categorical | used in risk-driver analysis |
| `total_pymnt`, `recoveries` | Realized cash flow | numeric, $ | actual amount collected and recovered per loan; basis for the underwriting simulation |

## Key Findings
1. **Risk based pricing already works on average**: net expected value per loan rises from \$2,382
   (Tier A, 8% default rate) to \$5,121 (Tier D, 34% default rate).
2. **Underwriting rules show mixed results once tested against real cash flow**: of four rules tested,
   two would have added value if applied historically. Small business loans with DTI above 20: +\$2.1M net,
   +$538 per loan across 3,845 loans. DTI above 30 generally: +\$1.5M net, but only +\$13 per loan across
   123,487 loans, too small a margin to call a real signal. The other two destroy value: DTI above 25
   combined with revolving utilization above 80 costs \$27.1M, and the worst rule, revolving utilization
   above 90 alone, costs \$75.2M.
3. **Small business loans with high DTI are the one segment worth declining**: small business loans
   overall carry a 29.7% default rate on \$235M of exposure. Narrowing to small business loans with DTI
   above 20 specifically (3,845 loans, 35.2% default rate) shows this cut is underpriced for its risk.
   Declining it would have realized \$538 more per loan than was actually collected, $2.1M in total.

## Recommendations
1. Decline small business loans with DTI above 20. This is the one rule tested that clearly adds value
   based on realized outcomes, \$538 per loan.
2. Do not decline based on revolving utilization above 90 or the combined DTI above 25 and revolving
   utilization above 80 rule; both destroy value, the worst by $75.2M.
3. Treat the DTI above 30 result as inconclusive. Its net impact is positive but only $13 per loan, thin
   enough to be noise; investigate further before acting on it alone.
4. Validate the small business plus DTI above 20 decline rule against a small live holdout before full
   rollout. This is a retrospective read on loans the platform already priced and approved, so it doesn't
   capture adverse selection a new live policy might introduce.

## Dashboard

![Consumer Loan Portfolio Risk & Profitability Dashboard](https://public.tableau.com/static/images/lo/loan-pf-risk/Dashboard2/1.png)

[View the interactive version](https://public.tableau.com/views/loan-pf-risk/Dashboard2)

## Limitations
Interest rate tier is a proxy for credit grade, not the grade itself. The risk tier analysis (Key
Finding 1) uses a stated LGD planning assumption rather than full loan level amortization. The
underwriting rule simulation (Key Findings 2 and 3) avoids that assumption by using each loan's actual
realized cash flow instead, but is retrospective on loans the platform already priced and approved, so it
doesn't capture adverse selection a new live underwriting policy might introduce. Restricted to resolved
loans, so it excludes recently originated, still performing loans.