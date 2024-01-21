
  
  create view "ods"."banner"."stg_banner__saturn__sgvadvr__dbt_tmp" as (
    with source as (

    select * from "ods"."banner"."sgradvr"

),

renamed as (

    select
        sgradvr_pidm,
        sgradvr_term_code_eff,
        sgradvr_advr_pidm,
        sgradvr_advr_code,
        sgradvr_prim_ind,
        sgradvr_activity_date,
        sgradvr_surrogate_id,
        sgradvr_version,
        sgradvr_user_id,
        sgradvr_data_origin,
        sgradvr_vpdi_code

    from source

)

select * from renamed
  );
