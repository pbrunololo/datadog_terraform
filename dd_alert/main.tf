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
resource "datadog_monitor" "test_monitor" {
  name               = "Monitor_Test"
  type               = "metric alert"
  message            = "Monitor triggered. Notify: @prova@test.com " #insert valide mail address
  escalation_message = "Escalation message"

# This example for cpu_usage from env:test groupby name > 1
  query = "sum(last_5m):avg:system.cpu.user{env:test} by {name}.as_count() > 1"

  monitor_thresholds {
    critical          = 1
    critical_recovery = 0
  }

  notify_no_data    = false
  renotify_interval = 60
  tags              = ["prova","test"] #list of tag
}