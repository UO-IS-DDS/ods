select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select nation_desc
from "ods"."banner"."int_banner__address_nation_types"
where nation_desc is null



      
    ) dbt_internal_test