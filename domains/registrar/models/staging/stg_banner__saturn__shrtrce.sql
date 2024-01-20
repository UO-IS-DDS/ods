with source as (

    select * from {{ source('banner__saturn', 'shrtrce') }}

),

renamed as (

    select
        shrtrce_pidm,
        shrtrce_trit_seq_no,
        shrtrce_tram_seq_no,
        shrtrce_seq_no,
        shrtrce_trcr_seq_no,
        shrtrce_term_code_eff,
        shrtrce_levl_code,
        shrtrce_subj_code,
        shrtrce_crse_numb,
        shrtrce_crse_title,
        shrtrce_credit_hours,
        shrtrce_grde_code,
        shrtrce_gmod_code,
        shrtrce_count_in_gpa_ind,
        shrtrce_activity_date,
        shrtrce_scid,
        shrtrce_repeated,
        shrtrce_repeat_course,
        shrtrce_repeat_sys,
        shrtrce_surrogate_id,
        shrtrce_version,
        shrtrce_user_id,
        shrtrce_data_origin,
        shrtrce_vpdi_code,
        shrtrce_stsp_key_sequence,
        shrtrce_appl_no

    from source

)

select * from renamed