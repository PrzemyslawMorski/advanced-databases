delete from
    rental r
where
    r.customer_id = 1;

delete from
    payment p
where
    p.customer_id = 1;

delete from
    customer c
where
    c.customer_id = 1;