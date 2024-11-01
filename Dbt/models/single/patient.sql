{{
    config(
        alias= env_var('appointment_patient')
)}}

Select *
from  {{ source('my_domain_appointment', 'patient') }}
