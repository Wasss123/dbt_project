{{
    config(
        alias= env_var('workflow_user_operation')
)}}

Select *
from  {{ source('my_domain_workflow_dataset', 'user_operation') }}
