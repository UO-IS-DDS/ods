
  
    
    

    create  table
      "ods"."banner"."mart_persons__dbt_tmp"
  
    as (
      with banner_persons as (

  select * from "ods"."banner"."int_banner__entities__filtered_to__persons"

),

banner_person_details as (

  select * from "ods"."banner"."int_banner__person_details"

),

final as (
    
  select 
    
  -- banner_persons (driver)
  banner_persons."internal_banner_id",
  banner_persons."banner_id",
  banner_persons."legal_first_name",
  banner_persons."middle_initial",
  banner_persons."uo_email_address",
  banner_persons."uo_email_type_desc",
  banner_persons."ma_phone_area",
  banner_persons."ma_phone_number",
  banner_persons."ma_phone_ext",
  banner_persons."ma_intl_access",
  banner_persons."ma_phone_type_desc",
  banner_persons."pr_phone_area",
  banner_persons."pr_phone_number",
  banner_persons."pr_phone_ext",
  banner_persons."pr_intl_access",
  banner_persons."pr_phone_type_desc",
  banner_persons."ma_address_line_1",
  banner_persons."ma_address_line_2",
  banner_persons."ma_address_line_3",
  banner_persons."ma_city",
  banner_persons."ma_state_code",
  banner_persons."ma_state_desc",
  banner_persons."ma_zip_code",
  banner_persons."ma_nation_code",
  banner_persons."ma_nation_desc",
  banner_persons."pr_address_line_1",
  banner_persons."pr_address_line_2",
  banner_persons."pr_address_line_3",
  banner_persons."pr_city",
  banner_persons."pr_state_code",
  banner_persons."pr_state_desc",
  banner_persons."pr_zip_code",
  banner_persons."pr_nation_code",
  banner_persons."pr_nation_desc",
  banner_persons."last_name",
  -- banner_person_details
  banner_person_details."preferred_first_name",
  banner_person_details."is_confidential"

  from banner_persons
  left join banner_person_details
    on banner_person_details.internal_banner_id = 
              banner_persons.internal_banner_id
)

select *,
       md5(cast(coalesce(cast(internal_banner_id as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT))           as ods_surrogate_key 
from final
    );
  
  