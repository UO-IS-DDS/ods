select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select email_address
from "ods"."banner"."int_banner__email_addresses__filtered_to_active"
where email_address is null



      
    ) dbt_internal_test