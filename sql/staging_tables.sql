# Database creation

CREATE DATABASE netflix_analytics;
USE netflix_analytics;

# Staging tables creation

-- 1. Users
DROP TABLE IF EXISTS users_staging;
CREATE TABLE users_staging (
	user_id VARCHAR(100),
    email VARCHAR(255),
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    age VARCHAR(10),
    gender VARCHAR(20),
    country VARCHAR(50),
    state_province VARCHAR(100),
    city VARCHAR(100),
    subscription_plan VARCHAR(50),
    subscription_start_date VARCHAR(50),
    is_active VARCHAR(10),
    monthly_spend VARCHAR(20),
    primary_device VARCHAR(50),
    household_size VARCHAR(10),
    created_at VARCHAR(50)
);

-- 2. Movies
DROP TABLE IF EXISTS movies_staging;
CREATE TABLE movies_staging (
	movie_id VARCHAR(100),
	title VARCHAR(300),
	content_type VARCHAR(300),
	genre_primary VARCHAR(300),
	genre_secondary VARCHAR(300),
	release_year VARCHAR(10),
	duration_minutes VARCHAR(50),
	rating VARCHAR(50),
	language VARCHAR(100),
	country_of_origin VARCHAR(100),
	imdb_rating VARCHAR(50),
	production_budget VARCHAR(200),
	box_office_revenue VARCHAR(300),
	number_of_seasons VARCHAR(50),
	number_of_episodes VARCHAR(100),
	is_netflix_original VARCHAR(50),
	added_to_platform VARCHAR(50),
	content_warning VARCHAR(50)
);

-- 3. Watch history
DROP TABLE IF EXISTS watch_history_staging;
CREATE TABLE watch_history_staging (
	session_id VARCHAR(100),
	user_id VARCHAR(100),
	movie_id VARCHAR(100),
	watch_date VARCHAR(50),
	device_type VARCHAR(100),
	watch_duration_minutes VARCHAR(100),
	progress_percentage VARCHAR(50),
	action VARCHAR(100),
	quality VARCHAR(50),
	location_country VARCHAR(100),
	is_download VARCHAR(50),
	user_rating VARCHAR(50)
);





