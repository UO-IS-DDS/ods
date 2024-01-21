
    
    

select
    ods_surrogate_key as unique_field,
    count(*) as n_records

from "ods"."banner"."int_banner__addresses__filtered_to_active"
where ods_surrogate_key is not null
group by ods_surrogate_key
having count(*) > 1


