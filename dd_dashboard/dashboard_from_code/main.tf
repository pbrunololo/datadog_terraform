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

# Example Free Layout
resource "datadog_dashboard" "free_dashboard" {
  title       = "Free Layout Dashboard by Terraform"
  description = "Created using the Datadog provider in Terraform"
  layout_type = "free"

  widget {
    event_timeline_definition {
      query       = "*"
      title       = "test_timeline" #Title
      title_size  = 16
      title_align = "left"
      live_span   = "1h"
    }
    widget_layout {
      height = 9
      width  = 66
      x      = 33
      y      = 60
    }
  }

  widget {
    free_text_definition {
      text       = "test_free_text"
      color      = "#d00"
      font_size  = "36"
      text_align = "left"
    }
    widget_layout {
      height = 20
      width  = 34
      x      = 33
      y      = 0
    }
  }

  widget {
    image_definition {
      url    = "https://static.datadoghq.com/static/images/logos/ceph_avatar.svg" # use url for image
      sizing = "fit"
      margin = "small"
    }
    widget_layout {
      height = 20
      width  = 30
      x      = 69
      y      = 0
    }
  }
  
  widget {
    manage_status_definition {
      color_preference    = "text"
      display_format      = "countsAndList"
      hide_zero_counts    = true
      query               = "tag:XXX" #use tag for alert list
      show_last_triggered = false
      sort                = "status,asc"
      summary_type        = "monitors"
      title               = "Widget Title" #Title
      title_size          = 16
      title_align         = "left"
    }
    widget_layout {
      height = 40
      width  = 30
      x      = 101
      y      = 48
    }
  }

  widget {
    trace_service_definition {
      display_format     = "three_column"
      env                = "none"
      service            = "XXXXX" #serviceAPM
      show_breakdown     = true
      show_distribution  = true
      show_errors        = true
      show_hits          = true
      show_latency       = false
      show_resource_list = false
      size_format        = "large"
      span_name          = "XXXXX.query" #SpanName service.query
      title              = "Test" #Title
      title_align        = "center"
      title_size         = "13"
      live_span          = "1h"
    }
    widget_layout {
      height = 38
      width  = 66
      x      = 33
      y      = 21
    }
  }

  widget {
    timeseries_definition {
      request {
        formula {
          formula_expression = "my_query_1 + my_query_2"
          alias              = "my ff query"
        }
        formula {
          formula_expression = "my_query_1 * my_query_2"
          limit {
            count = 5
            order = "desc"
          }
          alias = "my second ff query"
        }
        query {
          metric_query {
            data_source = "metrics"
            query       = "avg:system.cpu.user{env:production} by {host}" #query 1
            name        = "my_query_1"
            aggregator  = "sum"
          }
        }
        query {
          metric_query {
            query      = "avg:system.cpu.user{env:production} by {host}" #query 2
            name       = "my_query_2"
            aggregator = "sum"
          }
        }
      }
    }
    widget_layout {
      height = 16
      width  = 25
      x      = 58
      y      = 83
    }
  }
  widget {
    timeseries_definition {
      request {
        query {
          process_query {
            data_source       = "process"
            text_filter       = "abc"
            metric            = "process.stat.cpu.total_pct"
            limit             = 10
            tag_filters       = ["some_filter"]
            name              = "my_process_query"
            sort              = "asc"
            is_normalized_cpu = true
            aggregator        = "sum"
          }
        }
      }
    }
    widget_layout {
      height = 16
      width  = 28
      x      = 0
      y      = 83
    }
  }

  #MAIN VARIABLE Dashboard
  template_variable {
    name    = "var_1"
    prefix  = "host"
    default = "aws"
  }
  template_variable {
    name    = "var_2"
    prefix  = "service_name"
    default = "autoscaling"
  }

  template_variable_preset {
    name = "preset_1"
    template_variable {
      name  = "var_1"
      value = "host.dc"
    }
    template_variable {
      name  = "var_2"
      value = "my_service"
    }
  }
}