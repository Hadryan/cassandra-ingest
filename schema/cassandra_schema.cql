DROP KEYSPACE IF EXISTS killrmovies;
CREATE KEYSPACE killrmovies WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 1 };

use killrmovies;

// Users by id
CREATE TABLE IF NOT EXISTS users (
    id uuid,
    first_name text,
    last_name text,
    email text,
    created_at timestamp,
    operation_type int,
    PRIMARY KEY ((id), created_at, operation_type)
);

// Movies by id
CREATE TABLE IF NOT EXISTS movies (
    id uuid,
    name text,
    description text,
    created_at timestamp,
    operation_type int,
    PRIMARY KEY ((id), created_at, operation_type)
);

// One-to-many from user
// CREATE TABLE IF NOT EXISTS user_movies (
//    user_id uuid,
//    created_at timestamp,
//    movie_id uuid,
//    name text,
//    PRIMARY KEY (user_id, created_at, movie_id)
// ) WITH CLUSTERING ORDER BY (created_at DESC, movie_id ASC);

// Movie ratings (counter table)
CREATE TABLE IF NOT EXISTS movie_ratings (
    movie_id uuid,
    rating_counter counter,
    rating_total counter,
    PRIMARY KEY (movie_id)
);

// Movie ratings by user (primary key to mitigate voting multiple times)
CREATE TABLE IF NOT EXISTS movie_ratings_by_user (
    movie_id uuid,
    user_id uuid,
    rating int,
    created_at timestamp,
    operation_type int,
    PRIMARY KEY ((movie_id), user_id, created_at, operation_type)
);

// Tags by user (may have multiple tags)
CREATE TABLE IF NOT EXISTS movie_tags_by_user (
    movie_id uuid,
    user_id uuid,
    tag text,
    created_at timestamp,
    operation_type int,
    PRIMARY KEY ((user_id), movie_id, tag, created_at, operation_type)
);

// Index for tag keywords
CREATE TABLE IF NOT EXISTS movies_by_tag (
    tag text,
    movie_id uuid,
    created_at timestamp,
    user_id uuid,
    operation_type int,
    PRIMARY KEY ((tag), movie_id, created_at, operation_type)
);
