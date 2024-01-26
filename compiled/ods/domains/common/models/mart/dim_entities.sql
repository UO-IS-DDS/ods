with 

banner_entities         as (select * from "ods"."banner"."int_banner__entities__filtered_to_active"),

banner_entity_emails    as (select * from "ods"."banner"."int_banner__email_addresses__pivoted_to__entities"),

banner_entity_phones    as (select * from "ods"."banner"."int_banner__phones__pivoted_to__entities"),

banner_entity_addresses as (select * from "ods"."banner"."int_banner__addresses__pivoted_to__entities"),

final as (
    
  select 
    
  -- banner_entities (driver)
  banner_entities."internal_banner_id",
  banner_entities."banner_id",
  banner_entities."organization_or_last_name",
  banner_entities."legal_first_name",
  banner_entities."middle_initial",
  banner_entities."is_person",
  -- banner_entity_emails
  banner_entity_emails."uo_email_address",
  banner_entity_emails."uo_email_type_desc",

  -- banner_entity_phones
  banner_entity_phones."ma_phone_area",
  banner_entity_phones."ma_phone_number",
  banner_entity_phones."ma_phone_ext",
  banner_entity_phones."ma_intl_access",
  banner_entity_phones."ma_phone_type_desc",
  banner_entity_phones."pr_phone_area",
  banner_entity_phones."pr_phone_number",
  banner_entity_phones."pr_phone_ext",
  banner_entity_phones."pr_intl_access",
  banner_entity_phones."pr_phone_type_desc",

  -- banner_entity_addresses
  banner_entity_addresses."ma_address_line_1",
  banner_entity_addresses."ma_address_line_2",
  banner_entity_addresses."ma_address_line_3",
  banner_entity_addresses."ma_city",
  banner_entity_addresses."ma_state_code",
  banner_entity_addresses."ma_state_desc",
  banner_entity_addresses."ma_zip_code",
  banner_entity_addresses."ma_nation_code",
  banner_entity_addresses."ma_nation_desc",
  banner_entity_addresses."pr_address_line_1",
  banner_entity_addresses."pr_address_line_2",
  banner_entity_addresses."pr_address_line_3",
  banner_entity_addresses."pr_city",
  banner_entity_addresses."pr_state_code",
  banner_entity_addresses."pr_state_desc",
  banner_entity_addresses."pr_zip_code",
  banner_entity_addresses."pr_nation_code",
  banner_entity_addresses."pr_nation_desc"


  from banner_entities
  left join banner_entity_emails
    on banner_entities.internal_banner_id = 
       banner_entity_emails.internal_banner_id
  left join banner_entity_phones
    on banner_entities.internal_banner_id = 
       banner_entity_phones.internal_banner_id
  left join banner_entity_addresses
    on banner_entities.internal_banner_id = 
       banner_entity_addresses.internal_banner_id
)

select *,
       md5(cast(coalesce(cast(internal_banner_id as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT))           as ods_surrogate_key 
from final