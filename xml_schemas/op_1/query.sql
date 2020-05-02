ALTER TABLE city ADD COLUMN rentals_xml xml DEFAULT xmlroot(xmlelement(name rentals), version '1.0');

-- AFTER INSERT RENTAL TRIGGER
CREATE OR REPLACE FUNCTION public.update_city_rentals_after_rental_insert() RETURNS trigger
   LANGUAGE plpgsql AS
$$BEGIN
    DECLARE @film_id TEXT
    SET @film_id = SELECT film_id FROM inventory i where i.inventory_id = NEW.inventory_id

    DECLARE @store_id TEXT
    SET @store_id = SELECT store_id FROM staff st where st.staff_id = NEW.staff_id

    DECLARE @store_city_id INT
    SET @store_city_id = SELECT city_id FROM address a where a.address_id = (SELECT address_id FROM store s where s.store_id = (SELECT store_id FROM staff st where st.staff_id = NEW.staff_id))

END;$$;
 
CREATE CONSTRAINT TRIGGER update_city_rentals_after_rental_insert_trigger
   AFTER INSERT ON public.rental
   INITIALLY IMMEDIATE
   FOR EACH ROW 
   EXECUTE PROCEDURE public.update_city_rentals_after_rental_insert();



-- AFTER DELETE RENTAL TRIGGER
CREATE OR REPLACE FUNCTION public.update_city_rentals_after_rental_delete() RETURNS trigger
   LANGUAGE plpgsql AS
$$BEGIN



END;$$;

DROP TRIGGER IF EXISTS update_city_rentals_after_rental_delete_trigger ON public.rental;
 
CREATE CONSTRAINT TRIGGER update_city_rentals_after_rental_delete_trigger
   AFTER DELETE ON public.rental
   INITIALLY IMMEDIATE
   FOR EACH ROW 
   EXECUTE PROCEDURE public.block_renting_as_nonactive_user();