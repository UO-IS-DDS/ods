
    
    

select
    major_code as unique_field,
    count(*) as n_records

from "ods"."banner"."dim_majors"
where major_code is not null
group by major_code
having count(*) > 1


