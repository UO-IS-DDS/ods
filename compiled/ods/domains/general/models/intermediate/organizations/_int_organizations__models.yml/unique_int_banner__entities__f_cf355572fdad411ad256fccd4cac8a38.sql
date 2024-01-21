
    
    

select
    ods_surrogate_key as unique_field,
    count(*) as n_records

from "ods"."banner"."int_banner__entities__filtered_to__organizations"
where ods_surrogate_key is not null
group by ods_surrogate_key
having count(*) > 1


