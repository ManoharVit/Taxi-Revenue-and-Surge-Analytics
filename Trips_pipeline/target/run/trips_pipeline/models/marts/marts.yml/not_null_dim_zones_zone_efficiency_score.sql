
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select zone_efficiency_score
from "trips"."main"."dim_zones"
where zone_efficiency_score is null



  
  
      
    ) dbt_internal_test