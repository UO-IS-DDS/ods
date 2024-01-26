with 

dim_person as (select * from "ods"."banner"."dim_persons"),

final as (
    
  select 
    
    -- dim_person (driver)
    internal_banner_id                    as person_uid,
    banner_id                             as "ID", 
    last_name                             as last_name,
    preferred_first_name                  as first_name,
    middle_initial                        as middle_initial,
    is_confidential                       as confidentiality_ind
 
  from dim_person

)

select *,
       md5(cast(coalesce(cast(ID as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT))             as ods_surrogate_key 
from final