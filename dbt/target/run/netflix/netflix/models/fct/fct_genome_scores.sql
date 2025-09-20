
  
    

  create  table "netflix_data"."DEV"."fct_genome_scores__dbt_tmp"
  
  
    as
  
  (
    WITH src_scores AS (
    SELECT * FROM "netflix_data"."DEV"."src_genome_scores"
)

SELECT
    movie_id,
    tag_id,
    ROUND(relevance::numeric, 4) AS relevance_score
FROM src_scores
WHERE relevance > 0
  );
  