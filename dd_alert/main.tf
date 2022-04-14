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
  api_url = "https://api.datadoghq.eu/" #.eu Europe / .com Us and other
}

# Create a new Datadog monitor
resource "datadog_monitor" "pb_test_monitor" {
  name               = "PB_Monitor_Test"
  type               = "metric alert"
  message            = "Monitor triggered. Notify: @paolo1.bruno@posteitaliane.it "
  escalation_message = "Escalation message"

  query = "sum(last_5m):avg:azure.datafactory_factories.pipeline_failed_runs{subscription_name:poste-corporate-produzione,resource_group:deploydashboard-prod-rg,name:pdepdasetladf01azwe,name:vol_digital_synapseextractor} by {name}.as_count() > 1"

  monitor_thresholds {
    critical          = 1
    critical_recovery = 0
  }

  notify_no_data    = false
  renotify_interval = 60
  tags              = ["provaPB"]
}