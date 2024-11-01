{{
    config(
        alias= env_var('appointment_availability_slots')
)}}

Select *
from  {{ source('my_domain_appointment', 'availability_slots') }}
