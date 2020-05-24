select 
	film_id, 
	title, 
	ST_Distance(
		ST_Point(17.15, 51)::geography, 
		film_shoot_locations
	) as distance_from_location
from film
order by distance_from_location
