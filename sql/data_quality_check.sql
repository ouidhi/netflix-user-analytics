# Checking the quality of data before inserting in final tables
USE netflix_analytics;

-- 1. Users
-- ALL ROWS
SELECT * FROM users_staging;

-- NULLS
SELECT * FROM users_staging WHERE user_id = '';
SELECT * FROM users_staging WHERE email = '';
SELECT * FROM users_staging WHERE first_name = '';
SELECT * FROM users_staging WHERE last_name = '';
SELECT * FROM users_staging WHERE age = '';
SELECT * FROM users_staging WHERE gender = '';
SELECT * FROM users_staging WHERE country = '';
SELECT * FROM users_staging WHERE state_province = '';
SELECT * FROM users_staging WHERE city = '';
SELECT * FROM users_staging WHERE subscription_plan = '';
SELECT * FROM users_staging WHERE subscription_start_date = '';
SELECT * FROM users_staging WHERE is_active = '';
SELECT * FROM users_staging WHERE monthly_spend = '';
SELECT * FROM users_staging WHERE primary_device = '';
SELECT * FROM users_staging WHERE household_size = '';
SELECT * FROM users_staging WHERE created_at = '';

-- DUPLICATES OF PK
SELECT user_id, COUNT(*) AS Count FROM users_staging
GROUP BY user_id
HAVING Count > 1
ORDER BY Count DESC;

-- 2. Movies
-- ALL ROWS
SELECT * FROM movies_staging;

-- NULLS
SELECT * FROM movies_staging WHERE movie_id = '';
SELECT * FROM movies_staging WHERE title = '';
SELECT * FROM movies_staging WHERE content_type = '';
SELECT * FROM movies_staging WHERE genre_primary = '';
SELECT * FROM movies_staging WHERE genre_secondary = '';
SELECT * FROM movies_staging WHERE release_year = '';
SELECT * FROM movies_staging WHERE duration_minutes = '';
SELECT * FROM movies_staging WHERE rating = '';
SELECT * FROM movies_staging WHERE language = '';
SELECT * FROM movies_staging WHERE country_of_origin = '';
SELECT * FROM movies_staging WHERE imdb_rating = '';
SELECT * FROM movies_staging WHERE production_budget = '';
SELECT * FROM movies_staging WHERE box_office_revenue = '';
SELECT * FROM movies_staging WHERE number_of_seasons = '';
SELECT * FROM movies_staging WHERE number_of_episodes = '';
SELECT * FROM movies_staging WHERE is_netflix_original = '';
SELECT * FROM movies_staging WHERE added_to_platform = '';
SELECT * FROM movies_staging WHERE content_warning = '';

-- DUPLICATES OF PK
SELECT movie_id, COUNT(*) AS Count FROM movies_staging
GROUP BY movie_id
HAVING Count > 1
ORDER BY Count DESC;

-- 3. Watch history
-- ALL ROWS
SELECT * FROM watch_history_staging;

-- NULLS
SELECT * FROM watch_history_staging WHERE session_id = '';
SELECT * FROM watch_history_staging WHERE user_id = '';
SELECT * FROM watch_history_staging WHERE movie_id = '';
SELECT * FROM watch_history_staging WHERE watch_date = '';
SELECT * FROM watch_history_staging WHERE device_type = '';
SELECT * FROM watch_history_staging WHERE watch_duration_minutes = '';
SELECT * FROM watch_history_staging WHERE progress_percentage = '';
SELECT * FROM watch_history_staging WHERE action = '';
SELECT * FROM watch_history_staging WHERE quality = '';
SELECT * FROM watch_history_staging WHERE location_country = '';
SELECT * FROM watch_history_staging WHERE is_download = '';
SELECT * FROM watch_history_staging WHERE user_rating = '';


-- DUPLICATES OF PK
SELECT session_id, COUNT(*) AS Count FROM watch_history_staging
GROUP BY session_id
HAVING Count > 1
ORDER BY Count DESC;

