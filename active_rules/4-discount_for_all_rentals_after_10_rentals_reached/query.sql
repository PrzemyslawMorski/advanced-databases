CREATE OR REPLACE FUNCTION public.grant_discount_if_has_multiple_of_10_payments() RETURNS trigger
   LANGUAGE plpgsql AS
$$BEGIN
	
	IF (SELECT count(p.payment_id) FROM public.payment p where customer_id = NEW.customer_id) % 10 = 0 THEN
		RAISE NOTICE 'WIELOKROTNOŚĆ 10 WYPOZYCZEŃ';
	END IF;

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