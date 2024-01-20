with source as (

    select * from {{ source('banner__saturn', 'stvcoll') }}

),

renamed as (

    select
        stvcoll_code,
        stvcoll_desc,
        stvcoll_addr_street_line1,
        stvcoll_addr_street_line2,
        stvcoll_addr_street_line3,
        stvcoll_addr_city,
        stvcoll_addr_state,
        stvcoll_addr_country,
        stvcoll_addr_zip_code,
        stvcoll_activity_date,
        stvcoll_system_req_ind,
        stvcoll_vr_msg_no,
        stvcoll_statscan_cde3,
        stvcoll_dicd_code,
        stvcoll_house_number,
        stvcoll_addr_street_line4,
        stvcoll_surrogate_id,
        stvcoll_version,
        stvcoll_user_id,
        stvcoll_data_origin,
        stvcoll_vpdi_code

    from source

)

select * from renamed