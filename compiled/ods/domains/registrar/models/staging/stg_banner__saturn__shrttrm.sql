with source as (

    select * from "ods"."banner"."shrttrm"

),

renamed as (

    select
        shrttrm_pidm,
        shrttrm_term_code,
        shrttrm_update_source_ind,
        shrttrm_pre_catalog_ind,
        shrttrm_record_status_ind,
        shrttrm_record_status_date,
        shrttrm_grade_mailing_date,
        shrttrm_grade_mailer_chg_date,
        shrttrm_grade_mailer_dup,
        shrttrm_grade_mailer_dup_date,
        shrttrm_exam_code,
        shrttrm_code_transcript_dist,
        shrttrm_astd_code_end_of_term,
        shrttrm_astd_date_end_of_term,
        shrttrm_activity_date,
        shrttrm_astd_code_dl,
        shrttrm_astd_date_dl,
        shrttrm_wrsn_code,
        shrttrm_sbgi_code_trans,
        shrttrm_prev_code,
        shrttrm_prev_date,
        shrttrm_cast_code,
        shrttrm_cast_date,
        shrttrm_scps_code,
        shrttrm_surrogate_id,
        shrttrm_version,
        shrttrm_user_id,
        shrttrm_data_origin,
        shrttrm_vpdi_code

    from source

)

select * from renamed