
    
    

select
    ods_surrogate_key as unique_field,
    count(*) as n_records

from "ods"."banner"."int_banner__entity__name__hist"
where ods_surrogate_key is not null
group by ods_surrogate_key
having count(*) > 1


