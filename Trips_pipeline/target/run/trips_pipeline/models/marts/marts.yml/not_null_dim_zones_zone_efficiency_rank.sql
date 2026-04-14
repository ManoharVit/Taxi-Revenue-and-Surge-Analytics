
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select zone_efficiency_rank
from "trips"."main"."dim_zones"
where zone_efficiency_rank is null



  
  
      
    ) dbt_internal_test