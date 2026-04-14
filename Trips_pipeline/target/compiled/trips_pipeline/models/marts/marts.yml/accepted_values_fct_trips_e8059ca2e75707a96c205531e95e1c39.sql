
    
    

with all_values as (

    select
        pickup_day_of_week_num as value_field,
        count(*) as n_records

    from "trips"."main"."fct_trips"
    group by pickup_day_of_week_num

)

select *
from all_values
where value_field not in (
    '0','1','2','3','4','5','6'
)


