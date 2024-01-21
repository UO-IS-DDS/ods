with banner_address_nation_types as (

    select * from "ods"."banner"."stg_banner__saturn__stvnatn"

)

select *,
       md5(cast(coalesce(cast(nation_code as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT))           as ods_surrogate_key
from banner_address_nation_types