-- actors ordered by the number their movies have been rented globally
with actor_rentals as (
	with film_rentals as (
		with num_inventory_rentals as (
			select
				i.inventory_id as inventory_id,
				i.film_id as film_id,
				count(*) as num_rentals
			from
				inventory i
				left outer join rental r on i.inventory_id = r.inventory_id
			group by
				i.inventory_id
		)
		select
			f.film_id,
			f.title,
			sum(num_inventory_rentals.num_rentals) as num_rentals
		from
			film f
			left outer join num_inventory_rentals on num_inventory_rentals.film_id = f.film_id
		group by
			f.film_id
		order by
			num_rentals
	)
	select
		sum(fr.num_rentals) as actor_num_rentals,
		fA.actor_id
	from
		film_rentals fr
		left outer join film_actor fA on fr.film_id = fA.film_id
	group by
		fA.actor_id
)
select
	first_name,
	last_name,
	actor_num_rentals,
	act.actor_id
from
	actor act
	left outer join actor_rentals ar on act.actor_id = ar.actor_id
order by
	actor_num_rentals desc