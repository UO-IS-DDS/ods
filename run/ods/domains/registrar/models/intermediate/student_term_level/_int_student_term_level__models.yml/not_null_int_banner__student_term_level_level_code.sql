select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select level_code
from "ods"."banner"."int_banner__student_term_level"
where level_code is null



      
    ) dbt_internal_test