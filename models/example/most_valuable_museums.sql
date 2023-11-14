{{ config(materialized='view') }}

with product_size as (
	select * from {{ ref('stg_product_size') }}
),
most_valuable_museums as (
	SELECT 
		wma.museum_id, 
		wma.museum_name,
		sum(sale_price) as sales 
	FROM product_size p
	join {{ ref ('works_museums_artists') }} wma 
	on wma.work_id = p.work_id
	group by (wma.museum_id, wma.museum_name)
	order by sales desc
)

select * from most_valuable_museums
