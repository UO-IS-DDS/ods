select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select major_code
from "ods"."banner"."int_banner__stvmajr__filtered_to__majors"
where major_code is null



      
    ) dbt_internal_test