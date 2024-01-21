
  
  create view "ods"."banner"."stg_banner__saturn__stvmajr__dbt_tmp" as (
    with source as (

    select * from "ods"."banner"."stvmajr"

),

renamed as (

    select
        stvmajr_code                           as major_code,
        stvmajr_desc                           as major_desc,
        stvmajr_dept_code                      as dept_code,
        coalesce(stvmajr_valid_major_ind, 'N') as is_major,
        coalesce(stvmajr_valid_minor_ind, 'N') as is_minor

    from source

)

select * from renamed
-- Unused Fields --
        /*
        stvmajr_cipc_code,
        stvmajr_valid_concentratn_ind,
        stvmajr_activity_date,
        stvmajr_occupation_ind,
        stvmajr_disc_prg,
        stvmajr_aid_eligibility_ind,
        stvmajr_system_req_ind,
        stvmajr_vr_msg_no,
        stvmajr_disp_web_ind,
        stvmajr_program,
        stvmajr_sevis_equiv,
        stvmajr_surrogate_id,
        stvmajr_version,
        stvmajr_user_id,
        stvmajr_data_origin,
        stvmajr_vpdi_code,
        stvmajr_tops_code
        */
  );
