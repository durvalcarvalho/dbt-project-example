{{ config(materialized='view') }}


with artists as (
    select * from {{ ref('stg_artists') }}
),
works as (
    select * from {{ ref('stg_works') }}
),
canvas_size as (
    select * from {{ ref('stg_canvas_size') }}
),
product_size as (
    select * from {{ ref('stg_product_size') }}
),

most_productive_artists as (
    SELECT 
        a.full_name, 
        a.nationality,
        sum(width * height) "painted_area"
    FROM product_size ps
    join works w on w.work_id = ps.work_id 
    join canvas_size cs ON cs.size_id = ps.size_id
    join artists a on a.artist_id = w.artist_id
    WHERE width IS NOT NULL AND height IS NOT NULL
    group by a.full_name, a.nationality
    order by painted_area desc
)

select * from most_productive_artists
