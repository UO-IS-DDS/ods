select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select nation_code
from "ods"."banner"."int_banner__address_nation_types"
where nation_code is null



      
    ) dbt_internal_test