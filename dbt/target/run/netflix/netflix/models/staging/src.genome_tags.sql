
  create view "netflix_data"."DEV"."src.genome_tags__dbt_tmp"
    
    
  as (
    with raw_genome_tags as (
    select * from public.genome_tags
)
select
    "tagId" as tag_id,
    tag
from raw_genome_tags
  );