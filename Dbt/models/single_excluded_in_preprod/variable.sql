{{
    config(
        alias= env_var('workflow_variable')
)}}

Select *
from  {{ source('my_domain_workflow_dataset', 'variable') }}
