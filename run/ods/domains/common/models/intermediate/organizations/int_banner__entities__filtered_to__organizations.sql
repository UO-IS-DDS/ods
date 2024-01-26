
  
  create view "ods"."banner"."int_banner__entities__filtered_to__organizations__dbt_tmp" as (
    with banner__active_entities as (

  select * from "ods"."banner"."dim_entities"

),

filter_to_organization as (

  select 
        
  -- banner__active_entities
  banner__active_entities."internal_banner_id",
  banner__active_entities."banner_id",
  banner__active_entities."uo_email_address",
  banner__active_entities."uo_email_type_desc",
  banner__active_entities."ma_phone_area",
  banner__active_entities."ma_phone_number",
  banner__active_entities."ma_phone_ext",
  banner__active_entities."ma_intl_access",
  banner__active_entities."ma_phone_type_desc",
  banner__active_entities."pr_phone_area",
  banner__active_entities."pr_phone_number",
  banner__active_entities."pr_phone_ext",
  banner__active_entities."pr_intl_access",
  banner__active_entities."pr_phone_type_desc",
  banner__active_entities."ma_address_line_1",
  banner__active_entities."ma_address_line_2",
  banner__active_entities."ma_address_line_3",
  banner__active_entities."ma_city",
  banner__active_entities."ma_state_code",
  banner__active_entities."ma_state_desc",
  banner__active_entities."ma_zip_code",
  banner__active_entities."ma_nation_code",
  banner__active_entities."ma_nation_desc",
  banner__active_entities."pr_address_line_1",
  banner__active_entities."pr_address_line_2",
  banner__active_entities."pr_address_line_3",
  banner__active_entities."pr_city",
  banner__active_entities."pr_state_code",
  banner__active_entities."pr_state_desc",
  banner__active_entities."pr_zip_code",
  banner__active_entities."pr_nation_code",
  banner__active_entities."pr_nation_desc",
  banner__active_entities.organization_or_last_name as organization_name
    
  from banner__active_entities
  where is_person = 'N'

)

select *,
       md5(cast(coalesce(cast(internal_banner_id as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT))           as ods_surrogate_key 
from filter_to_organization
  );
