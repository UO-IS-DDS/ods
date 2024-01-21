with source as (

    select * from "ods"."banner"."shrlgpa"

),

renamed as (

    select
        shrlgpa_pidm,
        shrlgpa_levl_code,
        shrlgpa_gpa_type_ind,
        shrlgpa_hours_attempted,
        shrlgpa_hours_earned,
        shrlgpa_gpa_hours,
        shrlgpa_quality_points,
        shrlgpa_gpa,
        shrlgpa_activity_date,
        shrlgpa_hours_passed,
        shrlgpa_gpa_calc,
        shrlgpa_surrogate_id,
        shrlgpa_version,
        shrlgpa_user_id,
        shrlgpa_data_origin,
        shrlgpa_vpdi_code

    from source

)

select * from renamed