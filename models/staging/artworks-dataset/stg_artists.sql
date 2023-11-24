with source as (
    select * 
    from {{ source('artworks_ds', 'artists') }}
),
loaded as (
    select * from source
),
transform as (
    SELECT 
        artist_id, 
        full_name, 
        first_name, 
        encode(sha256(middle_names::bytea), 'hex') as hashed_middle_names, 
        last_name, 
        nationality, 
        "style", 
        birth, 
        death
    FROM 
    loaded
),
renamed as (
    SELECT 
        artist_id, 
        full_name, 
        first_name, 
        hashed_middle_names, 
        last_name, 
        nationality, 
        "style", 
        birth, 
        death
    FROM 
    transform
)

select * from renamed
