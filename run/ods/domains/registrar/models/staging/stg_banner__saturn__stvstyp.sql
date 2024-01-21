
  
  create view "ods"."banner"."stg_banner__saturn__stvstyp__dbt_tmp" as (
    with source as (

    select * from "ods"."banner"."stvstyp"

),

renamed as (

    select
        stvstyp_code,
        stvstyp_desc,
        stvstyp_next_status,
        stvstyp_activity_date,
        stvstyp_short_desc,
        stvstyp_reg_desc,
        stvstyp_system_req_ind,
        stvstyp_surrogate_id,
        stvstyp_version,
        stvstyp_user_id,
        stvstyp_data_origin,
        stvstyp_vpdi_code

    from source

)

select * from renamed
  );
