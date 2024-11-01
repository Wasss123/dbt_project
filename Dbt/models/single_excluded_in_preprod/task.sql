{{
    config(
        alias= env_var('workflow_task')
)}}

Select *
from  {{ source('my_domain_workflow_dataset', 'task') }}
