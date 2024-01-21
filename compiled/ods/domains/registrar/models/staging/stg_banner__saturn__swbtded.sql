with source as (

    select * from "ods"."banner"."swbtded"

),

renamed as (

    select
        swbtded_pidm,
        swbtded_levl_code,
        swbtded_user,
        swbtded_activity_date,
        swbtded_hours_deducted,
        swbtded_surrogate_id,
        swbtded_version,
        swbtded_user_id,
        swbtded_data_origin,
        swbtded_vpdi_code

    from source

)

select * from renamed