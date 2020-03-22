delete from
	payment p
where
	p.rental_id in (
		select
			r.rental_id
		from
			rental r
		where
			r.inventory_id in (
				select
					i.inventory_id
				from
					inventory i
				where
					i.film_id = 1
			)
	);

delete from
	film_actor fa
where
	fa.film_id = 1;

delete from
	rental r
where
	r.inventory_id in (
		select
			i.inventory_id
		from
			inventory i
		where
			i.film_id = 1
	);

delete from
	inventory i
where
	i.film_id = 1;

delete from
	film_category fc
where
	fc.film_id = 1;

delete from
	film f
where
	f.film_id = 1;