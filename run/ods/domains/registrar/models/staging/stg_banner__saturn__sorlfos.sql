
  
  create view "ods"."banner"."stg_banner__saturn__sorlfos__dbt_tmp" as (
    with source as (

    select * from "ods"."banner"."sorlfos"

),

renamed as (

    select
        sorlfos_pidm,
        sorlfos_lcur_seqno,
        sorlfos_seqno,
        sorlfos_lfst_code,
        sorlfos_term_code,
        sorlfos_priority_no,
        sorlfos_csts_code,
        sorlfos_cact_code,
        sorlfos_data_origin,
        sorlfos_user_id,
        sorlfos_activity_date,
        sorlfos_majr_code,
        sorlfos_term_code_ctlg,
        sorlfos_term_code_end,
        sorlfos_dept_code,
        sorlfos_majr_code_attach,
        sorlfos_lfos_rule,
        sorlfos_conc_attach_rule,
        sorlfos_start_date,
        sorlfos_end_date,
        sorlfos_tmst_code,
        sorlfos_rolled_seqno,
        sorlfos_user_id_update,
        sorlfos_activity_date_update,
        sorlfos_current_cde,
        sorlfos_surrogate_id,
        sorlfos_version,
        sorlfos_vpdi_code

    from source

)

select * from renamed
  );
