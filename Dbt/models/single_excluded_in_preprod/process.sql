{{
    config(
        alias= env_var('workflow_process')
)}}

Select *
from  {{ source('my_domain_workflow_dataset', 'process') }}
