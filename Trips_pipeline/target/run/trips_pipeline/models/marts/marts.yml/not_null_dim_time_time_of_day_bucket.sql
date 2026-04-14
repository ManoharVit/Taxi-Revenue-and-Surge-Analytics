
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select time_of_day_bucket
from "trips"."main"."dim_time"
where time_of_day_bucket is null



  
  
      
    ) dbt_internal_test