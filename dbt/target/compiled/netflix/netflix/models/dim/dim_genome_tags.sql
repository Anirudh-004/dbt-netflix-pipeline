WITH src_tags AS (
    SELECT * FROM "netflix_data"."DEV"."src.genome_tags"
)

SELECT
    tag_id,
    INITCAP(TRIM(tag)) AS tag_name
FROM src_tags