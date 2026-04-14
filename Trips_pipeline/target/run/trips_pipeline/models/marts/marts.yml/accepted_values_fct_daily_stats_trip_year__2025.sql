
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with all_values as (

    select
        trip_year as value_field,
        count(*) as n_records

    from "trips"."main"."fct_daily_stats"
    group by trip_year

)

select *
from all_values
where value_field not in (
    '2025'
)



  
  
      
    ) dbt_internal_test