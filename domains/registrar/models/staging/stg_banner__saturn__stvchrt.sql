with source as (

    select * from {{ source('banner__saturn', 'stvchrt') }}

),

renamed as (

    select
        stvchrt_code,
        stvchrt_desc,
        stvchrt_term_code_start,
        stvchrt_term_code_end,
        stvchrt_dlev_code,
        stvchrt_activity_date,
        stvchrt_right_ind,
        stvchrt_surrogate_id,
        stvchrt_version,
        stvchrt_user_id,
        stvchrt_data_origin,
        stvchrt_vpdi_code,
        stvchrt_term_code_100prcnt

    from source

)

select * from renamed