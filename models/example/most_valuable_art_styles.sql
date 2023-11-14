{{ config(materialized='view') }}

with product_size as (
	select * from {{ ref('stg_product_size') }}
),
works_museums_artists as (
	select * from {{ ref('works_museums_artists') }}
),
most_valuable_artists as (
	SELECT 
		wma.work_style "Art style",
		sum(sale_price) "sum_of_sales"
	FROM public.product_size p
	join works_museums_artists wma 
	on wma.work_id = p.work_id
	where wma.work_style is NOT null
	group by wma.work_style
	order by sum_of_sales desc
)

select * from most_valuable_artists
