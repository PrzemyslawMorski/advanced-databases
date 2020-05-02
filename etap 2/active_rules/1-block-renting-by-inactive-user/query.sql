CREATE OR REPLACE FUNCTION public.block_renting_as_nonactive_user() RETURNS trigger
   LANGUAGE plpgsql AS
$$BEGIN
	
	IF (select count(customer_id) from customer where customer_id = NEW.customer_id and activebool = 'f') = 1
   THEN
      RAISE EXCEPTION 'Sorry, you cannot rent as a non-active user';
   END IF;
 
   RETURN NEW;
END;$$;
 
DROP TRIGGER IF EXISTS block_renting_as_nonactive_user_trig ON public.rental;
 
CREATE CONSTRAINT TRIGGER block_renting_as_nonactive_user_trig
   AFTER INSERT ON public.rental
   INITIALLY IMMEDIATE
   FOR EACH ROW 
   EXECUTE PROCEDURE public.block_renting_as_nonactive_user();