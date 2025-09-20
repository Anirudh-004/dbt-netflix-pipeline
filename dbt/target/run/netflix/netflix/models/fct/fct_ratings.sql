
      insert into "netflix_data"."DEV"."fct_ratings" ("user_id", "movie_id", "rating", "rating_timestamp")
    (
        select "user_id", "movie_id", "rating", "rating_timestamp"
        from "fct_ratings__dbt_tmp133419235059"
    )


  