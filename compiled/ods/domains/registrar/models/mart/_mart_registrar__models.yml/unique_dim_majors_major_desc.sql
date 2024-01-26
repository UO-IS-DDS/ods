
    
    

select
    major_desc as unique_field,
    count(*) as n_records

from "ods"."banner"."dim_majors"
where major_desc is not null
group by major_desc
having count(*) > 1


