DROP TABLE IF EXISTS rental_column_storage;

SELECT
	r.rental_id,
	r.rental_date,
	r.return_date,
	r.customer_id,
 	s.first_name,
 	s.email,
 	a.address,
 	c.city,
 	country.country,
 	f.title,
 	f.description,
 	f.release_year 
INTO rental_column_storage
FROM
	public.rental r
 	left outer join public.inventory i on r.inventory_id = i.inventory_id
 	left outer join public.film f on i.film_id = f.film_id
 	left outer join public.staff s on r.staff_id = s.staff_id
 	left outer join public.store st on st.store_id = s.store_id
 	left outer join public.address a on st.address_id = a.address_id
 	left outer join public.city c on a.city_id = c.city_id
 	left outer join public.country country on c.country_id = country.country_id;

ALTER TABLE
	rental_column_storage
ADD
 	CONSTRAINT customerid_fk FOREIGN KEY (customer_id) REFERENCES public.customer_column_storage(customer_id);

ALTER TABLE
 	rental_column_storage
ADD
 	PRIMARY KEY (rental_id);