{{ config(materialized='view') }}

with most_productive_artists as (
    SELECT 
        a.full_name, 
        a.nationality,
        sum(width * height) "painted_area"
    FROM public.product_size ps
    join works w on w.work_id = ps.work_id 
    join canvas_size cs ON cs.size_id = ps.size_id
    join artists a on a.artist_id = w.artist_id
    WHERE width IS NOT NULL AND height IS NOT NULL
    group by a.artist_id
    order by painted_area desc
)

select * from most_productive_artists
