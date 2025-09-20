
  
    

  create  table "netflix_data"."DEV"."dim_users__dbt_tmp"
  
  
    as
  
  (
    WITH ratings AS (
  SELECT DISTINCT user_id FROM "netflix_data"."DEV"."src_ratings"
),

tags AS (
  SELECT DISTINCT user_id FROM "netflix_data"."DEV"."src_tags"
)

SELECT DISTINCT user_id
FROM (
  SELECT * FROM ratings
  UNION
  SELECT * FROM tags
) AS combined_users
  );
  