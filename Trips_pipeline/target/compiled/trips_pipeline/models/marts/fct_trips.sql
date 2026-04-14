

with trips as (

    select *
    from "trips"."main"."stg_trips"

),

pickup_zones as (

    select *
    from "trips"."main"."stg_zones"

),

dropoff_zones as (

    select *
    from "trips"."main"."stg_zones"

),

enriched as (

    select
        t.service_type,
        t.vendor_id,

        t.pickup_datetime,
        t.dropoff_datetime,
        t.trip_date,
        t.trip_year,
        t.trip_month,
        t.trip_day,
        t.pickup_hour,
        t.pickup_day_of_week_num,
        t.pickup_day_name,
        t.time_of_day_bucket,

        t.passenger_count,
        t.trip_distance,
        t.rate_code_id,
        t.store_and_fwd_flag,

        t.pickup_location_id,
        pz.borough as pickup_borough,
        pz.zone_name as pickup_zone_name,
        pz.service_zone as pickup_service_zone,

        t.dropoff_location_id,
        dz.borough as dropoff_borough,
        dz.zone_name as dropoff_zone_name,
        dz.service_zone as dropoff_service_zone,

        t.payment_type,
        t.fare_amount,
        t.extra,
        t.mta_tax,
        t.tip_amount,
        t.tolls_amount,
        t.improvement_surcharge,
        t.total_amount,
        t.congestion_surcharge,
        t.cbd_congestion_fee,
        t.airport_fee,
        t.ehail_fee,
        t.trip_type,

        t.trip_duration_minutes,

        case
            when t.trip_distance > 0
                then round(t.total_amount / t.trip_distance, 2)
            else null
        end as revenue_per_mile,

        case
            when t.fare_amount > 0
                then round((t.tip_amount / t.fare_amount) * 100, 2)
            else null
        end as tip_percentage,

        case
            when t.trip_duration_minutes > 0
                then round(t.trip_distance / (t.trip_duration_minutes / 60.0), 2)
            else null
        end as average_speed_mph

    from trips t
    left join pickup_zones pz
        on t.pickup_location_id = pz.location_id
    left join dropoff_zones dz
        on t.dropoff_location_id = dz.location_id

),

filtered as (

    select *
    from enriched
    where pickup_datetime >= '2025-01-01'
      and pickup_datetime < '2026-01-01'
      and dropoff_datetime >= pickup_datetime
      and trip_duration_minutes between 1 and 1440
      and trip_distance > 0
      and fare_amount >= 0
      and total_amount > 0
      and pickup_location_id is not null
      and dropoff_location_id is not null

)

select *
from filtered