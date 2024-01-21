select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select updated_at
from "ods"."banner"."int_banner__addresses__filtered_to_active"
where updated_at is null



      
    ) dbt_internal_test