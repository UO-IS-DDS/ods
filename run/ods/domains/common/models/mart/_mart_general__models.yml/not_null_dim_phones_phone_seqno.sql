select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select phone_seqno
from "ods"."banner"."dim_phones"
where phone_seqno is null



      
    ) dbt_internal_test