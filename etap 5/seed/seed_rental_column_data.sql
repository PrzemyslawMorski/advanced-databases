DROP TABLE IF EXISTS rental_column_storage;
SELECT r.rental_id, r.rental_date, r.return_date, r.customer_id, p.amount, p.payment_date, s.first_name, s.email, a.address, c.city, country.country, f.title, f.description, f.release_year 
	INTO rental_column_storage
	FROM public.rental r join public.inventory i on r.inventory_id=i.inventory_id
	join public.film f on i.inventory_id=f.film_id
	join public.payment p on r.rental_id=p.rental_id
	join public.staff s on p.staff_id=s.staff_id
	join public.store st on st.store_id=s.store_id
	join public.address a on st.address_id=a.address_id
	join public.city c on a.city_id=c.city_id
	join public.country country on c.country_id=country.country_id;

ALTER TABLE rental_column_storage 
ADD CONSTRAINT customerid_fk FOREIGN KEY (customer_id) REFERENCES public.customer_column_storage(customer_id);
ALTER TABLE rental_column_storage ADD PRIMARY KEY (rental_id);