CREATE OR REPLACE FUNCTION public.dcrs_flm_rplcmnt_cst_insrt_flm_frm_sm_ctgry() RETURNS trigger
   LANGUAGE plpgsql AS
$$BEGIN
    RAISE NOTICE 'ZMNIEJSZENIE KOSZTU WYMIANY FILMOW Z KATEGORII DODANEGO FILMU';

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