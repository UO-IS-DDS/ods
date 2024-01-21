select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select organization_name
from "ods"."banner"."int_banner__entities__filtered_to__organizations"
where organization_name is null



      
    ) dbt_internal_test