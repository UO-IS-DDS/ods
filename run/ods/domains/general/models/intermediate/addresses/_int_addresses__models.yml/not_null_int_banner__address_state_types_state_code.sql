select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select state_code
from "ods"."banner"."int_banner__address_state_types"
where state_code is null



      
    ) dbt_internal_test