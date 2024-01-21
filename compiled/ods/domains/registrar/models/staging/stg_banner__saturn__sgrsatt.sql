with source as (

    select * from "ods"."banner"."sgrsatt"

),

renamed as (

    select
        sgrsatt_pidm,
        sgrsatt_term_code_eff,
        sgrsatt_atts_code,
        sgrsatt_activity_date,
        sgrsatt_stsp_key_sequence,
        sgrsatt_surrogate_id,
        sgrsatt_version,
        sgrsatt_user_id,
        sgrsatt_data_origin,
        sgrsatt_vpdi_code

    from source

)

select * from renamed