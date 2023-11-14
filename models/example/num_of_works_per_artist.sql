{{ config(materialized='view') }}

with artists as (
    select * from {{ ref('stg_artists') }}
),
works as (
    select * from {{ ref('stg_works') }}
),
num_of_works_per_artist as (
    SELECT a.full_name, a.nationality, a."style", count(*) as "number_of_works"
    FROM artists a 
    join works w 
    on w.artist_id = a.artist_id
    group by a.full_name, a.nationality, a."style"
    order by number_of_works desc
)

select * from num_of_works_per_artist
