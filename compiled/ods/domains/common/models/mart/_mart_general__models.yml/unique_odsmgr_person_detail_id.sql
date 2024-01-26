
    
    

select
    id as unique_field,
    count(*) as n_records

from "ods"."banner"."odsmgr_person_detail"
where id is not null
group by id
having count(*) > 1


