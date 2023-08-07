//Solution 2
Select
    *
    --, SUM(case when criteria1 = 'Y' and criteria2 ='Y' then 1 else 0 end ) over ( partition by TEAMID ) eligileteam
,
    SUM(
        case
            when criteria1 = 'Y'
            and criteria2 = 'Y' then 1
            else 0
        end
    ) over (partition by TEAMID) >= 2 output
from
    Ameriprise_LLC
    /*
    Solution 1 
    ;with cte as (
    Select *, case when criteria1 = 'Y' and criteria2 = 'Y' then 'Y'
                   else 'N' end as memberid_meet from ameriprise_llc
    ),
     
    cte_1 as ( Select TEAMID as inner_TeamID  from cte
            where MEMBERID_MEET = 'Y'
            group by TEAMID
            having count(MEMBERID_MEET) >= 2) 
    
    Select a.*, case when cte_1.inner_TeamID IS NOT NULL then 'Y' 
                   else 'N' end as output 
        from ameriprise_llc a 
        left join cte_1
        on a.teamid = cte_1.inner_TeamID
            
    */
    /* DDL
    create table Ameriprise_LLC
    (
    teamID varchar(2),
    memberID varchar(10),
    Criteria1 varchar(1),
    Criteria2 varchar(1)
    );
    insert into Ameriprise_LLC values 
    ('T1','T1_mbr1','Y','Y'),
    ('T1','T1_mbr2','Y','Y'),
    ('T1','T1_mbr3','Y','Y'),
    ('T1','T1_mbr4','Y','Y'),
    ('T1','T1_mbr5','Y','N'),
    ('T2','T2_mbr1','Y','Y'),
    ('T2','T2_mbr2','Y','N'),
    ('T2','T2_mbr3','N','Y'),
    ('T2','T2_mbr4','N','N'),
    ('T2','T2_mbr5','N','N'),
    ('T3','T3_mbr1','Y','Y'),
    ('T3','T3_mbr2','Y','Y'),
    ('T3','T3_mbr3','N','Y'),
    ('T3','T3_mbr4','N','Y'),
    ('T3','T3_mbr5','Y','N');
    */