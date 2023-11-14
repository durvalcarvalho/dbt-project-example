{{ config(materialized='view') }}

with museums as (
    select * from {{ ref('stg_museums') }}
),
num_of_museums_per_country as (
    SELECT country, count(*) as "num_of_museums"
    FROM museums
    group by country
    order by count(*) desc
)

select * from num_of_museums_per_country
