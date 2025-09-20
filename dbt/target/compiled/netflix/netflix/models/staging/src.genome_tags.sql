with raw_genome_tags as (
    select * from public.genome_tags
)
select
    "tagId" as tag_id,
    tag
from raw_genome_tags