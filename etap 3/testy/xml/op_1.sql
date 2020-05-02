WITH city_and_rentals as (select city, rentals_xml from city RETURNING *)
    (SELECT city from city_and_rentals),
    ()
;

    city,
    address,
    title,
    first_name,
    last_name,
    email
