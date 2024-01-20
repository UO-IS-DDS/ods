with banner_major_types as (

    select * from {{ ref('stg_banner__saturn__stvmajr') }}

),

filter_to_minors as (
  
  select 
  
         {{ dbt_utils.star(from=ref('stg_banner__saturn__stvmajr'),
                           relation_alias='banner_major_types',
                           except=["major_code",
                                   "major_desc"]) }},
         major_code                                                  as minor_code,
         major_desc                                                  as minor_desc

  from banner_major_types
  where is_minor = 'Y'
)

select *,
       {{ dbt_utils.generate_surrogate_key(
            ['minor_code']) }}           as ods_surrogate_key
from filter_to_minors 
