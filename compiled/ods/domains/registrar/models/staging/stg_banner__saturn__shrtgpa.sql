with source as (

    select * from "ods"."banner"."shrtgpa"

),

renamed as (

    select
        shrtgpa_pidm,
        shrtgpa_term_code,
        shrtgpa_levl_code,
        shrtgpa_gpa_type_ind,
        shrtgpa_trit_seq_no,
        shrtgpa_tram_seq_no,
        shrtgpa_hours_attempted,
        shrtgpa_hours_earned,
        shrtgpa_gpa_hours,
        shrtgpa_quality_points,
        shrtgpa_gpa,
        shrtgpa_activity_date,
        shrtgpa_hours_passed,
        shrtgpa_surrogate_id,
        shrtgpa_version,
        shrtgpa_user_id,
        shrtgpa_data_origin,
        shrtgpa_vpdi_code

    from source

)

select * from renamed