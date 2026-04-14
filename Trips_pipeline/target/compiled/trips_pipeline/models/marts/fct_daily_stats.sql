

with base as (

    select *
    from "trips"."main"."fct_trips"

),

daily as (

    select
        trip_date,
        service_type,
        coalesce(pickup_borough, 'Unknown') as pickup_borough,

        count(*) as trip_count,
        round(sum(total_amount), 2) as total_revenue,
        round(sum(fare_amount), 2) as total_fare_amount,
        round(sum(tip_amount), 2) as total_tip_amount,

        round(avg(total_amount), 2) as avg_revenue_per_trip,
        round(avg(fare_amount), 2) as avg_fare_amount,
        round(avg(tip_percentage), 2) as avg_tip_percentage,
        round(avg(revenue_per_mile), 2) as avg_revenue_per_mile,
        round(avg(trip_distance), 2) as avg_trip_distance,
        round(avg(trip_duration_minutes), 2) as avg_trip_duration_minutes,

        round(
            sum(total_amount) / nullif(count(*), 0),
            2
        ) as revenue_per_trip

    from base
    group by 1, 2, 3

)

select
    trip_date,
    extract(year from trip_date) as trip_year,
    extract(month from trip_date) as trip_month,
    strftime(trip_date, '%A') as day_name,

    case
        when extract(dow from trip_date) in (0, 6) then true
        else false
    end as is_weekend,

    service_type,
    pickup_borough,

    trip_count,
    total_revenue,
    total_fare_amount,
    total_tip_amount,
    avg_revenue_per_trip,
    avg_fare_amount,
    avg_tip_percentage,
    avg_revenue_per_mile,
    avg_trip_distance,
    avg_trip_duration_minutes,
    revenue_per_trip

from daily