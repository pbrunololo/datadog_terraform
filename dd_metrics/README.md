# Datadog and Terraform - Working with Metrics

## Index
* [Modify_Metric_Tag](#modifytags)
* [Extract_Metric_Type](#extractmetrictype)

## Modify_Metric_Tag

Il codice terraform composto da 

- main.tf
- outputs.tf 
- terraform.tfvars
- variables.tf

serve per settare un determinato TAG (nel nostro esempio metteremo "prova") ad una metrica specifica su Datadog.<br>
Questa operazione può incidere sull'indicizzazione delle custom metrics.<br>
Per eseguire correttamente la componente terraform, è propedeutico l'utilizzo dello script bash descritto di seguito.<br>

----

## Extract_Metric_Type

Nella cartella extract_Mtype è presente lo script bash "dd_extract_metadata_metrics.sh"<br>
Per utilizzare il codice terraform è necessario avere una lista di metriche di questo tipo : <br><br>
```
metric_name,metric_type
```
<br>
Lo script bash, utilizza l'api Datadog per estrarre la metric_type.<br>
L'estrazione parte da una lista, l'esempio è nella cartella file prova.txt.

----
