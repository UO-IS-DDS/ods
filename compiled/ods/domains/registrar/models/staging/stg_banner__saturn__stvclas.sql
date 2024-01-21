with source as (

    select * from "ods"."banner"."stvclas"

),

renamed as (

    select
        stvclas_code,
        stvclas_desc,
        stvclas_activity_date,
        stvclas_edi_equiv,
        stvclas_lms_equiv,
        stvclas_nsc_class_cde,
        stvclas_surrogate_id,
        stvclas_version,
        stvclas_user_id,
        stvclas_data_origin,
        stvclas_vpdi_code

    from source

)

select * from renamed