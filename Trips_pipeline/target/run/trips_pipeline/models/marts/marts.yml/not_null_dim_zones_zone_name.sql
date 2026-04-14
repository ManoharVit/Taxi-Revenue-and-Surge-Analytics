
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select zone_name
from "trips"."main"."dim_zones"
where zone_name is null



  
  
      
    ) dbt_internal_test