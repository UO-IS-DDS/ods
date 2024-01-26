
    
    

select
    ID as unique_field,
    count(*) as n_records

from "ods"."banner"."odsmgr_person_address_uo"
where ID is not null
group by ID
having count(*) > 1


