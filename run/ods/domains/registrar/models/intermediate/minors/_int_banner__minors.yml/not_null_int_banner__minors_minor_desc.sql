select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select minor_desc
from "ods"."banner"."int_banner__minors"
where minor_desc is null



      
    ) dbt_internal_test