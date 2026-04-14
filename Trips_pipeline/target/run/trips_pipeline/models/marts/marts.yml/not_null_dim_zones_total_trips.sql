
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select total_trips
from "trips"."main"."dim_zones"
where total_trips is null



  
  
      
    ) dbt_internal_test