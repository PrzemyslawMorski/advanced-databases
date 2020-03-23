psql -h dvd_rental_db -p 5432 -U postgres -d dvdrental -h dvd_rental_db -p 5432 -U postgres -d dvdrental -c '\copy public.actor (actor_id, first_name, last_name, last_update) from /migrator_volume/3057.dat'
psql -h dvd_rental_db -p 5432 -U postgres -d dvdrental -c '\copy public.country (country_id, country, last_update) from /migrator_volume/3069.dat'
psql -h dvd_rental_db -p 5432 -U postgres -d dvdrental -c '\copy public.city (city_id, city, country_id, last_update) from /migrator_volume/3067.dat'
psql -h dvd_rental_db -p 5432 -U postgres -d dvdrental -c '\copy public.address (address_id, address, address2, district, city_id, postal_code, phone, last_update) from /migrator_volume/3065.dat'
psql -h dvd_rental_db -p 5432 -U postgres -d dvdrental -c '\copy public.category (category_id, name, last_update) from /migrator_volume/3059.dat'
psql -h dvd_rental_db -p 5432 -U postgres -d dvdrental -c '\copy public.customer (customer_id, store_id, first_name, last_name, email, address_id, activebool, create_date, last_update, active) from /migrator_volume/3055.dat'
psql -h dvd_rental_db -p 5432 -U postgres -d dvdrental -c '\copy public.language (language_id, name, last_update) from /migrator_volume/3073.dat'
psql -h dvd_rental_db -p 5432 -U postgres -d dvdrental -c '\copy public.film (film_id, title, description, release_year, language_id, rental_duration, rental_rate, length, replacement_cost, rating, last_update, special_features, fulltext) from /migrator_volume/3061.dat'
psql -h dvd_rental_db -p 5432 -U postgres -d dvdrental -c '\copy public.film_actor (actor_id, film_id, last_update) from /migrator_volume/3062.dat'
psql -h dvd_rental_db -p 5432 -U postgres -d dvdrental -c '\copy public.film_category (film_id, category_id, last_update) from /migrator_volume/3063.dat'
psql -h dvd_rental_db -p 5432 -U postgres -d dvdrental -c '\copy public.inventory (inventory_id, film_id, store_id, last_update) from /migrator_volume/3071.dat'
psql -h dvd_rental_db -p 5432 -U postgres -d dvdrental -c '\copy public.staff (staff_id, first_name, last_name, address_id, email, store_id, active, username, password, last_update, picture) from /migrator_volume/3079.dat'
psql -h dvd_rental_db -p 5432 -U postgres -d dvdrental -c '\copy public.rental (rental_id, rental_date, inventory_id, customer_id, return_date, staff_id, last_update) from /migrator_volume/3077.dat'
psql -h dvd_rental_db -p 5432 -U postgres -d dvdrental -c '\copy public.payment (payment_id, customer_id, staff_id, rental_id, amount, payment_date) from /migrator_volume/3075.dat'
psql -h dvd_rental_db -p 5432 -U postgres -d dvdrental -c '\copy public.store (store_id, manager_staff_id, address_id, last_update) from /migrator_volume/3081.dat'