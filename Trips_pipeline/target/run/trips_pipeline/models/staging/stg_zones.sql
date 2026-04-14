
  
  create view "trips"."main"."stg_zones__dbt_tmp" as (
    

with source as (

    select *
    from "trips"."main"."raw_zones"

),

cleaned as (

    select
        cast(LocationID as integer) as location_id,
        trim(Borough) as borough,
        trim(Zone) as zone_name,
        trim(service_zone) as service_zone

    from source

)

select *
from cleaned
where borough not in ('Unknown', 'N/A')
  and location_id is not null
  );
