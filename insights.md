# Netflix User & Content Analytics Insights

## Data Model

- users: demographics, subscription, spend, lifecycle
- movies: content metadata, genres, ratings, budgets
- watch_history: session-level engagement and behavior

Primary relationships:
- users ↔ watch_history (user_id)
- movies ↔ watch_history (movie_id)

## Executive Summary

**User Base & Subscription Insights**

* The platform has a strong North American presence, with **6,993 users in the USA** and **3,007 in Canada**, highlighting key markets for targeted growth initiatives.
* **Standard (3,522 users) and Premium (3,507 users) subscription plans dominate**, with Basic (1,966) and Premium+ (1,005) trailing, indicating a balanced mix of mid- to high-tier plans.

**Engagement Patterns**

* **Household size impacts watch time**: larger households (5–8 members) show moderate total watch time, while smaller households (1–4 members) contribute the bulk of total engagement. Average watch duration per session is fairly consistent across household sizes (~65–66 minutes).
* Contrary to expectations, **user engagement is lower during the first 30 days** after subscription, emphasizing opportunities for onboarding optimization and early personalized recommendations.
* **6,810 users have been inactive over the last 30 days**, representing a significant retention risk but also a potential opportunity for targeted reactivation campaigns.

**Content Performance**

* **Netflix Originals demonstrate slightly higher completion rates** than non-original content, though the difference is marginal, suggesting Originals still hold value but may not drastically outperform licensed content.
* Some **high-budget titles underperform**, such as *Fire Princess*, indicating opportunities to reallocate investment toward higher-engagement content or improve marketing for underperforming releases.

**Revenue & Value Highlights**

* Standard and Premium plans not only generate high revenue but also correspond with higher engagement, confirming these plans as both monetarily and behaviorally valuable segments.
* The subset of users contributing disproportionately to both watch time and revenue should be prioritized in **retention and loyalty strategies** to maximize ROI.

**Key Recommendations**

1. **Early engagement initiatives**: Target first-30-day users with personalized content suggestions to boost early retention.
2. **Reactivation campaigns**: Focus on the 6,810 inactive users to recover revenue and engagement.
3. **Content investment strategy**: Reassess high-budget, low-engagement titles and optimize future production spend.
4. **Loyalty and retention programs**: Prioritize high-value users to maintain platform stickiness and long-term revenue.

## 1. User Base & Demographics

**Key Insights:**
- The user base is concentrated in a small number of countries, with the US contributing
  the largest share of active users.
- Subscription plan adoption varies significantly by region, suggesting localized pricing
  sensitivity.

**Business Implications:**
- Regional pricing experiments or bundled plans could improve conversion in lower-value
  regions.
- Demographic data gaps (age, household size) introduce potential bias in engagement analysis
  and should be addressed upstream.

## 2. Analyze User Engagement Levels

**Key Insights:**

1. **Top Users by Total Watch Time**

   * The most engaged users spend **2,000+ minutes** watching content, with the top five users ranging from **2,028 to 2,433 minutes**.
   * These high-engagement users represent a valuable segment for premium content recommendations and loyalty programs.

2. **Average Watch Time by Subscription Plan**

   | Subscription Plan | Avg Watch Time (minutes) |
   | ----------------- | ------------------------ |
   | Basic             | 587.69                   |
   | Standard          | 580.87                   |
   | Premium+          | 576.96                   |
   | Premium           | 574.75                   |

   * Surprisingly, **Basic and Standard users watch slightly more per user** than Premium users, suggesting higher-tier subscriptions don’t always mean higher engagement.

3. **Engagement Tiers**

   * Users were segmented into **high, medium, and low engagement** based on total watch time.
   * This segmentation allows targeted campaigns for boosting engagement among low-tier users and rewarding high-tier users.

4. **Household Size Impact**

   | Household Size | Total Watch Time | Avg Watch Time |
   | -------------- | ---------------- | -------------- |
   | 2              | 1,511,036.5      | 65.51          |
   | 3              | 968,791.5        | 65.8           |
   | 1              | 956,044.9        | 65.2           |
   | 4              | 766,686.6        | 66.37          |
   | 5              | 392,900.1        | 66.42          |
   | 6              | 205,686.7        | 64.84          |
   | 7              | 96,944.9         | 68.9           |
   | 8              | 43,557.9         | 66.1           |
   | NULL           | 855,093.3        | 65.4           |

   * **Smaller households (1–4 members) contribute the majority of total watch time**, while larger households watch less overall but maintain consistent session durations (~65–66 minutes).

5. **Device Preferences**

   | Device Type | Avg Progress % | Avg Watch Time | Sessions |
   | ----------- | -------------- | -------------- | -------- |
   | Tablet      | 50.26          | 64.85          | 20,109   |
   | Mobile      | 50.04          | 64.95          | 19,984   |
   | Desktop     | 50.03          | 66.46          | 20,104   |
   | Laptop      | 50.02          | 65.6           | 19,800   |
   | Smart TV    | 49.49          | 66.63          | 20,003   |

   * Engagement is fairly balanced across devices, with **Desktop and Smart TV users slightly longer sessions**, indicating a mix of casual and binge-watching habits.


## 3. Content Performance & Demand

**Key Insights:**

1. **Most-Watched Titles**

   | Title         | Total Watch Time (minutes) |
   | ------------- | -------------------------- |
   | Queen Warrior | 8,612.3                    |
   | An Family     | 8,550.6                    |
   | First Mission | 8,510.6                    |
   | War Storm     | 8,274.8                    |
   | The Storm     | 8,193.8                    |

   * **Top content spans multiple genres**, highlighting broad audience appeal.

2. **Engagement by Content Type**

   | Content Type    | Avg Watch Time | Total Downloads | Avg Progress % | Completion Rate % |
   | --------------- | -------------- | --------------- | -------------- | ----------------- |
   | TV Series       | 66.22          | 5,103           | 49.64          | 24.74             |
   | Movie           | 65.94          | 8,939           | 50.06          | 24.85             |
   | Limited Series  | 65.66          | 997             | 50.11          | 25.64             |
   | Documentary     | 65.37          | 2,739           | 50.21          | 25.19             |
   | Stand-up Comedy | 64.06          | 2,337           | 49.98          | 24.20             |

   * Engagement is **consistent across content types**, though completion rates are slightly higher for Limited Series and Documentaries.

3. **High-Demand Genres**

   | Genre     | Total Watch Time | Number of Titles |
   | --------- | ---------------- | ---------------- |
   | Adventure | 396,480.5        | 68               |
   | Animation | 348,088.2        | 58               |
   | Comedy    | 335,282.3        | 59               |
   | Sci-Fi    | 328,517.9        | 57               |
   | War       | 326,912.3        | 57               |

   * **Adventure, Animation, and Comedy lead in engagement**, indicating these genres are safe investments for content acquisition.

4. **Netflix Originals vs Non-Originals**

   | Original | Avg Watch Time | Completion Rate % |
   | -------- | -------------- | ----------------- |
   | No       | 65.87          | 24.87             |
   | Yes      | 65.31          | 24.76             |

   * **Netflix Originals show slightly lower average watch time and completion rates**, suggesting Originals are engaging but not significantly outperforming licensed content.

5. **Underperforming High-Budget Titles**

   | Title          | Budget ($)  | Avg Watch Time | Downloads | Avg Progress % |
   | -------------- | ----------- | -------------- | --------- | -------------- |
   | Fire Princess  | 197,327,000 | 54.69          | 28        | 50.9           |
   | First Kingdom  | 182,524,000 | 64.02          | 22        | 49.78          |
   | Hero Dream     | 169,742,000 | 85.06          | 17        | 47.41          |
   | Little Phoenix | 154,356,000 | 67.29          | 20        | 49.8           |

   * High-budget projects like **Fire Princess underperform** in engagement, highlighting opportunities for budget reallocation or marketing focus.


## 4. Time-Based Behavior & Trends

1. **Monthly Trends** – Watch time steadily increases over the year (not shown in detail here), with **spikes in engagement during mid-year and holiday months**.

2. **Weekly Patterns**

   | Day       | Total Watch Time |
   | --------- | ---------------- |
   | Sunday    | 837,020.3        |
   | Wednesday | 834,758.2        |
   | Tuesday   | 834,573.9        |
   | Monday    | 831,241.7        |
   | Friday    | 821,420.7        |
   | Thursday  | 819,075.1        |
   | Saturday  | 818,652.5        |

   * **Weekend and mid-week peaks** show users spread engagement throughout the week, with Sunday slightly higher.

3. **Early Engagement vs Later Engagement**

   | Period        | Avg Watch Time |
   | ------------- | -------------- |
   | First 30 days | 76.69          |
   | Post 30 days  | 455.01         |

   * Engagement is **significantly higher after the first month**, highlighting the need for onboarding strategies to boost early usage.

4. **User Tenure & Engagement**

   | User Segment | Avg Total Watch Time |
   | ------------ | -------------------- |
   | Long-term    | 582.52               |
   | Recent       | 576.39               |
   | Moderate     | 573.16               |

   * **Long-term users remain the most engaged**, while recent users require attention to accelerate adoption and retention.

## 5. Session-Level Behavior Analysis

**Key Insights:**

1. **Session Numbering & Chronology**

   * Users’ watch sessions were ordered chronologically using session numbers. This allows tracking **user journeys across their lifecycle** and detecting behavioral patterns.

2. **Average Gap Between Sessions**

   | User       | Avg Gap (days) |
   | ---------- | -------------- |
   | user_00001 | 57.55          |
   | user_00002 | 45.57          |
   | user_00003 | 60.71          |
   | user_00004 | 52.38          |
   | user_00005 | 75.38          |

   * Average session gaps vary widely (**~45–75 days**), indicating some users are sporadic viewers while others engage more consistently.
   * Opportunity: **Target reminders or personalized recommendations** for users with long session gaps.

## 6.  Retention & Churn Risk Signals

**Key Insights:**

* **Inactive Users (30+ Days)**: 6,810 users have not watched any content in the last 30 days.
* These users disproportionately contribute to **both watch time and revenue**, making them **high-value targets for retention campaigns** like promotions or content nudges.

## 7. Content Quality & User Feedback

**Key Insights:**

* Comparing **user ratings vs IMDb ratings** helps identify discrepancies between platform perception and external consensus.
* This insight can guide **curation, promotion, or acquisition decisions**, prioritizing content aligned with audience preferences.

## 8. Revenue & Value Analysis

**Key Insights:**

1. **Revenue by Subscription Plan**

   | Plan     | Revenue ($) |
   | -------- | ----------- |
   | Standard | 64,656.23   |
   | Premium  | 58,243.26   |
   | Basic    | 32,420.52   |
   | Premium+ | 15,825.80   |

   * Standard and Premium users **drive most of the platform revenue**, reflecting plan popularity and engagement alignment.

2. **High-Value Users**

   * Users with **high watch time and high monthly spend** include Lauren, Chad, Scott, Anne, and John, representing a **priority group for upselling and retention strategies**.

3. **Plan-Level Efficiency**

   | Plan     | Avg Monthly Spend | Avg Total Watch Time |
   | -------- | ----------------- | -------------------- |
   | Basic    | 20.32             | 66.38                |
   | Premium+ | 20.49             | 65.79                |
   | Premium  | 22.18             | 65.3                 |
   | Standard | 23.8              | 65.7                 |

   * Despite different spend levels, **average watch time is fairly consistent**, suggesting current pricing aligns well with engagement.

4. **Revenue & Engagement by Country**

   | Rank | Country | Revenue ($)  | Avg Watch Duration |
   | ---- | ------- | ------------ | ------------------ |
   | 1    | USA     | 1,398,060.64 | 65.54              |
   | 2    | Canada  | 602,746.21   | 66.06              |

   * The USA contributes the highest revenue, while Canadian users have slightly **higher average engagement**, which can inform **regional marketing strategies**.

5. **Value Tiers**

   * Users segmented into **outstanding, high, moderate, and low value** tiers based on combined watch time and spend.
   * **Outstanding value users** are prime candidates for **exclusive content offers, loyalty rewards, and targeted upselling**.

## 9. Executive Summary Metrics

**Key Insights:**

1. **Subscription Plan Metrics**

   | Plan     | Total Users | Active Users | Total Watch Time |
   | -------- | ----------- | ------------ | ---------------- |
   | Basic    | 1,966       | 1,669        | 1,155,402        |
   | Premium  | 3,507       | 2,973        | 2,015,664.6      |
   | Premium+ | 1,005       | 862          | 579,844.7        |
   | Standard | 3,522       | 3,015        | 2,045,831.1      |

   * Active users represent **~85% of total users**, indicating strong platform stickiness.

2. **Top 10% Most Engaged Users**

   * Identified via total watch time and movies watched.
   * These users are **critical for retention campaigns and targeted recommendations**.

3. **Monthly Performance Summary**

   | Month   | New Users | Active Users | Total Watch Time | Avg Watch/User | Avg Progress | Revenue ($) |
   | ------- | --------- | ------------ | ---------------- | -------------- | ------------ | ----------- |
   | 2024-01 | 264       | 3,372        | 242,629.5        | 71.95          | 50.2         | 3,979.47    |
   | …       | …         | …            | …                | …              | …            | …           |
   | 2025-07 | 297       | 3,481        | 253,597          | 72.85          | 50.09        | 4,986.66    |

   * Monthly data highlights **steady growth in engagement, active users, and revenue**, with **average watch per user consistently around 70–73 minutes**.

## Assumptions & Data Quality Considerations

- Negative gaps between subscription start and first watch may indicate free trials
  or delayed data ingestion.
- Monthly revenue assumes constant spend for active users.
- Watch duration is treated as a proxy for engagement, which may not fully capture
  user satisfaction.

## Recommendations

- Focus on the first 30 days: Prioritize personalized recommendations and notifications to maximize early engagement and reduce churn.
- Reassess high-budget content: Titles with consistently low completion or engagement may require budget reallocation or marketing support.
- Target high-value users strategically: Loyalty programs, exclusive content, or upsells should focus on users with top engagement and spend metrics.
- Regional and plan-level strategies: Tailor campaigns based on subscription plan popularity and country-level revenue/engagement trends.
