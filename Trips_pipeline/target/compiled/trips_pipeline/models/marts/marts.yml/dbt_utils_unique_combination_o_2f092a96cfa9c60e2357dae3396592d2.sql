





with validation_errors as (

    select
        trip_date, service_type, pickup_borough
    from "trips"."main"."fct_daily_stats"
    group by trip_date, service_type, pickup_borough
    having count(*) > 1

)

select *
from validation_errors


