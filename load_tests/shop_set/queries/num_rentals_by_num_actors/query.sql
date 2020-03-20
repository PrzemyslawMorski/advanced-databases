select
	num_actors,
	sum(num_rentals) as num_rentals
from
	(
		select
			f.film_id,
			count(fa.actor_id) as num_actors
		from
			film f
			left outer join film_actor fa on f.film_id = fa.film_id
		group by
			f.film_id
	) as num_actors_by_film
	left outer join (
		select
			i.film_id,
			count(r.rental_id) as num_rentals
		from
			inventory i
			left outer join rental r on i.inventory_id = r.inventory_id
		group by
			i.film_id
	) as num_rentals_by_inventory on num_actors_by_film.film_id = num_rentals_by_inventory.film_id
group by
	num_actors
order by
	num_actors