WITH src_movies AS (
    SELECT * FROM "netflix_data"."DEV"."src_movies"
)
SELECT
    movie_id,
    INITCAP(TRIM(title)) AS movie_title,
    string_to_array(genres, '|') AS genre_array,
    genres
FROM src_movies