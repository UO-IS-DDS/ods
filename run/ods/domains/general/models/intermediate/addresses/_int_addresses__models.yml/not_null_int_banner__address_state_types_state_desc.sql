select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select state_desc
from "ods"."banner"."int_banner__address_state_types"
where state_desc is null



      
    ) dbt_internal_test