
  
  create view "ods"."banner"."stg_banner__saturn__sfbetrm__dbt_tmp" as (
    with source as (

    select * from "ods"."banner"."sfbetrm"

),

renamed as (

    select
        sfbetrm_term_code,
        sfbetrm_pidm,
        sfbetrm_ests_code,
        sfbetrm_ests_date,
        sfbetrm_mhrs_over,
        sfbetrm_ar_ind,
        sfbetrm_assessment_date,
        sfbetrm_add_date,
        sfbetrm_activity_date,
        sfbetrm_rgre_code,
        sfbetrm_mhrs_over_pre,
        sfbetrm_tmst_code,
        sfbetrm_tmst_date,
        sfbetrm_tmst_maint_ind,
        sfbetrm_user,
        sfbetrm_refund_date,
        sfbetrm_initial_reg_date,
        sfbetrm_data_origin,
        sfbetrm_min_hrs,
        sfbetrm_minh_srce_cde,
        sfbetrm_maxh_srce_cde,
        sfbetrm_surrogate_id,
        sfbetrm_version,
        sfbetrm_user_id,
        sfbetrm_vpdi_code

    from source

)

select * from renamed
  );
