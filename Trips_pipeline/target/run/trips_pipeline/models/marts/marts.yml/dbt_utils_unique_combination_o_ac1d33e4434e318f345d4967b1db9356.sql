
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  





with validation_errors as (

    select
        service_type, location_id
    from "trips"."main"."dim_zones"
    group by service_type, location_id
    having count(*) > 1

)

select *
from validation_errors



  
  
      
    ) dbt_internal_test