
    
    

select
    banner_id as unique_field,
    count(*) as n_records

from "ods"."banner"."mart_persons"
where banner_id is not null
group by banner_id
having count(*) > 1


