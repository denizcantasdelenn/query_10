--find start and end date of each block started with success or fail.

create table tasks (
date_value date,
state varchar(10)
);

insert into tasks  values ('2019-01-01','success'),('2019-01-02','success'),('2019-01-03','success'),('2019-01-04','fail')
,('2019-01-05','fail'),('2019-01-06','success')

--select * from tasks

with cte as (
select *, 
day(date_value) - date_order_flag as grouped_day
from (
select *, 
rank() over(partition by state order by date_value) as date_order_flag
from tasks) A)

select min(date_value) as start_date, max(date_value) as finish_date, state
from cte
group by state, grouped_day
order by start_date