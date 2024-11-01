# README

Questions response : 

### What are each of the files for?

| file | role |
| ------ | ------ |
| models | Folder that contians 3 folders each have model sql file that will run a sql query to google BigQuery |
| schema.yml | A yml file containing source declaration this file use used to determine the source table from source GCP project and BigQuery dataset  |
| m0_report.sql | This .sql file contains the query to be run in BQ, it compiles the jinja {{ source('source.name', 'source.table.name') }}  from  the schema.yml file to get the source table exemple 'my-dev-239410.my_domain_workflow.transactions'. This SQL query is the union of all transactions and all refunded transactions  |
|  m1_report.sql | Same as m0_report.sql THIS SQL query is the union of all transactions detaiils and all refunded transactions details |
| default | Sames as previous .sql file and it copies the table from the source and it gives it a name other then the default name which is taken from the 'DBT_TGT_TABLE_NAME' argument |
| dbt_command_loop.sh | This file is a script that takes two arguments : the first argument is a yml file like the table_config.yml or preprod_table.yml and the second argument is the environment like "preprod" or "prod" ...  This files parses the lines in the first argument to get the model name folder and other dbt arguments and then executes "the dbt run" command in the spicific environment using the parsed dbt arguments |
| dbt_project | This yml file in the project configuration file to run dbt it is mandatory and important information such as the dbt project name, the profile to use,  paths to other directories such as models,data, spanshots, seed.It informs on the way to transform data for exemple in our uses case tables that will be created will be materialized as tables in BigQuery( could be views or materilized view in other uses cases )   |
| manifes.yml | This files contains information about regions, the scheduling of dbt runs which is every day 10am, sla and many other information about each enviroment such as the source and taget GCP project, service accounts and its credentials, paths to the script "dbt_command_loop.sh" file and paths to "table_config.yml" or "preprod_table_config.yml"  files that will be used as argument to script  and  slack channels for sending notifications, ensuring that team members are informed about pipeline executions and issues. |
| table_config.yml | yml file that contains multiple information that will be parsed by the "dbt_command_loop.sh" script to get information that will be used to run the dbt run command. This file contains the models folder name ( "m0_report" or "m1_reprot" or "single" ) that will be mentionned after --models argument in dbt command. It also contains informations that will be run along with the create_dbt_cmd function in the sciprt file which are information about sources, targets of  gcp projects, datasets and tables and will be used mainly in schema.yml file and models |
| preprod_table_config.yml | Same as table_config |
### How to run this project and what results we expect.


The presence of the manifest file indicates the manner of executing the "dbt_command_loop.sh" script. It containsthe paths to the script and the table config file, the environment to use as well as other information such as the schedule and src and target projects.
The main way to run this file is to use manifest.yml file in way to execute the "dbt_command_loop.sh" script with two arguments : the first is the table_config path and the second one is the environement 
###### Expemple
```sh
./path/to/dbt_command_loop.sh /path/to/table_config.yml preprod
```
This depends if we are running locally or in Google Cloud. If it is local execution it's just about running the script as mentionned in the exemple and if it's GCP managed several ways can be use such Airflow dags on Cloud Composer or compute engine with cloud scheduler.

The script should execute DBT commands for all specified models, creating tables in the target schema in BigQuery in specific environement ( dev-uk , preprod-ca or prod-ca ) . It should also handle errors, reporting how many commands failed if any did. 
It will actually copy table from "GCP_source_project.my_domain_workflow" and "GCP_source_project.my_domain_appointment" using default model in single directory and "GCP_source_project.event" using m0_report and m1_report datasets to the "GCP_target_project.my_operatianal" dataset.

### List some of this solution's design problems and compare to dbt projects best practices.
##### Design Problems:
###### Complexity of Configuration Management:
With multiple configuration files (e.g., table_config.yml, preprod_table_config.yml), managing changes across environments can be error-prone and cumbersome.
###### Separation of Logic:
Running each model as a separate project may lead to duplicated logic and configurations
###### Error Handling: 
The error handling approach in the shell script may not provide detailed context for failures, making debugging more challenging.

##### Comparison to DBT Best Practices:

 DBT best practices recommend keeping models within a single project to facilitate better management and reduce configuration duplication. This approach also enhances collaboration and code sharing.
The use of testing and documentation is emphasized in best practices, which seems to be underrepresented in this structure.
Streamlining configurations into a more modular structure within a single DBT project is favored over separate projects.

### This project runs every model as a separated dbt project.  
Provide an alternative solution to put everything in one single dbt project that can handle all the environments(targets) and all models.
You don't need to run it, just provide a new repo containing the new solution's code.  
Provid your analysis and suggestions if there are many ways to achieve the same results.

Please see attached my code. I can optimize it using macros
Here I used one single project. I configured the "profile.yml" file so that we can mention the target dataset and GCP project and I configured the "dbt_project.yml" file to handle environements and to exclude models in case of using preprod_ca enviroement(not all table are used in the ancient preprod_table_config.yml). 
Finally I implimented the models folder with the well configured sources and the models with their yml files. 


Feel free to reach to, I will be glad to discuss my work