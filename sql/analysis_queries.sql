-- NETFLIX ANALYTICS
/*
   BUSINESS OBJECTIVE 1: UNDERSTAND THE USER BASE
   Why: Before making any product or content decisions,
        we need to know who our users are and where they come from.
*/
USE netflix_analytics;

/* Q1. How many users do we have in each country?
       Identify the geographic distribution of the user base. */
SELECT country, 
		COUNT(*) AS user_count
FROM users
GROUP BY country
ORDER BY user_count DESC;

/* Q2. What is the breakdown of users by subscription_plan?
       Which plans are most popular? */
SELECT subscription_plan, 
		COUNT(*) AS user_count
FROM users
GROUP BY subscription_plan
ORDER BY user_count DESC;

/* Q3. How does average monthly_spend differ by country and subscription_plan?
       Are certain regions more valuable? */
SELECT country, 
		subscription_plan, ROUND(AVG(monthly_spend), 2) AS avg_monthly_spend
FROM users
GROUP BY country, subscription_plan
ORDER BY avg_monthly_spend DESC;

/* Q4. Are inactive users concentrated in specific countries or plans?
       (Filter inactive users and group accordingly.) */
SELECT country, 
		subscription_plan, COUNT(*) AS inactive_user_count
FROM users
WHERE is_active = FALSE
GROUP BY country, subscription_plan
ORDER BY inactive_user_count DESC;

/* Q5. What percentage of users are missing key demographic information
       such as age or household_size?
       This helps assess data quality and bias. */
SELECT 
ROUND(COUNT(CASE
		WHEN age IS NULL OR household_size IS NULL THEN 1 
	  END) * 100 / COUNT(*), 2) AS percent_of_users
FROM users;

/*
   BUSINESS OBJECTIVE 2: ANALYZE USER ENGAGEMENT LEVELS
   Why: Engagement drives retention and revenue.
        We want to quantify how much users actually watch.
*/

/* Q6. What is the total watch time per user?
       Rank users from most to least engaged. */
SELECT user_id, 
		ROUND(SUM(watch_duration_minutes),2) AS total_watch_time
FROM watch_history
GROUP BY user_id
ORDER BY total_watch_time DESC;

/* Q7. How does average watch_duration_minutes per session
       differ across subscription plans? */
WITH per_user AS (
SELECT u.user_id, subscription_plan,
		ROUND(SUM(watch_duration_minutes),2) AS user_watch_time
FROM users u 
LEFT JOIN watch_history w 
    USING (user_id)
GROUP BY u.user_id, subscription_plan
)
SELECT subscription_plan,
		ROUND(AVG(user_watch_time),2) AS avg_watch_time
FROM per_user
GROUP BY subscription_plan
ORDER BY avg_watch_time DESC;

/* Q8. Segment users into engagement tiers (low, medium, high)
       based on total watch time. */

WITH watch_times AS
(SELECT u.user_id, 
		subscription_plan, 
		ROUND(SUM(watch_duration_minutes), 2) AS total_watch_time
FROM users u 
LEFT JOIN watch_history w 
    USING (user_id)
GROUP BY u.user_id),

labelled AS (
SELECT user_id, 
		subscription_plan, 
		NTILE(3) OVER(ORDER BY total_watch_time DESC) AS labels
FROM watch_times)

SELECT user_id, subscription_plan, 
	CASE
		WHEN labels = 1 THEN 'high'
		WHEN labels = 2 THEN 'medium'
		WHEN labels = 3 THEN 'low'
	END AS engagement_tier
FROM labelled;

/* Q9. Do users with larger household_size watch more content on average?
       Compare total and average watch time per household size. */
SELECT household_size, 
	ROUND(SUM(watch_duration_minutes), 2) AS total_watch_time,
	ROUND(AVG(watch_duration_minutes), 2) AS avg_watch_time
FROM users u 
JOIN watch_history w
    USING (user_id)
GROUP BY household_size
ORDER BY total_watch_time, avg_watch_time;

/* Q10. What devices are associated with the highest average
        progress_percentage and watch duration? */
SELECT device_type, 
		ROUND(AVG(progress_percentage), 2) AS avg_progress_percentage,
		ROUND(AVG(watch_duration_minutes), 2) AS avg_watch_duration_minutes,
        COUNT(*) AS num_sessions
FROM watch_history 
GROUP BY device_type
ORDER BY avg_progress_percentage DESC, 
		avg_watch_duration_minutes DESC, 
		num_sessions DESC;

/* 
   BUSINESS OBJECTIVE 3: CONTENT PERFORMANCE & DEMAND
   Why: The platform needs to know what content actually performs,
        not just what exists in the catalog.
*/

/* Q11. Which movies or series have the highest total watch time? */
SELECT m.movie_id,
		title,
        ROUND(SUM(watch_duration_minutes), 2) AS total_watch_time
FROM movies m 
LEFT JOIN watch_history w
    USING (movie_id)
GROUP BY m.movie_id, title
ORDER BY total_watch_time DESC;

/* Q12. How does engagement differ by content_type
        (Movie vs TV Series vs Documentary)? */
-- avg watch duration, total download, avg progress_percentage, 
-- completion rate (count action= completed/count action)
SELECT m.content_type,
		ROUND(AVG(watch_duration_minutes), 2) AS avg_watch_time,
        SUM(CASE WHEN is_download = TRUE THEN 1 ELSE 0 END),
        ROUND(AVG(progress_percentage), 2) AS avg_progress_percentage,
        ROUND(COUNT(CASE
				WHEN action = 'completed' THEN 1 
			END) * 100 / COUNT(session_id), 2) AS completion_rate
FROM movies m
JOIN watch_history w
    USING (movie_id)
GROUP BY m.content_type
ORDER BY avg_watch_time DESC,
        avg_progress_percentage DESC,
        completion_rate DESC;

/* Q13. Which primary genres drive the most total watch time? */

SELECT genre_primary, 
		ROUND(SUM(watch_duration_minutes), 2) AS total_watch_time,
        COUNT(DISTINCT m.movie_id) AS title_count
FROM movies m
JOIN watch_history w
    USING (movie_id)
GROUP BY genre_primary
ORDER BY total_watch_time DESC;
	
WITH t AS (
SELECT genre_primary, 
		ROUND(SUM(watch_duration_minutes), 2) AS total_watch_time,
        COUNT(DISTINCT m.movie_id) AS title_count
FROM movies m
JOIN watch_history w
    USING (movie_id)
GROUP BY genre_primary
),
min_count AS (
SELECT *, MIN(title_count) OVER() AS min_titles
FROM t)
SELECT genre_primary, total_watch_time, title_count
FROM min_count
WHERE title_count = min_titles
ORDER BY total_watch_time DESC;


/* Q14. Are Netflix Originals more engaging than non-original content?
        Compare average watch time and completion rates. */
SELECT is_netflix_original, ROUND(AVG(watch_duration_minutes), 2) AS avg_watch_time,
		ROUND(COUNT(CASE
						WHEN action = 'completed' THEN 1
					END) * 100 / COUNT(*), 2) AS completion_rate
FROM movies m
JOIN watch_history w
	USING (movie_id)
GROUP BY is_netflix_original
ORDER BY avg_watch_time DESC;


/* Q15. Identify underperforming content:
        movies with high production_budget but low engagement. */
SELECT movie_id, title,
	production_budget, 
    ROUND(AVG(watch_duration_minutes), 2) AS avg_watch_time,
	SUM(is_download) AS total_downloads,
	ROUND(AVG(progress_percentage), 2) AS avg_progress_percentage
FROM movies m 
JOIN watch_history w
	USING (movie_id)
WHERE production_budget IS NOT NULL
GROUP BY movie_id
ORDER BY production_budget DESC,
		avg_watch_time,
		total_downloads,
        avg_progress_percentage;
	
/*
   BUSINESS OBJECTIVE 4: TIME-BASED BEHAVIOR & TRENDS
   Why: Engagement changes over time.
        Time analysis helps detect trends and seasonality.
*/

/* Q16. How does total watch time trend month over month?
        Aggregate watch_duration_minutes by month. */
WITH dated AS (
SELECT DATE_FORMAT(watch_date, "%Y, %M") AS Month,
		DATE_FORMAT(watch_date, "%Y, %m") AS Month2,
		ROUND(SUM(watch_duration_minutes), 2) AS total_watch_time
FROM watch_history
GROUP BY Month, Month2
)
SELECT Month, total_watch_time
FROM dated
ORDER BY Month2;

/* Q17. Which days of the week see the highest viewing activity?
        Use date functions to extract weekday patterns. */
SELECT DATE_FORMAT(watch_date, "%W") AS Day,
		ROUND(SUM(watch_duration_minutes), 2) AS total_watch_time
FROM watch_history
GROUP BY Day
ORDER BY total_watch_time DESC;

/* Q18. How soon after subscription_start_date do users
        typically watch their first piece of content? */
WITH diff AS
(
SELECT u.user_id, subscription_start_date,
		MIN(watch_date) AS first_watch
FROM users u
JOIN watch_history w
	USING (user_id)
GROUP BY u.user_id
)
SELECT *, 
	DATEDIFF(first_watch, subscription_start_date) AS days_between
FROM diff
ORDER BY days_between DESC;
-- note: some are negative which could be due to free trials, low data colleciton quality.

/* Q19. Compare user engagement in their first 30 days
        versus later periods of their lifecycle. */
WITH days_sum AS (
SELECT u.user_id, 
		SUM(CASE
				WHEN watch_date BETWEEN subscription_start_date 
								AND date_add(subscription_start_date, INTERVAL 30 DAY)
				THEN watch_duration_minutes
			END) AS first_30_days,
		SUM(CASE
				WHEN watch_date > date_add(subscription_start_date, INTERVAL 30 DAY)
				THEN watch_duration_minutes
			END) AS after_first_30_days
FROM users u
JOIN watch_history w
	USING(user_id)
GROUP BY u.user_id
)
SELECT ROUND(AVG(first_30_days), 2) AS avg_watch_time_first_30_days,
		ROUND(AVG(after_first_30_days), 2) AS avg_watch_time_post_30_days
FROM days_sum;
			
/* Q20. Are newer users (recent created_at)
        more or less engaged than long-term users? */

WITH labels AS ( 
SELECT u.user_id,
	ROUND(SUM(watch_duration_minutes), 2) AS total_watch_time,
    CASE
		WHEN DATEDIFF(CURDATE(), DATE(created_at)) <= 200 THEN "recent"
        WHEN DATEDIFF(CURDATE(), DATE(created_at)) BETWEEN 200 AND 500 THEN "moderate"
        WHEN DATEDIFF(CURDATE(), DATE(created_at)) > 500 THEN "long-term"
    END AS label
FROM users u
JOIN watch_history w 
	USING(user_id)
GROUP BY u.user_id
)
SELECT label, ROUND(AVG(total_watch_time), 2) AS avg_total_watch_time
FROM labels
GROUP BY label
ORDER BY avg_total_watch_time DESC;


/*
   BUSINESS OBJECTIVE 5: SESSION-LEVEL BEHAVIOR ANALYSIS
   Why: Understanding session patterns helps improve UX
        and recommendation timing.
*/

/* Q21. For each user, order watch sessions chronologically
        and assign a session number using ROW_NUMBER. */
SELECT user_id, session_id, watch_date,
		ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY watch_date) AS session_num
FROM watch_history
ORDER BY user_id, session_num;

/* Q22. Calculate the average time gap (in days) between consecutive
        watch sessions for each user using LAG. */
WITH prev_dates AS (
SELECT user_id, session_id, watch_date,
		LAG(watch_date) OVER(PARTITION BY user_id ORDER BY watch_date) AS prev_watch_date
FROM watch_history
),
time_gaps AS (
SELECT user_id, session_id, watch_date, prev_watch_date,
		DATEDIFF(watch_date, prev_watch_date) AS time_gap
FROM prev_dates 
WHERE prev_watch_date IS NOT NULL
)
SELECT user_id, ROUND(AVG(time_gap), 2) AS avg_time_gap
FROM time_gaps
GROUP BY user_id
ORDER BY user_id;

/* =========================================================
   BUSINESS OBJECTIVE 6: RETENTION & CHURN RISK SIGNALS
   Why: Retaining users is cheaper than acquiring new ones.
        SQL can help identify early churn indicators.
   ========================================================= */

/* Q23. Identify users who have not watched anything
        in the last 30 days. */
WITH inactivity AS
(
SELECT user_id, MAX(watch_date) as last_watch_date
FROM watch_history
GROUP BY user_id
HAVING last_watch_date < date_sub(CURDATE(), INTERVAL 30 DAY)
ORDER BY user_id
)
SELECT COUNT(*) AS inactive_users
FROM inactivity;

/* =========================================================
   BUSINESS OBJECTIVE 7: CONTENT QUALITY & USER FEEDBACK
   Why: Engagement is not just about time spent,
        but also satisfaction and perceived quality.
   ========================================================= */

/* Q24. Compare average user_rating with imdb_rating
        to see if platform users agree with external ratings. */
SELECT m.movie_id,
		ROUND(AVG(user_rating), 2) AS avg_user_rating,
        round(AVG(imdb_rating), 2) AS avg_imdb_rating
FROM movies m 
LEFT JOIN watch_history w 
	USING (movie_id)
GROUP BY m.movie_id
ORDER BY m.movie_id;

/*
   BUSINESS OBJECTIVE 8: REVENUE & VALUE ANALYSIS
   Why: Engagement must translate into revenue
        for the platform to be sustainable.
*/

/* Q25. Calculate total revenue contribution per subscription_plan
        using monthly_spend and active users. */
SELECT subscription_plan, ROUND(SUM(monthly_spend), 2) AS revenue
FROM users
WHERE is_active IS TRUE
GROUP BY subscription_plan
ORDER BY revenue DESC;

/* Q26. Identify high-value users:
        users with both high watch time and high monthly_spend. */
WITH metrics AS (
SELECT user_id, first_name,
		monthly_spend, 
        ROUND(SUM(watch_duration_minutes), 2) AS total_watch_duration
FROM users u 
JOIN watch_history w 
	USING(user_id)
GROUP BY u.user_id 
),
tiles AS (
SELECT *,
		NTILE(4) OVER(ORDER BY monthly_spend DESC) AS spend_tiers,
        NTILE(4) OVER(ORDER BY total_watch_duration DESC) AS total_watch_time_tiers
FROM metrics
)
SELECT user_id, first_name,
		monthly_spend, total_watch_duration
FROM tiles
WHERE spend_tiers = 1 AND total_watch_time_tiers=1
ORDER BY monthly_spend DESC, total_watch_duration DESC;

/* Q27. Compare engagement and spend across plans
        to assess pricing efficiency. */
-- find the total watch time per user

SELECT subscription_plan,
		ROUND(AVG(monthly_spend), 2) AS avg_monthly_spend,
        ROUND(AVG(watch_duration_minutes), 2) AS avg_total_watch_time
FROM users u
JOIN watch_history w
	USING(user_id)
GROUP BY subscription_plan
ORDER BY avg_monthly_spend, avg_total_watch_time;

/* Q28. Rank countries by total revenue contribution
        and average engagement. */
WITH metrics AS (
SELECT location_country, 
		SUM(monthly_spend) AS revenue,
        AVG(watch_duration_minutes) AS avg_watch_duration_minutes
FROM users u
JOIN watch_history w
	USING(user_id)
GROUP BY location_country
)
SELECT ROW_NUMBER() OVER(ORDER BY revenue DESC, avg_watch_duration_minutes DESC) AS country_rank,
		location_country, ROUND(revenue, 2) AS revenue, 
		ROUND(avg_watch_duration_minutes, 2) AS avg_watch_duration_minutes
FROM metrics;

/* Q29. Segment users into value tiers using NTILE
        based on combined engagement and spend metrics. */
WITH metrics AS (
SELECT u.user_id, first_name,
		ROUND(SUM(watch_duration_minutes), 2) AS total_watch_duration,
        monthly_spend
FROM users u
JOIN watch_history w
	USING(user_id)
GROUP BY u.user_id
),
tiers AS (
SELECT user_id, first_name,total_watch_duration, monthly_spend,
		NTILE(4) OVER(ORDER BY total_watch_duration, monthly_spend DESC) AS tier
FROM metrics
)
SELECT user_id, first_name, 
		CASE 
			WHEN tier = 1 THEN 'outstanding_value'
            WHEN tier = 2 THEN 'high_value'
            WHEN tier = 3 THEN 'moderate_value'
            WHEN tier = 4 THEN 'low_value'
		END AS label
FROM tiers;

/*
   BUSINESS OBJECTIVE 9: EXECUTIVE SUMMARY METRICS
   Why: Stakeholders need a concise snapshot of platform health.
*/

/* Q30. For each subscription_plan, calculate:
        - total users
        - active users
        - total watch time */
        
WITH user_counts AS ( 
SELECT subscription_plan,
	COUNT(*) AS total_users,
    SUM(is_active IS TRUE) AS active_users
FROM users 
GROUP BY subscription_plan
),
metrics AS (
SELECT subscription_plan, 
		ROUND(SUM(watch_duration_minutes), 2) AS total_watch_time
FROM users u 
LEFT JOIN watch_history W
	USING(user_id)
GROUP BY subscription_plan
)
SELECT *
FROM user_counts 
JOIN metrics
	USING (subscription_plan)
ORDER BY subscription_plan;
 
/* Q31. Identify the top 10% most engaged users */
WITH metrics AS (
SELECT 
		u.user_id,
		ROUND(SUM(watch_duration_minutes), 2) AS total_watch_time,
        COUNT(DISTINCT movie_id) AS movies_watched
FROM users u
JOIN watch_history w
	USING(user_id)
GROUP BY u.user_id
),
ranked AS (
SELECT *,
	NTILE(10) OVER(ORDER BY total_watch_time DESC, movies_watched DESC) AS decile
FROM metrics
)
SELECT user_id, total_watch_time, movies_watched
FROM ranked
WHERE decile = 1;

/* Q32. Monthly business performance summary */

WITH monthly_users AS (
    SELECT 
        DATE_FORMAT(created_at, '%Y-%m') AS month,
        COUNT(*) AS new_users
    FROM users
    GROUP BY month
),
monthly_watch AS (
    SELECT 
        DATE_FORMAT(watch_date, '%Y-%m') AS month,
        COUNT(DISTINCT user_id) AS active_users,
        ROUND(SUM(watch_duration_minutes), 2) AS total_watch_time,
        ROUND(AVG(progress_percentage), 2) AS avg_progress
    FROM watch_history
    GROUP BY month
),
monthly_revenue AS (
    SELECT 
        DATE_FORMAT(created_at, '%Y-%m') AS month,
        ROUND(SUM(monthly_spend), 2) AS total_revenue
    FROM users
    WHERE is_active = TRUE
    GROUP BY month
)

SELECT 
    w.month,
    u.new_users,
    w.active_users,
    w.total_watch_time,
    ROUND(w.total_watch_time / w.active_users, 2) AS avg_watch_per_user,
    w.avg_progress,
    r.total_revenue
FROM monthly_watch w
LEFT JOIN monthly_users u USING (month)
LEFT JOIN monthly_revenue r USING (month)
ORDER BY w.month;
