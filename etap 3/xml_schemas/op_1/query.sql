ALTER TABLE city ADD COLUMN rentals_xml xml DEFAULT xmlroot(xmlelement(name rentals), version '1.0');

-- AFTER INSERT RENTAL TRIGGER
CREATE OR REPLACE FUNCTION public.update_city_rentals_after_rental_insert() RETURNS trigger
   AS $$
DECLARE    
    film_id TEXT := (SELECT film_id FROM inventory i where i.inventory_id = NEW.inventory_id);
    store_id TEXT := (SELECT store_id FROM staff st where st.staff_id = NEW.staff_id);
    store_city_id integer := (SELECT city_id FROM address a where a.address_id = (SELECT address_id FROM store s where s.store_id = (SELECT store_id FROM staff st where st.staff_id = NEW.staff_id)));
BEGIN
	update city 
	set rentals_xml = xmlroot(xmlElement(name rentals, xpath('/rentals/rental', rentals_xml),
                                       xmlforest(NEW.rental_id AS rental_id,
                                                 store_id as store_id,
                                                 film_id as film_id,
                                                 NEW.customer_id as customer_id)), version '1.0')
	where city_id = store_city_id;
END; 
$$ LANGUAGE plpgsql;
 
CREATE CONSTRAINT TRIGGER update_city_rentals_after_rental_insert_trigger
   AFTER INSERT ON public.rental
   INITIALLY IMMEDIATE
   FOR EACH ROW 
   EXECUTE PROCEDURE public.update_city_rentals_after_rental_insert();