with source as (

    select * from {{ source('banner__saturn', 'sgrchrt') }}

),

renamed as (

    select
        sgrchrt_pidm,
        sgrchrt_term_code_eff,
        sgrchrt_chrt_code,
        sgrchrt_active_ind,
        sgrchrt_crea_code,
        sgrchrt_activity_date,
        sgrchrt_stsp_key_sequence,
        sgrchrt_surrogate_id,
        sgrchrt_version,
        sgrchrt_user_id,
        sgrchrt_data_origin,
        sgrchrt_vpdi_code

    from source

)

select * from renamed