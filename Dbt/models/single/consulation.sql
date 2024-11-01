{{
    config(
        alias= env_var('appointment_consultation')
)}}

Select *
from  {{ source('my_domain_appointment', 'consultation') }}
