{{ config(materialized='view') }}

with num_of_museums_per_country as (
    SELECT country, count(*) as "num_of_museums"
    FROM public.museums
    group by country
    order by count(*) desc
)

select * from num_of_museums_per_country
