BEGIN;

SAVEPOINT save;

with inserted_films as (
	insert into
		film (
			film_id,
			title,
			description,
			release_year,
			language_id,
			rental_duration,
			rental_rate,
			length,
			replacement_cost,
			rating
		)
	select
		generated,
		random() :: text,
		random() :: text,
		2015,
		(
			select
				language_id
			from
				language
			order by
				random()
			limit
				1
		), 6, random() :: numeric(4, 2), random(), random() :: numeric(5, 2), 'NC-17'
	from
		generate_series(300000, 340000) as generated returning *
)
insert into
	film_actor(film_id, actor_id)
select
	(
		select
			film_id
		from
			inserted_films
		order by
			random()
		limit
			1
	), actors.actor_id
from
	(
		select
			actor_id
		from
			actor
		order by
			random()
		limit
			1
	) as actors;

ROLLBACK TO SAVEPOINT save;

COMMIT;