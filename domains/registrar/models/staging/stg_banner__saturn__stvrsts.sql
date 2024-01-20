with source as (

    select * from {{ source('banner__saturn', 'stvrsts') }}

),

renamed as (

    select
        stvrsts_code,
        stvrsts_desc,
        stvrsts_enterable_ind,
        stvrsts_incl_sect_enrl,
        stvrsts_incl_assess,
        stvrsts_auto_grade,
        stvrsts_gradable_ind,
        stvrsts_activity_date,
        stvrsts_wait_ind,
        stvrsts_system_req_ind,
        stvrsts_incl_vrfy,
        stvrsts_voice_type,
        stvrsts_sb_print_ind,
        stvrsts_withdraw_ind,
        stvrsts_web_ind,
        stvrsts_extension_ind,
        stvrsts_attempt_hr_ind,
        stvrsts_incl_tmst_ind,
        stvrsts_action_desc,
        stvrsts_surrogate_id,
        stvrsts_version,
        stvrsts_user_id,
        stvrsts_data_origin,
        stvrsts_vpdi_code,
        stvrsts_apport_ind,
        stvrsts_audit_ind,
        stvrsts_mis_bogw_ind

    from source

)

select * from renamed