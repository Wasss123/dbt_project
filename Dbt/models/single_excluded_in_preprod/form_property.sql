{{
    config(
        alias= env_var('workflow_form_property')
)}}

Select *
from  {{ source('my_domain_workflow_dataset', 'form_property') }}
