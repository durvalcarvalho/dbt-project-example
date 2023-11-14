{{ config(materialized='view') }}

with most_valuable_artists as (
	SELECT 
		wma.artist_full_name, 
		sum(sale_price) as sales 
	FROM public.product_size p
	join {{ ref ('works_museums_artists') }} wma 
	on wma.work_id = p.work_id
	group by (wma.artist_id, wma.artist_full_name)
	order by sales desc
)

select * from most_valuable_artists
