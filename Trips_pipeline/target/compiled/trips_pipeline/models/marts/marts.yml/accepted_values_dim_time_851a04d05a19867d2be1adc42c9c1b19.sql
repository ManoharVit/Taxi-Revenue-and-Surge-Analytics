
    
    

with all_values as (

    select
        fare_pattern_bucket as value_field,
        count(*) as n_records

    from "trips"."main"."dim_time"
    group by fare_pattern_bucket

)

select *
from all_values
where value_field not in (
    'high','above_average','average','below_average'
)


