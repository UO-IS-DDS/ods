select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select address_seqno
from "ods"."banner"."dim_addresses"
where address_seqno is null



      
    ) dbt_internal_test