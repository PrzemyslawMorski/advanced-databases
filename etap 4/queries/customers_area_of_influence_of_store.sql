select customer_id, first_name, last_name, location
from customer c join address ad on c.address_id = ad.address_id
where ST_Within(
	location::geometry, 
	(select area_of_influence::geometry from store where store_id = 1)
)
