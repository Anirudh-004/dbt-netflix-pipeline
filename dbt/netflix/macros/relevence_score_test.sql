--SELECT
--     movie_id,
--     tag_id,
--     relevance_score
-- FROM {{ ref('fct_genome_scores') }}
-- WHERE relevance_score <= 0

--{{ no_nulls_in_columns(ref('fct_genome_scores'))}}

-- macros/relevence_score_test.sql
{% test relevence_score_test(model) %}
    select *
    from {{ model }}
    where relevance_score <= 0
{% endtest %}
