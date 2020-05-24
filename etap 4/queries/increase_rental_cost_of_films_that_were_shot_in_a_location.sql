update film 
set rental_rate = rental_rate + 0.01
where ST_Intersects(
	ST_Buffer(ST_Point(17.15, 51)::geography, 50000, 8), 
	film_shoot_locations);
