create table input (id int, formula varchar(10), value int);
Select
    *
from
    input;
with cte as (
        SELECT
            *,
            left(formula, 1) as id_1,
            right(formula, 1) as id_2,
            substr(formula, 2, 1) as op
        from
            input
    )
Select
    cte.id,
    cte.id_1,
    ip1.value as id1_value,
    cte.op,
    cte.id_2,
    ip2.value as id2_value
from
    cte
    inner join input ip1 on cte.id_1 = ip1.id
    inner join input ip2 on cte.id_2 = ip2.id;