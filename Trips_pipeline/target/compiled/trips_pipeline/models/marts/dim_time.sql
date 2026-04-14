

with base as (

    select *
    from "trips"."main"."fct_trips"

),

service_baseline as (

    select
        service_type,
        avg(fare_amount) as service_avg_fare,
        avg(total_amount) as service_avg_total
    from base
    group by 1

),

time_metrics as (

    select
        service_type,
        pickup_day_of_week_num,
        pickup_day_name,
        pickup_hour,
        time_of_day_bucket,

        count(*) as trip_count,
        round(avg(fare_amount), 2) as avg_fare_amount,
        round(avg(total_amount), 2) as avg_total_amount,
        round(avg(tip_percentage), 2) as avg_tip_percentage,
        round(avg(revenue_per_mile), 2) as avg_revenue_per_mile,
        round(avg(trip_distance), 2) as avg_trip_distance,
        round(avg(trip_duration_minutes), 2) as avg_trip_duration_minutes

    from base
    group by 1, 2, 3, 4, 5

),

final as (

    select
        tm.service_type,
        tm.pickup_day_of_week_num,
        tm.pickup_day_name,
        tm.pickup_hour,
        tm.time_of_day_bucket,

        tm.trip_count,
        tm.avg_fare_amount,
        tm.avg_total_amount,
        tm.avg_tip_percentage,
        tm.avg_revenue_per_mile,
        tm.avg_trip_distance,
        tm.avg_trip_duration_minutes,

        round(
            (tm.avg_fare_amount / nullif(sb.service_avg_fare, 0)) * 100,
            2
        ) as fare_index,

        round(
            (tm.avg_total_amount / nullif(sb.service_avg_total, 0)) * 100,
            2
        ) as total_amount_index,

        case
            when (tm.avg_fare_amount / nullif(sb.service_avg_fare, 0)) * 100 >= 120
                then 'high'
            when (tm.avg_fare_amount / nullif(sb.service_avg_fare, 0)) * 100 >= 105
                then 'above_average'
            when (tm.avg_fare_amount / nullif(sb.service_avg_fare, 0)) * 100 >= 95
                then 'average'
            else 'below_average'
        end as fare_pattern_bucket

    from time_metrics tm
    left join service_baseline sb
        on tm.service_type = sb.service_type

)

select *
from final
order by service_type, pickup_day_of_week_num, pickup_hour