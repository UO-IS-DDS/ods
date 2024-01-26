select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select email_type_desc
from "ods"."banner"."int_banner__email_address_types"
where email_type_desc is null



      
    ) dbt_internal_test