{{ config(materialized='view') }}

with num_of_works_per_artist as (
    SELECT a.full_name, a.nationality, a."style", count(*) as "number_of_works"
    FROM public.artists a 
    join works w 
    on w.artist_id = a.artist_id
    group by a.artist_id
    order by number_of_works desc
)

select * from num_of_works_per_artist
