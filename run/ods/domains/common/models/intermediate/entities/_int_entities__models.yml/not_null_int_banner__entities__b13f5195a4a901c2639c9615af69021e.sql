select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select organization_or_last_name
from "ods"."banner"."int_banner__entities__filtered_to_active"
where organization_or_last_name is null



      
    ) dbt_internal_test