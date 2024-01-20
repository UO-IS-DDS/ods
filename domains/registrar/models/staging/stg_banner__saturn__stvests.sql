with source as (

    select * from {{ source('banner__saturn', 'stvests') }}

),

renamed as (

    select
        stvests_code,
        stvests_desc,
        stvests_eff_crse_stat,
        stvests_prev_reg,
        stvests_eff_headcount,
        stvests_activity_date,
        stvests_system_req_ind,
        stvests_wdrl_code_def,
        stvests_wd_ind,
        stvests_third_party_wd_ind,
        stvests_surrogate_id,
        stvests_version,
        stvests_user_id,
        stvests_data_origin,
        stvests_vpdi_code

    from source

)

select * from renamed