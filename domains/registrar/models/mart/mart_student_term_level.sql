with banner_student_term_level as (

  select * from {{ ref('int_banner__student_term_level') }}

),


final as (
    
  select 
    
    -- banner_student_term_level (driver)
    {{ dbt_utils.star(from=ref('int_banner__student_term_level'),
                    relation_alias='banner_student_term_level',
                    except=["ods_surrogate_key"]) }}
 
  from banner_student_term_level

)

select *,
       {{ dbt_utils.generate_surrogate_key(
            ['internal_banner_id',
             'term_code',
             'level_code']) }}           as ods_surrogate_key 
from final