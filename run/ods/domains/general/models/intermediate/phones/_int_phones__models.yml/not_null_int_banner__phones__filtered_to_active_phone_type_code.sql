select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select phone_type_code
from "ods"."banner"."int_banner__phones__filtered_to_active"
where phone_type_code is null



      
    ) dbt_internal_test