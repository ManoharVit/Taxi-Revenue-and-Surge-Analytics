

with source as (

    select *
    from "trips"."main"."raw_trips"

),

standardized as (

    select
        lower(service_type) as service_type,

        cast(VendorID as integer) as vendor_id,

        cast(coalesce(tpep_pickup_datetime, lpep_pickup_datetime) as timestamp) as pickup_datetime,
        cast(coalesce(tpep_dropoff_datetime, lpep_dropoff_datetime) as timestamp) as dropoff_datetime,

        cast(passenger_count as integer) as passenger_count,
        cast(trip_distance as double) as trip_distance,
        cast(RatecodeID as integer) as rate_code_id,
        store_and_fwd_flag,

        cast(PULocationID as integer) as pickup_location_id,
        cast(DOLocationID as integer) as dropoff_location_id,

        cast(payment_type as integer) as payment_type,

        cast(fare_amount as double) as fare_amount,
        cast(extra as double) as extra,
        cast(mta_tax as double) as mta_tax,
        cast(tip_amount as double) as tip_amount,
        cast(tolls_amount as double) as tolls_amount,
        cast(improvement_surcharge as double) as improvement_surcharge,
        cast(total_amount as double) as total_amount,
        cast(congestion_surcharge as double) as congestion_surcharge,
        cast(cbd_congestion_fee as double) as cbd_congestion_fee,

        -- service-specific fields
        cast("Airport_fee" as double) as airport_fee,
        cast(ehail_fee as double) as ehail_fee,
        cast(trip_type as integer) as trip_type

    from source

),

derived as (

    select
        service_type,
        vendor_id,

        pickup_datetime,
        dropoff_datetime,

        cast(pickup_datetime as date) as trip_date,
        extract(year from pickup_datetime) as trip_year,
        extract(month from pickup_datetime) as trip_month,
        extract(day from pickup_datetime) as trip_day,
        extract(hour from pickup_datetime) as pickup_hour,
        extract(dow from pickup_datetime) as pickup_day_of_week_num,
        strftime(pickup_datetime, '%A') as pickup_day_name,

        case
            when extract(hour from pickup_datetime) between 5 and 11 then 'morning'
            when extract(hour from pickup_datetime) between 12 and 16 then 'afternoon'
            when extract(hour from pickup_datetime) between 17 and 21 then 'evening'
            else 'night'
        end as time_of_day_bucket,

        passenger_count,
        trip_distance,
        rate_code_id,
        store_and_fwd_flag,

        pickup_location_id,
        dropoff_location_id,

        payment_type,
        fare_amount,
        extra,
        mta_tax,
        tip_amount,
        tolls_amount,
        improvement_surcharge,
        total_amount,
        congestion_surcharge,
        cbd_congestion_fee,
        airport_fee,
        ehail_fee,
        trip_type,

        datediff('minute', pickup_datetime, dropoff_datetime) as trip_duration_minutes

    from standardized

)

select *
from derived
where pickup_datetime is not null
  and dropoff_datetime is not null
  and pickup_datetime >= '2025-01-01'
  and pickup_datetime < '2026-01-01'