CREATE TABLE public.film_change_history (
    film_id serial NOT NULL,
    change_date timestamp without time zone DEFAULT now() NOT NULL,
    field_name text,
    old_value text,
    new_value text
);