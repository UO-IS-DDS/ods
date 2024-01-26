
  
  create view "ods"."banner"."int_banner__entity__name__hist__dbt_tmp" as (
    with 

banner_entities        as (select * from "ods"."banner"."stg_banner__saturn__spriden"),

banner_active_entities as (select * from "ods"."banner"."int_banner__entities__filtered_to_active"),

banner_inactive_entity_names as (

  select * 
  from banner_entities
  where change_ind = 'N'

),

curr_and_hist_banner_entity_names as (

  select 
    
    'Y'                       as is_active,
    organization_or_last_name as organization_or_last_name,
    legal_first_name          as legal_first_name,
    middle_initial            as middle_initial,
    updated_at                as updated_at,
    internal_banner_id        as internal_banner_id,
    is_person                 as is_person

  from banner_active_entities

  union

  select 

    'N'                          as is_active,
    -- Inactive Banner entity names
    t1.organization_or_last_name as organization_or_last_name,
    t1.legal_first_name          as legal_first_name,
    t1.middle_initial            as middle_initial,
    t1.updated_at                as updated_at,
    -- Active Banner entity details
    t2.internal_banner_id        as internal_banner_id,
    t2.is_person                 as is_person

  from banner_inactive_entity_names t1
  join banner_active_entities   t2
    on t2.internal_banner_id = t1.internal_banner_id

),

-- unique_int_banner__entity_name__hist_ods_surrogate_key
test_clean as (
 
  select *
  from curr_and_hist_banner_entity_names
  -- failed test sql
  where not exists (
                    select 

                           organization_or_last_name,
                           legal_first_name,
                           middle_initial,
                           updated_at,
                           count(*) as n_records

                    from curr_and_hist_banner_entity_names
                    group by organization_or_last_name,
                             legal_first_name,
                             middle_initial,
                             updated_at
                    having count(*) > 1
                   )

)

select *,
       md5(cast(coalesce(cast(organization_or_last_name as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(legal_first_name as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(middle_initial as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(updated_at as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT))           as ods_surrogate_key 
from test_clean
  );
