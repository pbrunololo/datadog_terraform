# Datadog and Terraform - Creating Dashboard

## Dashboard From Json

Il codice terraform nella cartella "dashboard_from_json" composto da 

- main.tf
- terraform.tfvars
- variables.tf

serve a creare in automatico una dashboard Datadog partendo da un json (estratto di una dashboard già esistente) di base <br>
Sono anche impostate delle variabili generali che vengono utilizzate nei widget <bn>

## Dashboard From Code

Il codice terraform nella cartella "dashboard_from_code" composto da 

- main.tf
- terraform.tfvars
- variables.tf

serve a creare in automatico una dashboard Datadog sfruttando la composizione della stessa tutta con codice HCL <br>
Sono anche impostate delle variabili generali che possono essere utilizzate nei widget <bn>
