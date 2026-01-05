# Inserting the cleaned data into final tables
-- 1. Users
INSERT INTO users 
WITH ranked_users AS
(SELECT *,
		ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY created_at DESC) AS rn
FROM users_staging
)
SELECT 
	TRIM(user_id),
    TRIM(email),
    TRIM(first_name),
    TRIM(last_name),
    CASE 
		WHEN NULLIF(TRIM(age), '')+0 BETWEEN 0 AND 120 THEN NULLIF(TRIM(age), '')+0
        ELSE NULL
	END AS age,
    NULLIF(TRIM(gender), '') AS gender,
    TRIM(country),
    TRIM(state_province),
    TRIM(city),
    TRIM(subscription_plan),
    str_to_date(TRIM(subscription_start_date), "%Y-%m-%d") AS subscription_start_date,
    CASE
		WHEN is_active = 'true' THEN 1
        WHEN is_active = 'false' THEN 0
        ELSE NULL
	END AS is_active,
    NULLIF(TRIM(monthly_spend), '')+0 AS monthly_spend,
    TRIM(primary_device),
    NULLIF(TRIM(household_size), '')+0 AS household_size,
    str_to_date(LEFT(TRIM(created_at), 19), "%Y-%m-%d %H:%i:%s") AS created_at
FROM ranked_users
WHERE rn = 1;

-- 2. Movies
INSERT INTO movies
WITH ranked_movies AS
(SELECT *,
		ROW_NUMBER() OVER(PARTITION BY movie_id ORDER BY added_to_platform DESC) AS rn
FROM movies_staging
)
SELECT 
	TRIM(movie_id),
	TRIM(title),
	TRIM(content_type),
	TRIM(genre_primary),
	NULLIF(TRIM(genre_secondary), '') AS genre_secondary,
	TRIM(release_year) + 0 AS release_year,
	TRIM(duration_minutes) + 0 AS duration_minutes,
	TRIM(rating),
	TRIM(language),
	TRIM(country_of_origin),
	NULLIF(TRIM(imdb_rating), '')+0 AS imdb_rating,
	NULLIF(TRIM(production_budget), '')+0 AS production_budget,
	NULLIF(TRIM(box_office_revenue), '')+0 AS box_office_revenue,
	NULLIF(TRIM(number_of_seasons), '')+0 AS number_of_seasons,
	NULLIF(TRIM(number_of_episodes), '')+0 AS number_of_episodes,
	CASE
		WHEN TRIM(is_netflix_original) = 'true' THEN 1
        WHEN TRIM(is_netflix_original) = 'false' THEN 0
        ELSE NULL
	END AS is_netflix_original,
	str_to_date(TRIM(added_to_platform), "%Y-%m-%d") AS added_to_platform,
	CASE 
		WHEN TRIM(content_warning) = 'true' THEN 1
        WHEN TRIM(content_warning) = 'false' THEN 0
        ELSE NULL
	END AS content_warning
FROM ranked_movies
WHERE rn = 1;

-- 3. Watch history
INSERT INTO watch_history
WITH ranked_watch_history AS
(SELECT *,
		ROW_NUMBER() OVER(PARTITION BY session_id ORDER BY watch_date DESC) AS rn
FROM watch_history_staging
)
SELECT 
	TRIM(session_id),
	TRIM(user_id),
	TRIM(movie_id),
	str_to_date(TRIM(watch_date), "%Y-%m-%d") AS watch_date,
	TRIM(device_type),
	NULLIF(TRIM(watch_duration_minutes), '')+0 AS watch_duration_minutes,
	NULLIF(TRIM(progress_percentage), '')+0 AS progress_percentage,
	TRIM(action),
	TRIM(quality),
	TRIM(location_country),
	CASE
		WHEN TRIM(is_download) = 'true' THEN 1
        WHEN TRIM(is_download) = 'false' THEN 0
        ELSE NULL
	END AS is_download,
	NULLIF(TRIM(user_rating), '')+0 AS user_rating
FROM ranked_watch_history
WHERE rn = 1;
	









