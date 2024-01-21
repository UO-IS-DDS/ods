with source as (

    select * from "ods"."banner"."stvterm"

),

renamed as (

    select
        stvterm_code,
        stvterm_desc,
        stvterm_start_date,
        stvterm_end_date,
        stvterm_fa_proc_yr,
        stvterm_activity_date,
        stvterm_fa_term,
        stvterm_fa_period,
        stvterm_fa_end_period,
        stvterm_acyr_code,
        stvterm_housing_start_date,
        stvterm_housing_end_date,
        stvterm_short_desc,
        stvterm_system_req_ind,
        stvterm_trmt_code,
        stvterm_fa_summer_ind,
        stvterm_surrogate_id,
        stvterm_version,
        stvterm_user_id,
        stvterm_data_origin,
        stvterm_vpdi_code,
        stvterm_apport_cde,
        stvterm_mis_term_ctg,
        stvterm_mis_term_id,
        stvterm_term_len_mult,
        stvterm_term_len_mult_is

    from source

)

select * from renamed