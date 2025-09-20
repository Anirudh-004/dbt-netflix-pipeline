
  
    

  create  table "netflix_data"."DEV"."dim_genome_tags__dbt_tmp"
  
  
    as
  
  (
    WITH src_tags AS (
    SELECT * FROM "netflix_data"."DEV"."src.genome_tags"
)

SELECT
    tag_id,
    INITCAP(TRIM(tag)) AS tag_name
FROM src_tags
  );
  