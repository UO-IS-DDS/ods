
  
  create view "ods"."banner"."stg_banner__saturn__stvatts__dbt_tmp" as (
    with source as (

    select * from "ods"."banner"."stvatts"

),

renamed as (

    select
        stvatts_code,
        stvatts_desc,
        stvatts_activity_date,
        stvatts_surrogate_id,
        stvatts_version,
        stvatts_user_id,
        stvatts_data_origin,
        stvatts_vpdi_code

    from source

)

select * from renamed
  );
