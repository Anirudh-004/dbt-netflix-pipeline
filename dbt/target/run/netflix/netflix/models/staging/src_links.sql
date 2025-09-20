
  create view "netflix_data"."DEV"."src_links__dbt_tmp"
    
    
  as (
    with raw_links as (
    select * from public.links
)
select
    "imdbId" as imdb_id,
    "movieId" as movie_id,
    "tmdbId" as tmdb_id
from raw_links
  );