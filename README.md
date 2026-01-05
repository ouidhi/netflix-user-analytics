# Netflix Analytics using SQL

This project analyzes a Netflix-style relational dataset to uncover insights about
user behavior, content performance, engagement trends, and revenue drivers using SQL.

The goal is to demonstrate advanced SQL querying and analytical thinking through
business-driven questions rather than isolated queries.

## Tech Stack
- MySQL
- SQL (CTEs, window functions, joins, aggregations, time-based analysis)

## Dataset Overview

The database consists of three core tables:

- users: user demographics, subscription details, lifecycle, and spend
- movies: content metadata including genres, ratings, budgets, and originality
- watch_history: session-level viewing behavior and engagement metrics

These tables are linked through foreign key relationships on user_id and movie_id.

## Key Business Questions

This analysis focuses on answering questions such as:

- Who are Netflix’s users and how are they distributed geographically?
- How does engagement vary across subscription plans and devices?
- Which content types and genres drive the most watch time?
- How does user engagement change over time and across the user lifecycle?
- Which users and regions contribute the most revenue and value?

## Key Skills Used

- Relational database design and schema creation
- Complex joins across multiple tables
- Common Table Expressions (CTEs) for layered analysis
- Window functions (ROW_NUMBER, LAG, NTILE)
- Time-series and lifecycle analysis
- Business-focused analytical reasoning using SQL

## How to Use

1. Create the database and tables using `schema.sql`
2. Load the dataset
3. Run queries from `queries.sql` to reproduce the analysis
4. Review `insights.md` for summarized findings and business implications

## Contact ⋆˙⟡

🔗 [LinkedIn](https://www.linkedin.com/in/vidhi-parmar1/) | [Email](vidhi30th@gmail.com) | [Website](https://readymag.website/5667522/)

