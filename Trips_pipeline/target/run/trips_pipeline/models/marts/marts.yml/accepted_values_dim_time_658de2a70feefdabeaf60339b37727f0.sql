
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with all_values as (

    select
        pickup_day_of_week_num as value_field,
        count(*) as n_records

    from "trips"."main"."dim_time"
    group by pickup_day_of_week_num

)

select *
from all_values
where value_field not in (
    '0','1','2','3','4','5','6'
)



  
  
      
    ) dbt_internal_test