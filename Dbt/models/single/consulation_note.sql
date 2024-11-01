{{
    config(
        alias= env_var('appointment_consultation_notes')
)}}

Select *
from  {{ source('my_domain_appointment', 'consultation_notes') }}
