--select * from call_start_logs
;
with cte_call_start_logs as (
    Select
        *,
        row_number() over(
            partition by phone_number
            order by
                start_time asc
        ) as rnk_call_start_logs
    from
        call_start_logs
),
cte_call_end_logs as (
    Select
        *,
        row_number() over(
            partition by phone_number
            order by
                end_time asc
        ) as rnk_call_end_logs
    from
        call_end_logs
) --Using Joins and Window
Select
    a.PHONE_NUMBER,
    a.START_TIME,
    b.END_TIME,
    datediff(minute, a.START_TIME, b.END_TIME) call_duration_minutes
from
    (
        Select
            *,
            row_number() over(
                partition by phone_number
                order by
                    start_time asc
            ) as rnk_call_start_logs
        from
            call_start_logs
    ) a
    inner join (
        Select
            *,
            row_number() over(
                partition by phone_number
                order by
                    end_time asc
            ) as rnk_call_end_logs
        from
            call_end_logs
    ) b on a.PHONE_NUMBER = b.PHONE_NUMBER
    and a.rnk_call_start_logs = b.rnk_call_end_logs ---Union All
select
    PHONE_NUMBER,
    datediff(minute, min(START_TIME), max(START_TIME)) as call_duration_minutes
from
    (
        Select
            *,
            row_number() over(
                partition by phone_number
                order by
                    start_time asc
            ) as rnk_call_start_logs
        from
            call_start_logs
        union all
        Select
            *,
            row_number() over(
                partition by phone_number
                order by
                    end_time asc
            ) as rnk_call_end_logs
        from
            call_end_logs
    )
group by
    PHONE_NUMBER,
    rnk_call_start_logs
Select
    start_1.PHONE_NUMBER,
    start_1.START_TIME,
    end_1.END_TIME,
    datediff(minute, start_1.START_TIME, end_1.END_TIME) call_duration_minutes
from
    cte_call_start_logs start_1
    inner join cte_call_end_logs end_1 on start_1.PHONE_NUMBER = end_1.PHONE_NUMBER
    and start_1.rnk_call_start_logs = end_1.rnk_call_end_logs
order by
    start_1.PHONE_NUMBER
    /*
    create table call_start_logs
    (
    phone_number varchar(10),
    start_time datetime
    );
    insert into call_start_logs values
    ('PN1','2022-01-01 10:20:00'),('PN1','2022-01-01 16:25:00'),('PN2','2022-01-01 12:30:00')
    ,('PN3','2022-01-02 10:00:00'),('PN3','2022-01-02 12:30:00'),('PN3','2022-01-03 09:20:00')
    create table call_end_logs
    (
    phone_number varchar(10),
    end_time datetime
    );
    insert into call_end_logs values
    ('PN1','2022-01-01 10:45:00'),('PN1','2022-01-01 17:05:00'),('PN2','2022-01-01 12:55:00')
    ,('PN3','2022-01-02 10:20:00'),('PN3','2022-01-02 12:50:00'),('PN3','2022-01-03 09:40:00')
    ;
    */
    /*
    Write a query to find the start time and endtime of each call from below 2 tables;Also create column of call_duration in minutes
    there will be a multiple calls from one phone number
    */