select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select address_type_code
from "ods"."banner"."int_banner__addresses__filtered_to_active"
where address_type_code is null



      
    ) dbt_internal_test