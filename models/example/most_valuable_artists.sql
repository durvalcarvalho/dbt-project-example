{{ config(materialized='view') }}

with product_size as (
	select * from {{ ref('stg_product_size') }}
),

works_museums_artists as (
	select * from {{ ref('works_museums_artists') }}
),
most_valuable_artists as (
	SELECT 
		wma.artist_full_name, 
		sum(sale_price) as sales 
	FROM product_size p
	join works_museums_artists wma 
	on wma.work_id = p.work_id
	group by (wma.artist_id, wma.artist_full_name)
	order by sales desc
)

select * from most_valuable_artists
