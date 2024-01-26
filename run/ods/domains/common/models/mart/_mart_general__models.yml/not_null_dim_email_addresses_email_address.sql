select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select email_address
from "ods"."banner"."dim_email_addresses"
where email_address is null



      
    ) dbt_internal_test