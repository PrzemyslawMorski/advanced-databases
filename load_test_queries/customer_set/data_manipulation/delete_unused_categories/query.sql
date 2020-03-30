delete from
    category c
where
    c.category_id not in (
        select
            category_id
        from
            film_category
    )