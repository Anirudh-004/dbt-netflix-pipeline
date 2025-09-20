
  create view "netflix_data"."DEV"."src_tags__dbt_tmp"
    
    
  as (
    with raw_tags as (
    select * from public.tags
)
select
    "userId" as user_id,
    "movieId" as movie_id,
    tag,
    TO_TIMESTAMP("timestamp") as tag_timestamp
From raw_tags
  );