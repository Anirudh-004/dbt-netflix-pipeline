
      
  
    

  create  table "netflix_data"."snapshots"."snap_tags"
  
  
    as
  
  (
    
    

    select *,
        md5(coalesce(cast(user_id as varchar ), '')
         || '|' || coalesce(cast(movie_id as varchar ), '')
         || '|' || coalesce(cast(tag as varchar ), '')
         || '|' || coalesce(cast(tag_timestamp as varchar ), '')
        ) as dbt_scd_id,
        tag_timestamp as dbt_updated_at,
        tag_timestamp as dbt_valid_from,
        
  
  coalesce(nullif(tag_timestamp, tag_timestamp), null)
  as dbt_valid_to
from (
        



SELECT
md5(cast(coalesce(cast(user_id as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(movie_id as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(tag as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) AS row_key,
    user_id,
    movie_id,
    tag,
    CAST(tag_timestamp AS TIMESTAMP) AS tag_timestamp
FROM "netflix_data"."DEV"."src_tags"
LIMIT 100

    ) sbq



  );
  
  