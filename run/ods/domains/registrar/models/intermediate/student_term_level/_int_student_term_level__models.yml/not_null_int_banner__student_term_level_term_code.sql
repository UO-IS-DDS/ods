select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select term_code
from "ods"."banner"."int_banner__student_term_level"
where term_code is null



      
    ) dbt_internal_test