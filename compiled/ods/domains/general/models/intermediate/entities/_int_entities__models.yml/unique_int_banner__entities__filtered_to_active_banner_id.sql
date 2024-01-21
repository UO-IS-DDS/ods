
    
    

select
    banner_id as unique_field,
    count(*) as n_records

from "ods"."banner"."int_banner__entities__filtered_to_active"
where banner_id is not null
group by banner_id
having count(*) > 1


