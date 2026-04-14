
    
    

with all_values as (

    select
        trip_year as value_field,
        count(*) as n_records

    from "trips"."main"."fct_trips"
    group by trip_year

)

select *
from all_values
where value_field not in (
    '2025'
)


