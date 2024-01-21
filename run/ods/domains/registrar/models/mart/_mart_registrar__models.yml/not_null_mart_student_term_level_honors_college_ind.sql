select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select honors_college_ind
from "ods"."banner"."mart_student_term_level"
where honors_college_ind is null



      
    ) dbt_internal_test