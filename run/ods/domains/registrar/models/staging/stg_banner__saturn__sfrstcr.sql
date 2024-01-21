
  
  create view "ods"."banner"."stg_banner__saturn__sfrstcr__dbt_tmp" as (
    with source as (

    select * from "ods"."banner"."sfrstcr"

),

renamed as (

    select
        sfrstcr_term_code,
        sfrstcr_pidm,
        sfrstcr_crn,
        sfrstcr_class_sort_key,
        sfrstcr_reg_seq,
        sfrstcr_ptrm_code,
        sfrstcr_rsts_code,
        sfrstcr_rsts_date,
        sfrstcr_error_flag,
        sfrstcr_message,
        sfrstcr_bill_hr,
        sfrstcr_waiv_hr,
        sfrstcr_credit_hr,
        sfrstcr_bill_hr_hold,
        sfrstcr_credit_hr_hold,
        sfrstcr_gmod_code,
        sfrstcr_grde_code,
        sfrstcr_grde_code_mid,
        sfrstcr_grde_date,
        sfrstcr_dupl_over,
        sfrstcr_link_over,
        sfrstcr_corq_over,
        sfrstcr_preq_over,
        sfrstcr_time_over,
        sfrstcr_capc_over,
        sfrstcr_levl_over,
        sfrstcr_coll_over,
        sfrstcr_majr_over,
        sfrstcr_clas_over,
        sfrstcr_appr_over,
        sfrstcr_appr_received_ind,
        sfrstcr_add_date,
        sfrstcr_activity_date,
        sfrstcr_levl_code,
        sfrstcr_camp_code,
        sfrstcr_reserved_key,
        sfrstcr_attend_hr,
        sfrstcr_wait_seqno,
        sfrstcr_wait_date_perm,
        sfrstcr_rept_over,
        sfrstcr_rpth_over,
        sfrstcr_test_over,
        sfrstcr_camp_over,
        sfrstcr_wait_bump_ind,
        sfrstcr_gmod_over,
        sfrstcr_cred_over,
        sfrstcr_bill_over,
        sfrstcr_minr_over,
        sfrstcr_user,
        sfrstcr_degc_over,
        sfrstcr_prog_over,
        sfrstcr_last_attend,
        sfrstcr_gcmt_code,
        sfrstcr_assess_activity_date,
        sfrstcr_data_origin,
        sfrstcr_dept_over,
        sfrstcr_atts_over,
        sfrstcr_chrt_over,
        sfrstcr_rmsg_cde,
        sfrstcr_wl_priority,
        sfrstcr_wl_priority_orig,
        sfrstcr_grde_code_incmp_final,
        sfrstcr_incomplete_ext_date,
        sfrstcr_mexc_over,
        sfrstcr_stsp_key_sequence,
        sfrstcr_brdh_seq_num,
        sfrstcr_blck_code,
        sfrstcr_surrogate_id,
        sfrstcr_version,
        sfrstcr_user_id,
        sfrstcr_vpdi_code,
        sfrstcr_strh_seqno,
        sfrstcr_strd_seqno,
        sfrstcr_sessionid,
        sfrstcr_current_time

    from source

)

select * from renamed
  );