
    
    

with all_values as (

    select
        time_of_day_bucket as value_field,
        count(*) as n_records

    from "trips"."main"."dim_time"
    group by time_of_day_bucket

)

select *
from all_values
where value_field not in (
    'morning','afternoon','evening','night'
)


