with staff_sales_with_avg_sales as (
    with avg_staff_sales as (
        with staff_sales as (
            select
                count(r.rental_id) as num_sales
            from
                staff s
                left outer join rental r on s.staff_id = r.staff_id
            group by
                s.staff_id
        )
        select
            avg(num_sales) as average_sales_per_staff
        from
            staff_sales
    )
    select
        count(r.rental_id) as num_sales,
        first_name,
        last_name,
        (
            select
                *
            from
                avg_staff_sales
        )
    from
        staff s
        left outer join rental r on s.staff_id = r.staff_id
    group by
        s.staff_id
)
select
    *
from
    staff_sales_with_avg_sales
where
    num_sales >= average_sales_per_staff