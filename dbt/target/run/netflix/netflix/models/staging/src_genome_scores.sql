
  create view "netflix_data"."DEV"."src_genome_scores__dbt_tmp"
    
    
  as (
    with raw_genome_scores as (
    select * from public.genome_scores
)
select
    "movieId" as movie_id,
    "tagId" as tag_id,
    relevance
from raw_genome_scores
  );