;
with leet as (
    SELECT
        *,
        row_number() over(
            order by
                visit_date
        ) as rn,
        Id - row_number() over(
            order by
                visit_date
        ) as grp
    from
        stadium
    where
        no_of_people > 100
)
Select
    Id,
    visit_date,
    no_of_people
from
    leet
where
    grp in (
        Select
            grp cnt
        from
            leet
        group by
            grp
        having
            count(grp) > 3
    )