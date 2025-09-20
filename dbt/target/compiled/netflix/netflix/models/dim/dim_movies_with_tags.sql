

WITH movies AS (
    SELECT * FROM "netflix_data"."DEV"."dim_movies"
),
tags AS (
    SELECT * FROM "netflix_data"."DEV"."dim_genome_tags"
),
scores AS (
    SELECT * FROM "netflix_data"."DEV"."fct_genome_scores"
)

SELECT
    m.movie_id,
    m.movie_title,
    m.genres,
    t.tag_name,
    s.relevance_score
FROM movies m
LEFT JOIN scores s ON m.movie_id = s.movie_id
LEFT JOIN tags t ON t.tag_id = s.tag_id