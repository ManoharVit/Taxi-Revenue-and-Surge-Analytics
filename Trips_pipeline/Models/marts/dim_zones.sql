{{ config(materialized='table') }}

with base as (

    select *
    from {{ ref('fct_trips') }}

),

zone_metrics as (

    select
        service_type,
        pickup_location_id as location_id,
        coalesce(pickup_borough, 'Unknown') as borough,
        coalesce(pickup_zone_name, 'Unknown') as zone_name,
        coalesce(pickup_service_zone, 'Unknown') as service_zone,

        count(*) as total_trips,
        round(sum(total_amount), 2) as total_revenue,
        round(avg(total_amount), 2) as avg_revenue_per_trip,
        round(avg(revenue_per_mile), 2) as avg_revenue_per_mile,
        round(avg(tip_percentage), 2) as avg_tip_percentage,
        round(avg(trip_distance), 2) as avg_trip_distance,
        round(avg(trip_duration_minutes), 2) as avg_trip_duration_minutes

    from base
    group by 1, 2, 3, 4, 5

),

zone_hourly as (

    select
        service_type,
        pickup_location_id as location_id,
        pickup_hour,
        count(*) as trip_count
    from base
    group by 1, 2, 3

),

peak_hours as (

    select
        service_type,
        location_id,
        pickup_hour as peak_pickup_hour,
        trip_count as peak_hour_trip_count
    from (
        select
            service_type,
            location_id,
            pickup_hour,
            trip_count,
            row_number() over (
                partition by service_type, location_id
                order by trip_count desc, pickup_hour
            ) as rn
        from zone_hourly
    )
    where rn = 1

),

scored as (

    select
        zm.*,
        ph.peak_pickup_hour,
        ph.peak_hour_trip_count,

        percent_rank() over (
            partition by zm.service_type
            order by zm.avg_revenue_per_mile
        ) as revenue_per_mile_rank,

        percent_rank() over (
            partition by zm.service_type
            order by zm.avg_tip_percentage
        ) as tip_percentage_rank,

        percent_rank() over (
            partition by zm.service_type
            order by zm.total_trips
        ) as trip_volume_rank

    from zone_metrics zm
    left join peak_hours ph
        on zm.service_type = ph.service_type
       and zm.location_id = ph.location_id

),

final as (

    select
        service_type,
        location_id,
        borough,
        zone_name,
        service_zone,

        total_trips,
        total_revenue,
        avg_revenue_per_trip,
        avg_revenue_per_mile,
        avg_tip_percentage,
        avg_trip_distance,
        avg_trip_duration_minutes,

        peak_pickup_hour,
        peak_hour_trip_count,

        round(
            (
                0.40 * revenue_per_mile_rank +
                0.30 * tip_percentage_rank +
                0.30 * trip_volume_rank
            ) * 100,
            2
        ) as zone_efficiency_score,

        dense_rank() over (
            partition by service_type
            order by
                (
                    0.40 * revenue_per_mile_rank +
                    0.30 * tip_percentage_rank +
                    0.30 * trip_volume_rank
                ) desc,
                total_revenue desc
        ) as zone_efficiency_rank

    from scored

)

select *
from final