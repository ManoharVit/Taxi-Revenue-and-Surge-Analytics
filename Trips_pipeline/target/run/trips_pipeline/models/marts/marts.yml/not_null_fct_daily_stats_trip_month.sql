
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select trip_month
from "trips"."main"."fct_daily_stats"
where trip_month is null



  
  
      
    ) dbt_internal_test