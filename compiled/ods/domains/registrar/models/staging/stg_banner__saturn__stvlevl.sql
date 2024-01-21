with source as (

    select * from "ods"."banner"."stvlevl"

),

renamed as (

    select
        stvlevl_code,
        stvlevl_desc,
        stvlevl_activity_date,
        stvlevl_acad_ind,
        stvlevl_ceu_ind,
        stvlevl_system_req_ind,
        stvlevl_vr_msg_no,
        stvlevl_edi_equiv,
        stvlevl_surrogate_id,
        stvlevl_version,
        stvlevl_user_id,
        stvlevl_data_origin,
        stvlevl_vpdi_code

    from source

)

select * from renamed