
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  





with validation_errors as (

    select
        service_type, pickup_day_of_week_num, pickup_hour
    from "trips"."main"."dim_time"
    group by service_type, pickup_day_of_week_num, pickup_hour
    having count(*) > 1

)

select *
from validation_errors



  
  
      
    ) dbt_internal_test