# Key Findings & Business Recommendations

## How to Read This Document
Each finding follows the same structure:
- **What the data shows** — the actual numbers
- **Why it matters** — the business impact
- **Recommendation** — a specific action the business should take

---

## Finding 1 — Furniture Is Losing Money Despite Strong Sales

**What the data shows**

Furniture is the second highest revenue category but generates near-zero or negative profit.
The Tables sub-category alone lost **-$17,726** across the 4-year period.
The Bookcases sub-category also runs at a loss.
Average discount on Furniture items regularly exceeds 40%.

**Why it matters**

The business is spending money on warehousing, shipping, and handling Furniture
while making little to no return. High sales volume is masking the profitability problem —
revenue looks healthy on the surface but profit tells a different story.

**Recommendation**

> Cap Furniture discounts at 20% maximum. Run a 3-month test removing discounts
> from Tables entirely and monitor whether demand drops. If volume falls less than 15%,
> the margin improvement more than compensates. Consider discontinuing the lowest-margin
> Furniture lines and reallocating that budget toward Technology products.

---

## Finding 2 — The Central Region Is Underperforming

**What the data shows**

The Central region generates similar sales volume to the East and West regions
but consistently produces lower profit. Several Central states including Texas
and Illinois show negative total profit across the 4-year period.

**Why it matters**

The Central region is not converting sales into profit at the same rate as other regions.
This suggests either a pricing problem (deeper discounts being offered), a product mix problem
(selling more low-margin products), or an operational cost problem (higher shipping costs
to Central locations).

**Recommendation**

> Conduct a discount audit specifically for Central region sales reps. If average discounts
> in Central exceed 30% compared to 20% in East and West, introduce approval requirements
> for discounts above 25% in that region. Also review the product mix — if Central sales
> are skewed toward Furniture and Office Supplies rather than Technology, incentivise
> reps to upsell higher-margin product categories.

---

## Finding 3 — Discounts Above 40% Always Destroy Profit

**What the data shows**

Orders with a discount above 40% show negative profit margin across all three categories —
Technology, Furniture, and Office Supplies. There is no product category where a 40%+
discount results in a profitable order. The correlation between discount rate and profit
is strongly negative — the higher the discount, the worse the margin.

**Why it matters**

Discounting is being used as a sales tool without a profit floor in place.
Sales reps are likely using heavy discounts to close deals quickly,
which inflates order volume and revenue figures while destroying the bottom line.

**Recommendation**

> Implement a hard discount cap of 30% across all categories with no exceptions.
> For discounts between 20–30%, require manager approval. Share a monthly report
> with the sales team showing profit margin by discount band — make the impact
> of over-discounting visible. Introduce a commission structure that rewards
> profit margin, not just revenue, to align incentives.

---

## Finding 4 — Corporate Segment Has Higher Order Value Than Consumer

**What the data shows**

The Corporate segment has a higher average order value than the Consumer segment
despite Consumer accounting for 50.56% of total revenue vs Corporate's 30.74%.
Corporate customers order less frequently but spend more per order.
Home Office has the smallest share at 18.70%.

**Why it matters**

Corporate customers represent a more efficient revenue source — fewer transactions,
larger basket size, and typically lower customer acquisition cost per dollar of revenue.
Growing the Corporate segment by even 5% would have an outsized impact on profit
compared to growing Consumer by the same amount.

**Recommendation**

> Create a dedicated Corporate account programme. Identify the top 20 Corporate
> customers by lifetime value and assign them a dedicated account manager.
> Introduce volume pricing tiers (e.g. 5% loyalty discount at $10K annual spend)
> to increase retention and grow average order value further. Target Consumer
> customers who have placed 3+ orders for conversion into Corporate accounts
> — they already show buying intent and switching them to B2B pricing improves margins.

---

## Summary Table

| Finding | Revenue Impact | Urgency | Effort to Fix |
|---------|---------------|---------|---------------|
| Furniture discounting destroying profit | **High** — $17K+ lost on Tables alone | Immediate | Low — policy change |
| Central region underperforming | **Medium** — consistent margin gap vs other regions | Short term | Medium — requires sales process change |
| 40%+ discounts always unprofitable | **High** — affects all categories | Immediate | Low — cap policy |
| Corporate segment underinvested | **High** — high AOV, lower acquisition cost | Medium term | Medium — account programme build |

---

## SQL Queries Used to Validate These Findings

All queries are in `/sql/superstore_analysis.sql`

Key queries that support these findings:
- **Q3** — Sub-categories with negative profit (validates Finding 1)
- **Q7 & Q8** — Regional performance and loss-making states (validates Finding 2)
- **Q3** — Discount vs profit correlation (validates Finding 3)
- **Q4** — Revenue and order count by segment (validates Finding 4)
