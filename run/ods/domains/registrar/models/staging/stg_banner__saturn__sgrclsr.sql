
  
  create view "ods"."banner"."stg_banner__saturn__sgrclsr__dbt_tmp" as (
    with source as (

    select * from "ods"."banner"."sgrclsr"

),

renamed as (

    select
        sgrclsr_levl_code,
        sgrclsr_clas_code,
        sgrclsr_from_hours,
        sgrclsr_to_hours,
        sgrclsr_activity_date,
        sgrclsr_seq_no,
        sgrclsr_surrogate_id,
        sgrclsr_version,
        sgrclsr_user_id,
        sgrclsr_data_origin,
        sgrclsr_vpdi_code

    from source

)

select * from renamed
  );
