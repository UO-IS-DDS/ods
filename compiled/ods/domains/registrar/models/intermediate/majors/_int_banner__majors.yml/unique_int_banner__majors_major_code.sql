
    
    

select
    major_code as unique_field,
    count(*) as n_records

from "ods"."banner"."int_banner__majors"
where major_code is not null
group by major_code
having count(*) > 1


