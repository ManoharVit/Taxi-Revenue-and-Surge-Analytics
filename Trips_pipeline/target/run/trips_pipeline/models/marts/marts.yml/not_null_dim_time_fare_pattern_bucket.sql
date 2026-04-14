
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select fare_pattern_bucket
from "trips"."main"."dim_time"
where fare_pattern_bucket is null



  
  
      
    ) dbt_internal_test