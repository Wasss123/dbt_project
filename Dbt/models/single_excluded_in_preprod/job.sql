{{
    config(
        alias= env_var('workflow_job')
)}}

Select *
from  {{ source('my_domain_workflow_dataset', 'job') }}
