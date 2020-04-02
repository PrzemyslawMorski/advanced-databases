CREATE OR REPLACE FUNCTION public.check_rental_insert_of_new_customer() RETURNS trigger
   LANGUAGE plpgsql AS
$$BEGIN
	raise notice 'Value: %', NEW.customer_id;
	IF (select count(customer_id) from customer where customer_id = NEW.customer_id and date_part('year',age(CURRENT_DATE, create_date)) < 1) = 1 THEN
		RAISE NOTICE 'NOWY USER';
	END IF;
	
	IF (SELECT count(r.rental_id) FROM public.rental r join public.customer c on r.customer_id = c.customer_id where c.customer_id = NEW.customer_id and 
		r.return_date is null) > 3 THEN
		RAISE NOTICE 'WIECEJ NIZ 3 WYPOZYCZENIA';
	END IF;
	
	IF (select count(customer_id) from customer where customer_id = NEW.customer_id and date_part('year',age(CURRENT_DATE, create_date)) < 1) = 1 and   
   (SELECT count(r.rental_id) FROM public.rental r join public.customer c on r.customer_id = c.customer_id where c.customer_id = NEW.customer_id and 
		r.return_date is null) > 3
   THEN
      RAISE EXCEPTION 'Sorry, as a new user you cannot rent more than 3 films';
   END IF;
 
   RETURN NEW;
END;$$;
 
DROP TRIGGER IF EXISTS checkout_trig ON public.rental;
 
CREATE CONSTRAINT TRIGGER checkout_trig
   AFTER INSERT ON public.rental
   INITIALLY IMMEDIATE
   FOR EACH ROW 
   EXECUTE PROCEDURE public.check_rental_insert_of_new_customer();