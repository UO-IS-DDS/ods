
    
    

select
    ods_surrogate_key as unique_field,
    count(*) as n_records

from "ods"."banner"."con__registrar__student_data_report"
where ods_surrogate_key is not null
group by ods_surrogate_key
having count(*) > 1


