with raw_movies as (
    select * from public.movies
)
select
    "movieId" as movie_id,
    title,
    genres
 from raw_movies
