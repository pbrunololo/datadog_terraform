#Terraform 0.13+ uses the Terraform Registry:

terraform {
  required_providers {
    datadog = {
      source = "DataDog/datadog"
    }
  }
}

#Configure the Datadog provider
provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
  api_url = "https://api.datadoghq.eu/"
}

# Manage tag configurations for a Datadog count or gauge metric
resource "datadog_metric_tag_configuration" "dd_metric" {
  metric_name = var.datadog_metrics_name
  metric_type = "count"
  tags        = ["prova"]
}
