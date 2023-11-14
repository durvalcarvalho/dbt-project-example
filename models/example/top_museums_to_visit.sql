{{ config(materialized='view') }}

with museums as (
	select * from {{ ref('stg_museums') }}
),
top_museums_to_visit as (
	SELECT 
		m."name",
		m.country,
		m.state,
		m.city
	FROM museums m
	join {{ ref ('most_valuable_museums') }} mvm
	on m.museum_id = mvm.museum_id
)

select * from top_museums_to_visit
