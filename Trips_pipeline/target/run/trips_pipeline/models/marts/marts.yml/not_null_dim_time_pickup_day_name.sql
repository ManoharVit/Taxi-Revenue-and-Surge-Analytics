
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select pickup_day_name
from "trips"."main"."dim_time"
where pickup_day_name is null



  
  
      
    ) dbt_internal_test