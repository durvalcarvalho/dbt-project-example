{{ config(materialized='view') }}

with artists as (
	select * from {{ ref('stg_artists') }}
),
works as (
	select * from {{ ref('stg_works') }}
),
museums as (
	select * from {{ ref('stg_museums') }}
),
works_museums_artists as (
    SELECT 
		w.work_id "work_id",
	    w."name" "work_name",
	    w."style" "work_style",
		a.artist_id "artist_id",
	    a.full_name "artist_full_name",
	    a.nationality "artist_nationality",
	    a."style" "artist_style",
	    a.birth "artist_birth_year",
	    a.death "artist_death_year",
		m.museum_id "museum_id",
	    m."name" "museum_name",
	    m."city" "museum_city",
	    m."state" "museum_state",
	    m.country "museum_country"
    FROM artists a
    join works w on w.artist_id = a.artist_id 
    join museums m on w.museum_id = m.museum_id
)

select * from works_museums_artists
