
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select trip_count
from "trips"."main"."fct_daily_stats"
where trip_count is null



  
  
      
    ) dbt_internal_test