# Final tables creation
USE netflix_analytics;

-- 1. Users
DROP TABLE IF EXISTS users;
CREATE TABLE users (
	user_id VARCHAR(50) PRIMARY KEY,
    email VARCHAR(255),
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    age INT,
    gender VARCHAR(20),
    country VARCHAR(50),
    state_province VARCHAR(100),
    city VARCHAR(100),
    subscription_plan VARCHAR(50),
    subscription_start_date DATE,
    is_active BOOLEAN,
    monthly_spend FLOAT,
    primary_device VARCHAR(50),
    household_size INTEGER,
    created_at DATETIME
);

-- 2. Movies
DROP TABLE IF EXISTS movies;
CREATE TABLE movies (
	movie_id VARCHAR(50) PRIMARY KEY,
	title VARCHAR(300),
	content_type VARCHAR(300),
	genre_primary VARCHAR(300),
	genre_secondary VARCHAR(300),
	release_year YEAR,
	duration_minutes FLOAT,
	rating VARCHAR(50),
	language VARCHAR(100),
	country_of_origin VARCHAR(100),
	imdb_rating FLOAT,
	production_budget FLOAT,
	box_office_revenue FLOAT,
	number_of_seasons INTEGER,
	number_of_episodes INTEGER,
	is_netflix_original BOOLEAN,
	added_to_platform DATE,
	content_warning BOOLEAN
);

-- 3. Watch history
DROP TABLE IF EXISTS watch_history;
CREATE TABLE watch_history (
	session_id VARCHAR(50) PRIMARY KEY,
	user_id VARCHAR(50),
	movie_id VARCHAR(50),
	watch_date DATE,
	device_type VARCHAR(100),
	watch_duration_minutes FLOAT,
	progress_percentage FLOAT,
	action VARCHAR(100),
	quality VARCHAR(50),
	location_country VARCHAR(100),
	is_download BOOLEAN,
	user_rating FLOAT,
	CONSTRAINT user_id_fk  FOREIGN KEY (user_id) REFERENCES users(user_id),
	CONSTRAINT movie_id_fk  FOREIGN KEY (movie_id) REFERENCES movies(movie_id)
);

