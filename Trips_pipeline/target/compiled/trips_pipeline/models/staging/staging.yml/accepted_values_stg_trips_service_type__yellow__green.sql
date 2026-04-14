
    
    

with all_values as (

    select
        service_type as value_field,
        count(*) as n_records

    from "trips"."main"."stg_trips"
    group by service_type

)

select *
from all_values
where value_field not in (
    'yellow','green'
)


