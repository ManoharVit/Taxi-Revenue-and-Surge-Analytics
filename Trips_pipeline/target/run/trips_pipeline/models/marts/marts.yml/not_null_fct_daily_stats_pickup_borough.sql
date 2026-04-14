
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select pickup_borough
from "trips"."main"."fct_daily_stats"
where pickup_borough is null



  
  
      
    ) dbt_internal_test