
    
    

select
    person_uid as unique_field,
    count(*) as n_records

from "ods"."banner"."odsmgr_person_detail"
where person_uid is not null
group by person_uid
having count(*) > 1


