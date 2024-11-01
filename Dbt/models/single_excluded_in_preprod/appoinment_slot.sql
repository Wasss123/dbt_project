{{
    config(
        alias= env_var('appointment_stg_appointment_slots')
)}}

Select *
from  {{ source('my_domain_appointment', 'stg_appointment_slots') }}
