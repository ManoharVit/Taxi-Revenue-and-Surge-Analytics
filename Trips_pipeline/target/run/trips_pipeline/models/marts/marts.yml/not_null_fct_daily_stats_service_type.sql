
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select service_type
from "trips"."main"."fct_daily_stats"
where service_type is null



  
  
      
    ) dbt_internal_test