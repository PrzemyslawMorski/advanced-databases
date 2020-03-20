with rentals_by_actor as (
	select
		a.actor_id,
		count(r.rental_id) as num_rentals
	from
		actor a
		left outer join film_actor fa on a.actor_id = fa.actor_id
		left outer join film f on fa.film_id = f.film_id
		left outer join inventory i on f.film_id = i.film_id
		left outer join rental r on r.inventory_id = i.inventory_id
	group by
		a.actor_id
)
select
	a.actor_id,
	a.first_name,
	a.last_name,
	ra.num_rentals
from
	actor a
	left outer join rentals_by_actor ra on a.actor_id = ra.actor_id
order by
	num_rentals desc