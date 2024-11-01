{{
    config(
        alias= env_var('appointment_appointment')
)}}

Select *
from  {{ source('my_domain_appointment', 'appointment') }}
