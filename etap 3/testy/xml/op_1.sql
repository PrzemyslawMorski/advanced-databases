with rental_info as (
	with foo as (
		select 
			xmlagg(rentals_xml) as rentals, 
			city_id 
		from city
		where xpath_exists('/rentals/rental', rentals_xml)
		group by city_id
	)
	select 
		(select city_id from foo) as city_id,
		unnest(xpath('/rentals/rental/rental_id/text()', (select rentals from foo))) as rental_id,
    	unnest(xpath('/rentals/rental/store_id/text()', (select rentals from foo))) as store_id,
	    unnest(xpath('/rentals/rental/film_id/text()', (select rentals from foo))) as film_id,
    	unnest(xpath('/rentals/rental/customer_id/text()', (select rentals from foo))) as customer_id
)
select 
	city,
	first_name || last_name,
	email,
	title
from 
	rental_info ri
	join film f on f.film_id::text = ri.film_id::text
	join customer c on c.customer_id::text = ri.customer_id::text
	join city ct on ct.city_id::text = ri.city_id::text
