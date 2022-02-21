# Datadog Terraform Metrics
## Extract Metric Type

## Index
* [Modify_Metric_Tag](#modifytags)
* [Extract_Metric_Type](#extractmetrictype)

## Modify_Metric_Tag

Il seguente codice terraform, serve per settare i TAG ad una metrica specifica.
<br>

----

## Extract_Metric_Type

Nella cartella extract_Mtype è presente lo script bash "dd_extract_metadata_metrics.sh"<br>
Per utilizzare il codice terraform è necessario avere una lista di questo tipo : <br><br>
```
metric_name,metric_type
```
<br>
Lo script bash, utilizza l'api Datadog per estrarre la metric_type.

----
