select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select ods_surrogate_key
from "ods"."banner"."int_banner__entities__filtered_to__persons"
where ods_surrogate_key is null



      
    ) dbt_internal_test