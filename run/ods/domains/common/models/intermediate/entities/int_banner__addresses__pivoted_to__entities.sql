
  
  create view "ods"."banner"."int_banner__addresses__pivoted_to__entities__dbt_tmp" as (
    with banner__addresses as (

  select * from "ods"."banner"."dim_addresses"

),-- ^ Add more as requested
addresses__pivoted_to_entity as (

  select

    internal_banner_id,
    max(case when address_type_code = upper('ma') then address_line_1 end) as ma_address_line_1,
      max(case when address_type_code = upper('ma') then address_line_2 end) as ma_address_line_2,
      max(case when address_type_code = upper('ma') then address_line_3 end) as ma_address_line_3,
      max(case when address_type_code = upper('ma') then city end) as ma_city,
      max(case when address_type_code = upper('ma') then state_code end) as ma_state_code,
      max(case when address_type_code = upper('ma') then state_desc end) as ma_state_desc,
      max(case when address_type_code = upper('ma') then zip_code end) as ma_zip_code,
      max(case when address_type_code = upper('ma') then nation_code end) as ma_nation_code,
      max(case when address_type_code = upper('ma') then nation_desc end) as ma_nation_desc,max(case when address_type_code = upper('pr') then address_line_1 end) as pr_address_line_1,
      max(case when address_type_code = upper('pr') then address_line_2 end) as pr_address_line_2,
      max(case when address_type_code = upper('pr') then address_line_3 end) as pr_address_line_3,
      max(case when address_type_code = upper('pr') then city end) as pr_city,
      max(case when address_type_code = upper('pr') then state_code end) as pr_state_code,
      max(case when address_type_code = upper('pr') then state_desc end) as pr_state_desc,
      max(case when address_type_code = upper('pr') then zip_code end) as pr_zip_code,
      max(case when address_type_code = upper('pr') then nation_code end) as pr_nation_code,
      max(case when address_type_code = upper('pr') then nation_desc end) as pr_nation_desc

  from banner__addresses t1
  where address_seqno = (
                          select max(t2.address_seqno)
                          from banner__addresses t2
                          where t2.internal_banner_id = t1.internal_banner_id
                            and t2.address_type_code = t1.address_type_code
                        )
  group by internal_banner_id

)

select *,
       md5(cast(coalesce(cast(internal_banner_id as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT))           as ods_surrogate_key 
from addresses__pivoted_to_entity
  );
