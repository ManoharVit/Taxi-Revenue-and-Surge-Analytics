
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with all_values as (

    select
        time_of_day_bucket as value_field,
        count(*) as n_records

    from "trips"."main"."fct_trips"
    group by time_of_day_bucket

)

select *
from all_values
where value_field not in (
    'morning','afternoon','evening','night'
)



  
  
      
    ) dbt_internal_test