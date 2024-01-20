with source as (

    select * from {{ source('banner__saturn', 'sorlcur') }}

),

renamed as (

    select
        sorlcur_pidm,
        sorlcur_seqno,
        sorlcur_lmod_code,
        sorlcur_term_code,
        sorlcur_key_seqno,
        sorlcur_priority_no,
        sorlcur_roll_ind,
        sorlcur_cact_code,
        sorlcur_user_id,
        sorlcur_data_origin,
        sorlcur_activity_date,
        sorlcur_levl_code,
        sorlcur_coll_code,
        sorlcur_degc_code,
        sorlcur_term_code_ctlg,
        sorlcur_term_code_end,
        sorlcur_term_code_matric,
        sorlcur_term_code_admit,
        sorlcur_admt_code,
        sorlcur_camp_code,
        sorlcur_program,
        sorlcur_start_date,
        sorlcur_end_date,
        sorlcur_curr_rule,
        sorlcur_rolled_seqno,
        sorlcur_styp_code,
        sorlcur_rate_code,
        sorlcur_leav_code,
        sorlcur_leav_from_date,
        sorlcur_leav_to_date,
        sorlcur_exp_grad_date,
        sorlcur_term_code_grad,
        sorlcur_acyr_code,
        sorlcur_site_code,
        sorlcur_appl_seqno,
        sorlcur_appl_key_seqno,
        sorlcur_user_id_update,
        sorlcur_activity_date_update,
        sorlcur_gapp_seqno,
        sorlcur_current_cde,
        sorlcur_surrogate_id,
        sorlcur_version,
        sorlcur_vpdi_code

    from source

)

select * from renamed