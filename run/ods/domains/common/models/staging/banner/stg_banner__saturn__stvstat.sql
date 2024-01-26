
  
  create view "ods"."banner"."stg_banner__saturn__stvstat__dbt_tmp" as (
    with source as (

    select * from "ods"."banner"."stvstat"

),

renamed as (

    select
    
        stvstat_code as state_code,
        stvstat_desc as state_desc

    from source

)

select * from renamed
-- Unsed Fields --
        /*
        stvstat_activity_date,
        stvstat_edi_equiv,
        stvstat_statscan_cde,
        stvstat_ipeds_cde,
        stvstat_surrogate_id,
        stvstat_version,
        stvstat_user_id,
        stvstat_data_origin,
        stvstat_vpdi_code,
        stvstat_scod_code_iso
        */
  );
