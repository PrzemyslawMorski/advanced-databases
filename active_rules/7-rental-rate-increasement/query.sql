CREATE OR REPLACE FUNCTION public.increase_film_rental_rate_after_insert_rental() RETURNS trigger
   LANGUAGE plpgsql AS
$$BEGIN
    RAISE NOTICE 'ZWIEKSZENIE KOSZTU WYNAJMU FILMU PO WYNAJECIU GO';

	UPDATE film SET rental_rate = rental_rate * 1.5 WHERE film_id in (
        SELECT DISTINCT f.film_id 
        FROM film f 
        JOIN inventory i ON f.film_id = i.film_id 
        JOIN rental r ON r.inventory_id = i.inventory_id 
        WHERE r.rental_id = NEW.rental_id
    );
 
   RETURN NEW;
END;$$;
 
DROP TRIGGER IF EXISTS increase_film_rental_rate_after_insert_rental_trig ON public.rental;
 
CREATE CONSTRAINT TRIGGER increase_film_rental_rate_after_insert_rental_trig
   AFTER INSERT ON public.rental
   INITIALLY IMMEDIATE
   FOR EACH ROW 
   EXECUTE PROCEDURE public.increase_film_rental_rate_after_insert_rental();