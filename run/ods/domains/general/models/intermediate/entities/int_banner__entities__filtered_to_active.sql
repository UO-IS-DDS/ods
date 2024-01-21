
  
  create view "ods"."banner"."int_banner__entities__filtered_to_active__dbt_tmp" as (
    with banner_entities as (

  select * from "ods"."banner"."stg_banner__saturn__spriden"

),

filter_to_active as (

  select 
    
  -- banner_entities
  banner_entities."internal_banner_id",
  banner_entities."banner_id",
  banner_entities."organization_or_last_name",
  banner_entities."legal_first_name",
  banner_entities."middle_initial",
  banner_entities."is_person",
  banner_entities."updated_at"

  from banner_entities
  where change_ind = 'A'

),

-- unique_int_banner__entities__filter_to_active_banner_id
test_clean as (

  select *
  from filter_to_active
  -- failed test sql
  where not exists (
                    select 
                    
                           banner_id as unique_field,
                           count(*) as n_records
                           
                    from filter_to_active
                    where banner_id is not null
                    group by banner_id
                    having count(*) > 1
                   )
                     
)

select *,
       md5(cast(coalesce(cast(internal_banner_id as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT))           as ods_surrogate_key 
from test_clean
  );
