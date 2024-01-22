
  
  create view "ods"."banner"."cln_banner__saturn__spriden__dbt_tmp" as (
    with source as (

  select * from "ods"."banner"."stg_banner__saturn__spriden"

)

-- unique_int_banner__entities__filter_to_active_banner_id
  select *
  from source
  -- failed test sql
  where not exists (
                    select 
                    
                           banner_id as unique_field,
                           count(*) as n_records
                           
                    from source
                    where banner_id is not null
                    group by banner_id
                    having count(*) > 1
                   )
  );
