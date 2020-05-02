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
 

DROP TRIGGER IF EXISTS insert_into_rentals_by_year_after_rental_insert_trigger ON public.rental;

CREATE CONSTRAINT TRIGGER insert_into_rentals_by_year_after_rental_insert_trigger
   AFTER INSERT ON public.rental
   INITIALLY IMMEDIATE
   FOR EACH ROW 
   EXECUTE PROCEDURE public.insert_into_rentals_by_year_after_rental_insert();