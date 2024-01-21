select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select address_type_desc
from "ods"."banner"."int_banner__address_types"
where address_type_desc is null



      
    ) dbt_internal_test