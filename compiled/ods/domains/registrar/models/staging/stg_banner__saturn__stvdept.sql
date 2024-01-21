with source as (

    select * from "ods"."banner"."stvdept"

),

renamed as (

    select
        stvdept_code,
        stvdept_desc,
        stvdept_activity_date,
        stvdept_coll_code,
        stvdept_system_req_ind,
        stvdept_classlist,
        stvdept_roster_by_disc,
        stvdept_vr_msg_no,
        stvdept_stu_schd_print_flag,
        stvdept_grade_mail_ind,
        stvdept_surrogate_id,
        stvdept_version,
        stvdept_user_id,
        stvdept_data_origin,
        stvdept_vpdi_code

    from source

)

select * from renamed