--Highest and lowest salasry in  each department
/*
create table employee 
(
emp_name varchar(10),
dep_id int,
salary int
);
delete from employee;
insert into employee values 
('Siva',1,30000),('Ravi',2,40000),('Prasad',1,50000),('Sai',2,20000)
*/;
with sal as (
    select
        dep_id,
        max(salary) emp_max_sal,
        min(salary) emp_min_sal
    from
        employee
    group by
        dep_id
)
Select
    e.dep_id,
    max(
        case
            when e.salary = s.EMP_MAX_SAL then emp_name
        end
    ) as emp_max_sal,
    max(
        case
            when e.salary = s.EMP_MIN_SAL then emp_name
        end
    ) as emp_min_sal
from
    employee e
    inner join sal s on e.dep_id = s.dep_id
group by
    e.dep_id
order by
    e.dep_id