

WITH src_ratings AS (
  SELECT * FROM "netflix_data"."DEV"."src_ratings"
)

SELECT
  user_id,
  movie_id,
  rating,
  rating_timestamp
FROM src_ratings
WHERE rating IS NOT NULL


  AND rating_timestamp > (SELECT MAX(rating_timestamp) FROM "netflix_data"."DEV"."fct_ratings")
