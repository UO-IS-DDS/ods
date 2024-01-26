select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select address_line_1
from "ods"."banner"."dim_addresses"
where address_line_1 is null



      
    ) dbt_internal_test