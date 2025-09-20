with raw_ratings as (
    select * from public.ratings
)
select
    "userId" as user_id,
    "movieId" as movie_id,
    rating,
    TO_TIMESTAMP("timestamp") as rating_timestamp
From raw_ratings