
    
    

select
    internal_banner_id as unique_field,
    count(*) as n_records

from "ods"."banner"."mart_entities"
where internal_banner_id is not null
group by internal_banner_id
having count(*) > 1


