with source as (
    select * from {{ source('artworks_ds', 'museums') }}
),

loaded as (
    select * from source
),
transform as (
    select * from loaded
),
renamed as (
    select * from transform
)

select * from renamed
