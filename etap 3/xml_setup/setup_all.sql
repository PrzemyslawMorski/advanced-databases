
ALTER TABLE public.city ADD COLUMN rentals_xml xml DEFAULT xmlroot(xmlelement(name rentals), version '1.0');

-- AFTER INSERT RENTAL TRIGGER
CREATE OR REPLACE FUNCTION public.update_city_rentals_after_rental_insert() RETURNS trigger
   AS $$
DECLARE    
    film_id TEXT := (SELECT film_id FROM inventory i where i.inventory_id = NEW.inventory_id);
    store_id TEXT := (SELECT store_id FROM staff st where st.staff_id = NEW.staff_id);
    store_city_id integer := (SELECT city_id FROM address a where a.address_id = (SELECT address_id FROM store s where s.store_id = (SELECT st.store_id FROM staff st where st.staff_id = NEW.staff_id)));
BEGIN
    update city 
    set rentals_xml = REGEXP_REPLACE(
        xmlroot(xmlElement(name rentals,
                      xpath('/rentals/rental', (select rentals_xml from city where city_id = store_city_id))
                           || xmlElement(name rental, xmlforest(NEW.rental_id AS rental_id,
                                                 store_id as store_id,
                                                 film_id as film_id,
                                                 NEW.customer_id as customer_id))
                  ), version '1.0')::text,
        '<element>|</element>',
        '', 'g')::xml
    where city_id = store_city_id;
    
    RETURN NEW;
END; 
$$ LANGUAGE plpgsql;
 

DROP TRIGGER IF EXISTS public.update_city_rentals_after_rental_insert_trigger ON public.rental;

CREATE CONSTRAINT TRIGGER public.update_city_rentals_after_rental_insert_trigger
   AFTER INSERT ON public.rental
   INITIALLY IMMEDIATE
   FOR EACH ROW 
   EXECUTE PROCEDURE public.update_city_rentals_after_rental_insert();


ALTER TABLE public.film ADD COLUMN actors_xml xml DEFAULT xmlroot(xmlelement(name actors), version '1.0');
ALTER TABLE public.actor ADD COLUMN films_xml xml DEFAULT xmlroot(xmlelement(name films), version '1.0');
ALTER TABLE public.film ADD COLUMN change_history_xml xml DEFAULT xmlroot(xmlelement(name changes), version '1.0');

CREATE TABLE public.rentals_by_year (
    year int PRIMARY KEY,
    rentals_xml xml DEFAULT xmlroot(xmlelement(name rentals), version '1.0')
);

-- AFTER INSERT RENTAL TRIGGER
CREATE OR REPLACE FUNCTION public.insert_into_rentals_by_year_after_rental_insert() RETURNS trigger
   AS $$
DECLARE   
    this_year int := date_part('year', NEW.rental_date);
BEGIN

    IF (select year from rentals_by_year where year = this_year) IS NULL THEN
        insert into rentals_by_year (year) values (this_year);
    END IF;

    update rentals_by_year 
    set rentals_xml = REGEXP_REPLACE(
        xmlroot(xmlElement(name rentals,
                      xpath('/rentals/rental', rentals_xml)
                           || xmlElement(name rental, xmlforest(NEW.rental_id AS rental_id))
                  ), version '1.0')::text,
        '<element>|</element>',
        '', 'g')::xml
    where year = this_year;
    
    RETURN NEW;
END; 
$$ LANGUAGE plpgsql;
 

DROP TRIGGER IF EXISTS public.insert_into_rentals_by_year_after_rental_insert_trigger ON public.rental;

CREATE CONSTRAINT TRIGGER insert_into_rentals_by_year_after_rental_insert_trigger
   AFTER INSERT ON public.rental
   INITIALLY IMMEDIATE
   FOR EACH ROW 
   EXECUTE PROCEDURE public.insert_into_rentals_by_year_after_rental_insert();