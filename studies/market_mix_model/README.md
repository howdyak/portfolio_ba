# Marketing Mix & Channel Efficiency Analysis

## Executive Summary
Revenue per marketing dollar rose from \$1.48 in 2018 to a peak of \$1.86 in 2019, then settled at \$1.54
to \$1.58 in 2020 and 2021. Google Ads grew from 18.3% to 25.7% of total spend over that period, the
largest gain of any channel. We tested two different ways of crediting each channel for sales and ruled
out the two most likely reasons they might disagree, so the gap between them is real rather than a data
problem. The more trustworthy estimate puts Google Ads at \$0.91 in sales per dollar spent, the other
closer to \$1.73, and all three channels are confirmed to genuinely drive sales either way. Recommendation:
shift some additional budget toward Google Ads now using the \$0.91 figure, and test further before
committing to the higher estimate.

## Business Context
Budget has historically split close to evenly across TikTok, Facebook, and Google Ads out of habit
rather than any evidence about which channel actually performs best. This analysis checks whether
that even split matches what the data supports, and whether any channel's budget can be shifted with
real confidence.

## Data & Methodology
Source: orosas/marketing mix dataset via Kaggle. 200 weekly observations running from January 7, 2018
through October 31, 2021. Channel attribution was tested with three specs built on adstocked spend: an unconstrained linear regression (Spec A), a non
negative least squares regression (Spec B), and a version of Spec A with a log based saturation curve
applied (Spec C), to check separately whether collinearity or a non linear relationship explains any
disagreement between models. Variance inflation factor was used to test collinearity directly, and 500
rounds of bootstrap resampling produced a 90% confidence interval for each channel's coefficient under
Specs A and B.

| Field | Business Meaning | Type | Notes |
|---|---|---|---|
| `Date` | Reporting period | date | weekly |
| `TikTok`, `Facebook`, `Google Ads` | Channel spend | numeric, $ | |
| `Sales` | Revenue | numeric, $ | |

## Key Findings
1. **Efficiency trend**. Revenue per media dollar rose from \$1.48 to \$1.54 between 2018 and 2020, both
   full years, after peaking at \$1.86 in 2019. 2021 came in at \$1.58, but only covers 44 of 52 weeks.
2. **Mix shift**. Spend moved from 48.8% TikTok, 32.9% Facebook, and 18.3% Google Ads in 2018 to 42.7%,
   31.6%, and 25.7% in 2021. Google Ads gained more share than any other channel, and its best year for
   spend share (2019, at 30.8%) is also the best year for overall efficiency.
3. **The disagreement between models has a real explanation**. Variance inflation factor is low for
   every channel (TikTok 2.0, Facebook 2.7, Google Ads 3.0), so collinearity is not why the two linear
   specs disagree. Adding a saturation curve made the fit worse instead of better (R squared dropped
   from 0.898 to 0.488), so a non linear relationship is not the explanation either. What is actually
   going on is that Spec A simply fits the data better than Spec B (R squared 0.898 versus 0.746), and
   the constraint that forces Spec B's coefficients to stay positive is what inflates its Google Ads
   estimate to \$1.73 per dollar, compared to \$0.91 under Spec A. Their confidence intervals do not
   overlap (\$0.81 to \$1.01 versus \$1.65 to \$1.81), so this is a real disagreement, not just noise.
   TikTok is the exception: its two estimates are close enough that the confidence intervals essentially
   touch at $0.38, making it the most reliably estimated channel of the three. Every channel's interval
   stays clear of zero, so all three have a confirmed positive effect on sales. The open question is how
   large that effect is for Google Ads and Facebook, not whether it exists at all.
4. **Sales decomposition**. Splitting predicted sales into baseline demand plus each channel's
   contribution shows each channel's attributed sales tracking its own spend closely from year to year.
   Google Ads' contribution peaked in 2019 at about \$152,800, the same year it had its highest spend
   share, and was lowest in 2018 at about \$124,200, its lowest spend share year. TikTok's contribution
   swings from about \$134,200 in 2018 down to \$65,700 in 2019 and back up to \$131,600 in 2020, following
   its spend almost exactly. This is expected under a model that assumes each channel's per dollar effect
   stays constant over time. It shows where the sales are coming from given that assumption, not whether
   any channel actually became more or less effective.

## Recommendations
1. Shift some incremental budget toward Google Ads now, using Spec A's \$0.91 per dollar estimate since
   it comes from the better fitting model. Both specs agree it is the strongest channel.
2. Run a confirmatory incrementality test on Google Ads before committing to a larger move based on Spec
   B's \$1.73 estimate. The two models' confidence intervals do not overlap, so the actual size of the
   effect is still uncertain even though the direction is not.
3. Leave TikTok's budget where it is for now. Its two estimates are the closest of the three channels,
   making it the most reliable number here, and that number is also the lowest of the three.
4. Facebook sits in the middle. The two specs disagree (\$0.43 versus \$0.62) but not as sharply as they
   do for Google Ads. Treat it as a lower priority candidate for the same kind of test if testing
   capacity is limited.

## Dashboard
![Marketing Mix & Channel Efficiency Dashboard](https://public.tableau.com/static/images/ma/market_mix_final/Dashboard1/1.png)

[View the interactive version](https://public.tableau.com/views/market_mix_final/Dashboard1)

## Limitations
2021 only has 44 of its 52 weeks, so its \$1.58 figure is not fully comparable to the three complete
years before it if spend or efficiency shifts seasonally toward year end. The sales decomposition
assumes each channel's per dollar effect is constant across the whole period, so it reflects changes in
spend, not changes in effectiveness. Ruling out the log based saturation curve does not rule out every
possible non linear relationship, just that particular one. This is correlational, not causal. An
incrementality test remains the only way to directly confirm how much Google Ads is really driving.