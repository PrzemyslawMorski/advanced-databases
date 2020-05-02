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

CREATE OR REPLACE FUNCTION public.check_rental_insert_of_new_customer() RETURNS trigger
   LANGUAGE plpgsql AS
$$BEGIN
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

CREATE OR REPLACE FUNCTION public.grant_discount_if_has_multiple_of_10_payments() RETURNS trigger
   LANGUAGE plpgsql AS
$$BEGIN

   IF (SELECT count(p.payment_id) FROM public.payment p where customer_id = NEW.customer_id) % 10 = 0 THEN
		UPDATE payment SET amount = amount * 0.90 WHERE payment_id = NEW.payment_id;
	END IF;
 
   RETURN NEW;
END;$$;
 
DROP TRIGGER IF EXISTS payment_trig ON public.payment;
 
CREATE CONSTRAINT TRIGGER payment_trig
   AFTER INSERT ON public.payment
   INITIALLY IMMEDIATE
   FOR EACH ROW 
   EXECUTE PROCEDURE public.grant_discount_if_has_multiple_of_10_payments();

CREATE OR REPLACE FUNCTION public.dcrs_flm_rplcmnt_cst_insrt_flm_frm_sm_ctgry() RETURNS trigger
   LANGUAGE plpgsql AS
$$BEGIN

	UPDATE film SET replacement_cost = replacement_cost * 0.99 WHERE film_id in (
        SELECT DISTINCT f.film_id FROM film f JOIN film_category fc ON f.film_id = fc.film_id 
        WHERE fc.category_id = NEW.category_id and f.film_id <> NEW.film_id
    );
 
   RETURN NEW;
END;$$;
 
DROP TRIGGER IF EXISTS dcrs_flm_rplcmnt_cst_insrt_flm_frm_sm_ctgry_trg ON public.film_category;
 
CREATE CONSTRAINT TRIGGER dcrs_flm_rplcmnt_cst_insrt_flm_frm_sm_ctgry_trg
   AFTER INSERT ON public.film_category
   INITIALLY IMMEDIATE
   FOR EACH ROW 
   EXECUTE PROCEDURE public.dcrs_flm_rplcmnt_cst_insrt_flm_frm_sm_ctgry();

CREATE OR REPLACE FUNCTION public.increase_film_rental_rate_after_insert_rental() RETURNS trigger
   LANGUAGE plpgsql AS
$$BEGIN
	UPDATE film SET rental_rate = rental_rate + 0.01 WHERE film_id in (
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
