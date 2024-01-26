select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select email_type_code
from "ods"."banner"."dim_email_addresses"
where email_type_code is null



      
    ) dbt_internal_test