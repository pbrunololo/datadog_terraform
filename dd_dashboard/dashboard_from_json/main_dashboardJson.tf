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

# Example Dashboard JSON
resource "datadog_dashboard_json" "dashboard_json" {
  dashboard = <<EOF
{
	"title": "Decoder - Overall from IaC",
	"description": "",
	"widgets": [
		{
			"id": 0,
			"layout": {
				"x": 0,
				"y": 0,
				"width": 12,
				"height": 12
			},
			"definition": {
				"type": "image",
				"url": "",
				"sizing": "contain",
				"margin": "md",
				"has_background": false,
				"has_border": false,
				"vertical_align": "center",
				"horizontal_align": "center"
			}
		},
		{
			"id": 3,
			"layout": {
				"x": 16,
				"y": 59,
				"width": 33,
				"height": 5
			},
			"definition": {
				"type": "free_text",
				"text": "SQL DB - Reportistica",
				"color": "#4d4d4d",
				"font_size": "auto",
				"text_align": "left"
			}
		},
		{
			"id": 4,
			"layout": {
				"x": 216,
				"y": 0,
				"width": 24,
				"height": 6
			},
			"definition": {
				"type": "free_text",
				"text": "Blob Storage",
				"color": "#4d4d4d",
				"font_size": "auto",
				"text_align": "left"
			}
		},
		{
			"id": 6,
			"layout": {
				"x": 0,
				"y": 74,
				"width": 50,
				"height": 19
			},
			"definition": {
				"title": " SQL DB Status ",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "avg:azure.sql_servers_databases.status{$subscription_name,$rg_decoder_reports} by {name}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 7,
			"layout": {
				"x": 0,
				"y": 94,
				"width": 50,
				"height": 21
			},
			"definition": {
				"title": "SQL DB Connection Successful",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "anomalies(query1, 'basic', 2)"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "avg:azure.sql_servers_databases.connection_successful{$subscription_name,$rg_decoder_reports}.as_count()",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 9,
			"layout": {
				"x": 0,
				"y": 116,
				"width": 50,
				"height": 19
			},
			"definition": {
				"title": "SQL DB Connection failed",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "sum:azure.sql_servers_databases.connection_failed{$subscription_name,$rg_decoder_reports} by {name}.as_count()",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 13,
			"layout": {
				"x": 0,
				"y": 220,
				"width": 50,
				"height": 21
			},
			"definition": {
				"title": "SQL -Server Storage %",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "avg:azure.sql_servers_databases.storage_percent{$subscription_name,$rg_decoder_reports} by {server_name}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 14,
			"layout": {
				"x": 0,
				"y": 178,
				"width": 50,
				"height": 19
			},
			"definition": {
				"title": "SQL- Server Log Writes",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "avg:azure.sql_servers_databases.log_write_percent{$subscription_name,$rg_decoder_reports} by {name}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 15,
			"layout": {
				"x": 216,
				"y": 129,
				"width": 48,
				"height": 22
			},
			"definition": {
				"title": "Blob Capacity by SA",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_size": "0",
				"type": "timeseries",
				"requests": [
					{
						"q": "sum:azure.storage_storageaccounts_blobservices.blob_capacity{$subscription_name AND $rg_decoder_ext OR $rg_decoder_int} by {name}",
						"metadata": [
							{
								"expression": "sum:azure.storage_storageaccounts_blobservices.blob_capacity{$subscription_name AND $res_inoc OR $res_book} by {name}",
								"alias_name": "Bytes"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 16,
			"layout": {
				"x": 216,
				"y": 106,
				"width": 48,
				"height": 22
			},
			"definition": {
				"title": "Transaction Requests by SA",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_size": "0",
				"type": "timeseries",
				"requests": [
					{
						"q": "sum:azure.storage_storageaccounts_blobservices.transactions{$subscription_name AND $rg_decoder_ext OR $rg_decoder_int} by {name}.as_count()",
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "bars"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 17,
			"layout": {
				"x": 216,
				"y": 33,
				"width": 48,
				"height": 25
			},
			"definition": {
				"title": "Successful end to end Latency by SA",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_size": "0",
				"type": "timeseries",
				"requests": [
					{
						"q": "avg:azure.storage_storageaccounts_blobservices.success_e2_e_latency{$subscription_name AND $rg_decoder_ext OR $rg_decoder_int} by {name}",
						"metadata": [
							{
								"expression": "avg:azure.storage_storageaccounts_blobservices.success_e2_e_latency{$subscription_name AND $res_inoc OR $res_book} by {name}",
								"alias_name": "Latency"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 18,
			"layout": {
				"x": 216,
				"y": 7,
				"width": 48,
				"height": 25
			},
			"definition": {
				"title": "Availability by SA",
				"title_size": "16",
				"title_align": "left",
				"time": {
					"live_span": "4h"
				},
				"type": "toplist",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1",
								"limit": {
									"count": 10,
									"order": "asc"
								}
							}
						],
						"response_format": "scalar",
						"queries": [
							{
								"query": "avg:azure.storage_storageaccounts_blobservices.availability{$subscription_name AND ($rg_decoder_ext OR $rg_decoder_int)} by {name}",
								"data_source": "metrics",
								"name": "query1",
								"aggregator": "avg"
							}
						]
					}
				]
			}
		},
		{
			"id": 44,
			"layout": {
				"x": 0,
				"y": 65,
				"width": 24,
				"height": 8
			},
			"definition": {
				"title": "SQL DB Successful connections",
				"title_size": "16",
				"title_align": "left",
				"type": "query_value",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1"
							}
						],
						"response_format": "scalar",
						"queries": [
							{
								"query": "sum:azure.sql_servers_databases.connection_successful{$subscription_name,$rg_decoder_reports}.as_count()",
								"data_source": "metrics",
								"name": "query1",
								"aggregator": "sum"
							}
						]
					}
				],
				"autoscale": false,
				"custom_unit": "conns",
				"text_align": "center",
				"precision": 0
			}
		},
		{
			"id": 52,
			"layout": {
				"x": 53,
				"y": 326,
				"width": 52,
				"height": 32
			},
			"definition": {
				"title": "OCP Running Pods",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"alias": "Running Pods",
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "sum:kubernetes.pods.running{$ocp_env,$ocp_namespace_ext} by {kube_app_name,kube_deployment}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 53,
			"layout": {
				"x": 0,
				"y": 359,
				"width": 52,
				"height": 39
			},
			"definition": {
				"title": "OCP Container Working Memory",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "vertical",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"alias": "Working Memory",
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "sum:kubernetes.memory.working_set{$ocp_env,$ocp_namespace_ext} by {kube_container_name,kube_deployment}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 75,
			"layout": {
				"x": 216,
				"y": 247,
				"width": 54,
				"height": 23
			},
			"definition": {
				"title": "Get commands by name",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "anomalies(query1, 'basic', 2)"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "sum:azure.cache_redis.getcommands{$subscription_name,$rg_decoder_common}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "green",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 77,
			"layout": {
				"x": 216,
				"y": 271,
				"width": 54,
				"height": 26
			},
			"definition": {
				"title": "Set commands by name",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "anomalies(query1, 'basic', 2)"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "sum:azure.cache_redis.setcommands{$subscription_name,$rg_decoder_common}.as_count()",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "green",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 79,
			"layout": {
				"x": 216,
				"y": 298,
				"width": 26,
				"height": 23
			},
			"definition": {
				"title": "Total keys by name",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "anomalies(query1, 'basic', 3)"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "sum:azure.cache_redis.totalkeys{$subscription_name,$rg_decoder_common}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 80,
			"layout": {
				"x": 271,
				"y": 329,
				"width": 49,
				"height": 21
			},
			"definition": {
				"title": "CPU utilization by name",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "anomalies(query1, 'basic', 2)"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "avg:azure.cache_redis.percent_processor_time{$subscription_name,$rg_decoder_common}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "warm",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 81,
			"layout": {
				"x": 216,
				"y": 322,
				"width": 54,
				"height": 29
			},
			"definition": {
				"title": " Used memory by name",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "anomalies(query1, 'basic', 2)"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "sum:azure.cache_redis.usedmemory{$subscription_name,$rg_decoder_common}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "cool",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 82,
			"layout": {
				"x": 271,
				"y": 352,
				"width": 49,
				"height": 28
			},
			"definition": {
				"title": " Server load by name",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "anomalies(query1, 'basic', 2)"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "avg:azure.cache_redis.server_load{$subscription_name,$rg_decoder_common}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "orange",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 83,
			"layout": {
				"x": 216,
				"y": 352,
				"width": 54,
				"height": 29
			},
			"definition": {
				"title": " RSS memory by name",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "anomalies(query1, 'basic', 2)"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "sum:azure.cache_redis.usedmemory_rss{$subscription_name,$rg_decoder_common}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "cool",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 84,
			"layout": {
				"x": 216,
				"y": 382,
				"width": 54,
				"height": 38
			},
			"definition": {
				"title": "CPU utilization by name",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "avg:azure.cache_redis.percent_processor_time{$subscription_name,$rg_decoder_common} by {shard}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "warm",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 91,
			"layout": {
				"x": 105,
				"y": 173,
				"width": 53,
				"height": 22
			},
			"definition": {
				"title": "FD Status",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "anomalies(query1, 'basic', 2)"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "avg:azure.network_frontdoors.status{$subscription_name,$rg_decoder_ext}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 93,
			"layout": {
				"x": 105,
				"y": 150,
				"width": 53,
				"height": 22
			},
			"definition": {
				"title": "FD Total Latency",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1 / 1000"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "avg:azure.network_frontdoors.total_latency{$subscription_name,$rg_decoder_ext}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 95,
			"layout": {
				"x": 244,
				"y": 298,
				"width": 26,
				"height": 23
			},
			"definition": {
				"title": "Expired keys",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "anomalies(query1, 'basic', 3)"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "sum:azure.cache_redis.expiredkeys{$subscription_name,$rg_decoder_common}.as_count()",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 99,
			"layout": {
				"x": 105,
				"y": 0,
				"width": 24,
				"height": 6
			},
			"definition": {
				"type": "free_text",
				"text": "Front Doors",
				"color": "#4d4d4d",
				"font_size": "auto",
				"text_align": "left"
			}
		},
		{
			"id": 5604317798823120,
			"layout": {
				"x": 0,
				"y": 156,
				"width": 50,
				"height": 21
			},
			"definition": {
				"title": " SQL DB Session",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "avg:azure.sql_servers_databases.sessions_percent{$subscription_name,$rg_decoder_reports} by {name}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 199578578510316,
			"layout": {
				"x": 271,
				"y": 247,
				"width": 49,
				"height": 20
			},
			"definition": {
				"title": "Redis Cache Read/Write",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "avg:azure.cache_redis.cache_read{$subscription_name,$rg_decoder_common}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					},
					{
						"formulas": [
							{
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "avg:azure.cache_redis.cache_write{$subscription_name,$rg_decoder_common}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 5482330544752862,
			"layout": {
				"x": 271,
				"y": 268,
				"width": 49,
				"height": 19
			},
			"definition": {
				"title": "Redis Cache Hits",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "avg:azure.cache_redis.cachehits{$subscription_name,$rg_decoder_common}.as_count()",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 2913433182791070,
			"layout": {
				"x": 271,
				"y": 288,
				"width": 49,
				"height": 18
			},
			"definition": {
				"title": "Redis Cache Server Load",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "avg:azure.cache_redis.server_load{$subscription_name,$rg_decoder_common} by {type}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 1813810187752838,
			"layout": {
				"x": 271,
				"y": 307,
				"width": 49,
				"height": 21
			},
			"definition": {
				"title": "Redis Cache Keys",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "avg:azure.cache_redis.totalkeys{$subscription_name,$rg_decoder_common}.as_count()",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 6286307278126416,
			"layout": {
				"x": 271,
				"y": 402,
				"width": 49,
				"height": 18
			},
			"definition": {
				"title": "Redis Cache Connected Clients",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "avg:azure.cache_redis.connectedclients{$subscription_name,$rg_decoder_common} by {type}.as_count()",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 5525149834394926,
			"layout": {
				"x": 271,
				"y": 382,
				"width": 49,
				"height": 19
			},
			"definition": {
				"title": "Redis Cache Used Memory",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "sum:azure.cache_redis.usedmemory{$subscription_name,$rg_decoder_common}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					},
					{
						"formulas": [
							{
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "sum:azure.cache_redis.usedmemory_rss{$subscription_name,$rg_decoder_common}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 6892782750458134,
			"layout": {
				"x": 0,
				"y": 399,
				"width": 52,
				"height": 22
			},
			"definition": {
				"title": "Memory Limits per Pod",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"alias": "Memory Limit",
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"on_right_yaxis": false,
						"queries": [
							{
								"query": "sum:kubernetes.memory.limits{$ocp_env,$ocp_namespace_ext} by {pod_name}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": false
				},
				"markers": []
			}
		},
		{
			"id": 6368238673508942,
			"layout": {
				"x": 0,
				"y": 422,
				"width": 52,
				"height": 22
			},
			"definition": {
				"title": "CPU Limits per Pod",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "sum:kubernetes.cpu.limits{$ocp_env,$ocp_namespace_ext} by {pod_name}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 5391567337939748,
			"layout": {
				"x": 53,
				"y": 399,
				"width": 52,
				"height": 22
			},
			"definition": {
				"title": "Memory Usage ",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "sum:kubernetes.memory.usage{$ocp_env,$ocp_namespace_ext} by {kube_deployment}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 5327757320860574,
			"layout": {
				"x": 0,
				"y": 445,
				"width": 52,
				"height": 22
			},
			"definition": {
				"title": "Memory rss",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "vertical",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "sum:kubernetes.memory.rss{$ocp_env,$ocp_namespace_ext} by {pod_name}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 6299501366701960,
			"layout": {
				"x": 53,
				"y": 422,
				"width": 52,
				"height": 22
			},
			"definition": {
				"title": "CPU limits ",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "avg:kubernetes.cpu.limits{$ocp_env,$ocp_namespace_ext} by {kube_deployment}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 6579313572392342,
			"layout": {
				"x": 0,
				"y": 505,
				"width": 51,
				"height": 5
			},
			"definition": {
				"type": "free_text",
				"text": "Microservizi",
				"color": "#000",
				"font_size": "auto",
				"text_align": "left"
			}
		},
		{
			"id": 7973176695025748,
			"layout": {
				"x": 0,
				"y": 511,
				"width": 51,
				"height": 22
			},
			"definition": {
				"title": "Soge-HealtCard - CPU",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"alias": "Limits",
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"on_right_yaxis": false,
						"queries": [
							{
								"query": "avg:kubernetes.cpu.limits{$ocp_namespace_ext,$ocp_env,app:sogei-healthcard} by {pod_name}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "warm",
							"line_type": "solid",
							"line_width": "thin"
						},
						"display_type": "line"
					},
					{
						"formulas": [
							{
								"alias": "Total CPU",
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "avg:kubernetes.cpu.usage.total{$ocp_namespace_ext,$ocp_env,app:sogei-healthcard} by {pod_name}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 8103657033315226,
			"layout": {
				"x": 52,
				"y": 511,
				"width": 53,
				"height": 22
			},
			"definition": {
				"title": "Sogei-HealtCard - Memory",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"alias": "Memory",
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "avg:kubernetes.memory.usage{$ocp_namespace_ext,$ocp_env,app:sogei-healthcard} by {pod_name}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					},
					{
						"formulas": [
							{
								"alias": "Limits",
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"on_right_yaxis": false,
						"queries": [
							{
								"query": "avg:kubernetes.memory.limits{$ocp_namespace_ext,$ocp_env,app:sogei-healthcard} by {pod_name}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "warm",
							"line_type": "solid",
							"line_width": "thin"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 4178932171927782,
			"layout": {
				"x": 0,
				"y": 534,
				"width": 51,
				"height": 22
			},
			"definition": {
				"title": "Booking - CPU",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"alias": "Limits",
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"on_right_yaxis": false,
						"queries": [
							{
								"query": "avg:kubernetes.cpu.limits{$ocp_env,$ocp_namespace_ext,kube_deployment:decoder-booking-api} by {pod_name}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "warm",
							"line_type": "solid",
							"line_width": "thin"
						},
						"display_type": "line"
					},
					{
						"formulas": [
							{
								"alias": "Total CPU",
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "avg:kubernetes.cpu.usage.total{$ocp_env,$ocp_namespace_ext,kube_deployment:decoder-booking-api} by {pod_name}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 306902216783806,
			"layout": {
				"x": 52,
				"y": 534,
				"width": 53,
				"height": 22
			},
			"definition": {
				"title": "Booking - Memory",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"alias": "Memory",
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "avg:kubernetes.memory.usage{$ocp_env,$ocp_namespace_ext,kube_deployment:decoder-booking-api} by {pod_name}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					},
					{
						"formulas": [
							{
								"alias": "Limits",
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"on_right_yaxis": false,
						"queries": [
							{
								"query": "avg:kubernetes.memory.limits{$ocp_env,$ocp_namespace_ext,kube_deployment:decoder-booking-api} by {pod_name}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "warm",
							"line_type": "solid",
							"line_width": "thin"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 8793344971591070,
			"layout": {
				"x": 0,
				"y": 289,
				"width": 52,
				"height": 36
			},
			"definition": {
				"title": "CPU OCP Nodes",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "100 - query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "avg:system.cpu.idle{$cluster_name_ext,$ocp_env} by {host}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 3971210992551276,
			"layout": {
				"x": 53,
				"y": 289,
				"width": 52,
				"height": 36
			},
			"definition": {
				"title": "RAM OCP Nodes",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "avg:system.mem.usable{$cluster_name_ext,$ocp_env} by {host}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 7692194302647266,
			"layout": {
				"x": 0,
				"y": 326,
				"width": 52,
				"height": 32
			},
			"definition": {
				"title": "OCP Container Restart",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "sum:kubernetes.containers.restarts{$ocp_env,$ocp_namespace_ext} by {kube_container_name}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 6691270182533070,
			"layout": {
				"x": 105,
				"y": 87,
				"width": 53,
				"height": 20
			},
			"definition": {
				"title": "FD  Request Latency",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query2 / 1000"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "sum:azure.network_frontdoors.total_latency{$subscription_name,$rg_decoder_ext} by {httpstatus}",
								"data_source": "metrics",
								"name": "query2"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 6247194094386972,
			"layout": {
				"x": 105,
				"y": 108,
				"width": 53,
				"height": 20
			},
			"definition": {
				"title": "FD Backend Request Latency",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1 / 1000"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "sum:azure.network_frontdoors.backend_request_latency{$subscription_name,$rg_decoder_ext} by {backend}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 5753226459103948,
			"layout": {
				"x": 105,
				"y": 129,
				"width": 53,
				"height": 20
			},
			"definition": {
				"title": "FD WAF Request Count",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"response_format": "timeseries",
						"queries": [
							{
								"query": "sum:azure.network_frontdoors.web_application_firewall_request_count{$subscription_name,$rg_decoder_ext} by {policyname,action}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 1410713738921402,
			"layout": {
				"x": 0,
				"y": 136,
				"width": 50,
				"height": 19
			},
			"definition": {
				"title": "SQL -Server CPU Used",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "avg:azure.sql_servers_databases.cpu_used{$subscription_name,$rg_decoder_reports} by {server_name}.as_count()",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 8623760675909580,
			"layout": {
				"x": 0,
				"y": 198,
				"width": 50,
				"height": 21
			},
			"definition": {
				"title": "SQL -Server Storage Used",
				"title_size": "16",
				"title_align": "left",
				"show_legend": false,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "sum:azure.sql_servers_databases.storage{$subscription_name,$rg_decoder_reports} by {server_name}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 5496910705148004,
			"layout": {
				"x": 26,
				"y": 65,
				"width": 24,
				"height": 8
			},
			"definition": {
				"title": "SQL DB Failed connections",
				"title_size": "16",
				"title_align": "left",
				"type": "query_value",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1"
							}
						],
						"conditional_formats": [
							{
								"comparator": ">",
								"palette": "white_on_red",
								"value": 0
							}
						],
						"response_format": "scalar",
						"queries": [
							{
								"query": "sum:azure.sql_servers_databases.connection_failed{$subscription_name,$rg_decoder_reports}.as_count()",
								"data_source": "metrics",
								"name": "query1",
								"aggregator": "sum"
							}
						]
					}
				],
				"autoscale": false,
				"custom_unit": "conns",
				"text_align": "center",
				"precision": 0
			}
		},
		{
			"id": 5887039924747134,
			"layout": {
				"x": 0,
				"y": 19,
				"width": 50,
				"height": 25
			},
			"definition": {
				"title_size": "13",
				"title_align": "left",
				"type": "manage_status",
				"summary_type": "monitors",
				"display_format": "countsAndList",
				"color_preference": "background",
				"hide_zero_counts": false,
				"show_last_triggered": true,
				"query": "tag:(decoder OR alert_decoder)",
				"sort": "triggered,desc",
				"count": 50,
				"start": 0
			}
		},
		{
			"id": 8796113518451282,
			"layout": {
				"x": 0,
				"y": 14,
				"width": 24,
				"height": 4
			},
			"definition": {
				"type": "free_text",
				"text": "Alert",
				"color": "#4d4d4d",
				"font_size": "auto",
				"text_align": "left"
			}
		},
		{
			"id": 4468231878503986,
			"layout": {
				"x": 68,
				"y": 59,
				"width": 34,
				"height": 5
			},
			"definition": {
				"type": "free_text",
				"text": "SQL DB",
				"color": "#4d4d4d",
				"font_size": "auto",
				"text_align": "left"
			}
		},
		{
			"id": 4119330390593456,
			"layout": {
				"x": 52,
				"y": 74,
				"width": 50,
				"height": 19
			},
			"definition": {
				"title": " SQL DB Status ",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "avg:azure.sql_servers_databases.status{$subscription_name,$rg_decoder_common} by {name}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 108621521201858,
			"layout": {
				"x": 52,
				"y": 94,
				"width": 50,
				"height": 21
			},
			"definition": {
				"title": "SQL DB Connection Successful",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "anomalies(query1, 'basic', 2)"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "avg:azure.sql_servers_databases.connection_successful{$subscription_name,$rg_decoder_common}.as_count()",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 3369420272463410,
			"layout": {
				"x": 52,
				"y": 116,
				"width": 50,
				"height": 19
			},
			"definition": {
				"title": "SQL DB Connection failed",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "sum:azure.sql_servers_databases.connection_failed{$subscription_name,$rg_decoder_common} by {name}.as_count()",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 7697204727008670,
			"layout": {
				"x": 52,
				"y": 220,
				"width": 50,
				"height": 21
			},
			"definition": {
				"title": "SQL -Server Storage %",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "avg:azure.sql_servers_databases.storage_percent{$subscription_name,$rg_decoder_common} by {server_name}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 8197948420536652,
			"layout": {
				"x": 52,
				"y": 178,
				"width": 50,
				"height": 19
			},
			"definition": {
				"title": "SQL- Server Log Writes",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "avg:azure.sql_servers_databases.log_write_percent{$subscription_name,$rg_decoder_common} by {name}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 1429767880860848,
			"layout": {
				"x": 52,
				"y": 65,
				"width": 24,
				"height": 8
			},
			"definition": {
				"title": "SQL DB Successful connections",
				"title_size": "16",
				"title_align": "left",
				"type": "query_value",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1"
							}
						],
						"response_format": "scalar",
						"queries": [
							{
								"query": "sum:azure.sql_servers_databases.connection_successful{$subscription_name,$rg_decoder_common}.as_count()",
								"data_source": "metrics",
								"name": "query1",
								"aggregator": "sum"
							}
						]
					}
				],
				"autoscale": false,
				"custom_unit": "conns",
				"text_align": "center",
				"precision": 0
			}
		},
		{
			"id": 8700432520488488,
			"layout": {
				"x": 52,
				"y": 156,
				"width": 50,
				"height": 21
			},
			"definition": {
				"title": " SQL DB Session",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "avg:azure.sql_servers_databases.sessions_percent{$subscription_name,$rg_decoder_common} by {name}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 525658703098892,
			"layout": {
				"x": 52,
				"y": 136,
				"width": 50,
				"height": 19
			},
			"definition": {
				"title": "SQL -Server CPU Used",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "avg:azure.sql_servers_databases.cpu_used{$subscription_name,$rg_decoder_common} by {server_name}.as_count()",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 215292750485050,
			"layout": {
				"x": 52,
				"y": 198,
				"width": 50,
				"height": 21
			},
			"definition": {
				"title": "SQL -Server Storage Used",
				"title_size": "16",
				"title_align": "left",
				"show_legend": false,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "sum:azure.sql_servers_databases.storage{$subscription_name,$rg_decoder_common} by {server_name}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 3314283818980128,
			"layout": {
				"x": 77,
				"y": 65,
				"width": 24,
				"height": 8
			},
			"definition": {
				"title": "SQL DB Failed connections",
				"title_size": "16",
				"title_align": "left",
				"type": "query_value",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1"
							}
						],
						"conditional_formats": [
							{
								"comparator": ">",
								"palette": "white_on_red",
								"value": 0
							}
						],
						"response_format": "scalar",
						"queries": [
							{
								"query": "sum:azure.sql_servers_databases.connection_failed{$subscription_name,$rg_decoder_common}.as_count()",
								"data_source": "metrics",
								"name": "query1",
								"aggregator": "sum"
							}
						]
					}
				],
				"autoscale": false,
				"custom_unit": "conns",
				"text_align": "center",
				"precision": 0
			}
		},
		{
			"id": 794998831091452,
			"layout": {
				"x": 24,
				"y": 256,
				"width": 21,
				"height": 7
			},
			"definition": {
				"title": "Kubelets up",
				"title_size": "16",
				"title_align": "center",
				"type": "check_status",
				"check": "kubernetes.kubelet.check",
				"grouping": "cluster",
				"group_by": [],
				"tags": [
					"$cluster_name_ext"
				]
			}
		},
		{
			"id": 4282259304042950,
			"layout": {
				"x": 0,
				"y": 248,
				"width": 23,
				"height": 15
			},
			"definition": {
				"type": "image",
				"url": "/static/images/screenboard/integrations/kubernetes.jpg",
				"sizing": "zoom"
			}
		},
		{
			"id": 4750644972497114,
			"layout": {
				"x": 24,
				"y": 248,
				"width": 21,
				"height": 7
			},
			"definition": {
				"title": "Kubelet Ping",
				"title_size": "16",
				"title_align": "center",
				"type": "check_status",
				"check": "kubernetes.kubelet.check.ping",
				"grouping": "cluster",
				"group_by": [],
				"tags": [
					"$cluster_name_ext"
				]
			}
		},
		{
			"id": 630095254782012,
			"layout": {
				"x": 40,
				"y": 264,
				"width": 39,
				"height": 24
			},
			"definition": {
				"title": "Most CPU-intensive pods",
				"title_size": "16",
				"title_align": "left",
				"type": "toplist",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1",
								"limit": {
									"count": 10,
									"order": "desc"
								}
							}
						],
						"response_format": "scalar",
						"queries": [
							{
								"query": "sum:kubernetes.cpu.usage.total{$ocp_namespace_ext,$cluster_name_ext} by {pod_name}",
								"data_source": "metrics",
								"name": "query1",
								"aggregator": "avg"
							}
						]
					}
				]
			}
		},
		{
			"id": 7387386997046140,
			"layout": {
				"x": 46,
				"y": 246,
				"width": 42,
				"height": 17
			},
			"definition": {
				"title": "Running pods per node",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "vertical",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "sum:kubernetes.pods.running{$ocp_env,$ocp_namespace_ext,$cluster_name_ext} by {host}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "area"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 4847715938099070,
			"layout": {
				"x": 0,
				"y": 264,
				"width": 39,
				"height": 24
			},
			"definition": {
				"title": "Most memory-intensive pods",
				"title_size": "16",
				"title_align": "left",
				"type": "toplist",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1",
								"limit": {
									"count": 10,
									"order": "desc"
								}
							}
						],
						"response_format": "scalar",
						"queries": [
							{
								"query": "sum:kubernetes.memory.usage{$ocp_namespace_ext,$cluster_name_ext} by {pod_name}",
								"data_source": "metrics",
								"name": "query1",
								"aggregator": "avg"
							}
						]
					}
				]
			}
		},
		{
			"id": 6785751572732286,
			"layout": {
				"x": 0,
				"y": 51,
				"width": 15,
				"height": 13
			},
			"definition": {
				"type": "image",
				"url": "/static/images/saas_logos/bot/azure_sql_database.png",
				"sizing": "center"
			}
		},
		{
			"id": 3516747522193356,
			"layout": {
				"x": 52,
				"y": 51,
				"width": 15,
				"height": 13
			},
			"definition": {
				"type": "image",
				"url": "/static/images/saas_logos/bot/azure_sql_database.png",
				"sizing": "center"
			}
		},
		{
			"id": 7159833866644824,
			"layout": {
				"x": 105,
				"y": 35,
				"width": 53,
				"height": 26
			},
			"definition": {
				"title": "FD Request by HTTP Status",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "vertical",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"response_format": "timeseries",
						"queries": [
							{
								"query": "sum:azure.network_frontdoors.request_count{$subscription_name,$rg_decoder_ext} by {httpstatus}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 3880920062583618,
			"layout": {
				"x": 105,
				"y": 8,
				"width": 53,
				"height": 26
			},
			"definition": {
				"title": "FD Request",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "vertical",
				"legend_columns": [
					"sum",
					"value",
					"avg",
					"min",
					"max"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "sum:azure.network_frontdoors.request_count{$subscription_name,$rg_decoder_ext}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 5554270144562146,
			"layout": {
				"x": 105,
				"y": 62,
				"width": 53,
				"height": 24
			},
			"definition": {
				"title": "FD Backend Request Count",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "vertical",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"response_format": "timeseries",
						"queries": [
							{
								"query": "sum:azure.network_frontdoors.backend_request_count{$subscription_name,$rg_decoder_ext} by {httpstatus}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 8255073237751920,
			"layout": {
				"x": 160,
				"y": 8,
				"width": 53,
				"height": 26
			},
			"definition": {
				"title": "FD Request % Errore 4xx+5xx su 4xx+5xx+2xx",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "(query1 / (query2 + query1)) * 100"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "sum:azure.network_frontdoors.request_count{$subscription_name AND $rg_decoder_ext AND (httpstatusgroup:4xx OR httpstatusgroup:5xx)}",
								"data_source": "metrics",
								"name": "query1"
							},
							{
								"query": "sum:azure.network_frontdoors.request_count{$subscription_name,httpstatusgroup:2xx,$rg_decoder_ext}",
								"data_source": "metrics",
								"name": "query2"
							}
						],
						"style": {
							"palette": "red",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 7389732038864592,
			"layout": {
				"x": 216,
				"y": 238,
				"width": 27,
				"height": 8
			},
			"definition": {
				"type": "image",
				"url": "/static/images/saas_logos/bot/redis.png",
				"sizing": "center"
			}
		},
		{
			"id": 4516013182517208,
			"layout": {
				"x": 267,
				"y": 0,
				"width": 24,
				"height": 6
			},
			"definition": {
				"type": "free_text",
				"text": "Metric Custom",
				"color": "#4d4d4d",
				"font_size": "auto",
				"text_align": "left"
			}
		},
		{
			"id": 3340909446918708,
			"layout": {
				"x": 14,
				"y": 1,
				"width": 51,
				"height": 5
			},
			"definition": {
				"type": "free_text",
				"text": "Consegne Decoder ",
				"color": "#4d4d4d",
				"font_size": "auto",
				"text_align": "left"
			}
		},
		{
			"id": 6068663788001008,
			"layout": {
				"x": 52,
				"y": 8,
				"width": 51,
				"height": 17
			},
			"definition": {
				"title": "Tempo di Risposta - Synthetic su risorsa Statica PRIMULA.JPG",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"type": "timeseries",
				"requests": [
					{
						"q": "anomalies(avg:synthetics.http.response.time{check_id:ti6-mjh-jqf}, \"basic\", 3)",
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 4165363727883240,
			"layout": {
				"x": 52,
				"y": 26,
				"width": 51,
				"height": 18
			},
			"definition": {
				"title": "Tempo di Risposta - Synthetic su homepage",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"type": "timeseries",
				"requests": [
					{
						"q": "anomalies(avg:synthetics.http.response.time{check_id:78h-mia-qiu}, \"basic\", 3)",
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 3468033798040716,
			"layout": {
				"x": 160,
				"y": 37,
				"width": 53,
				"height": 20
			},
			"definition": {
				"title": "FD Request by Count",
				"title_size": "16",
				"title_align": "left",
				"type": "toplist",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1",
								"limit": {
									"count": 5,
									"order": "desc"
								}
							}
						],
						"response_format": "scalar",
						"queries": [
							{
								"query": "sum:azure.network_frontdoors.request_count{$subscription_name,$rg_decoder_ext} by {clientcountry}",
								"data_source": "metrics",
								"name": "query1",
								"aggregator": "sum"
							}
						]
					}
				]
			}
		},
		{
			"id": 5003689868498582,
			"layout": {
				"x": 216,
				"y": 190,
				"width": 48,
				"height": 20
			},
			"definition": {
				"title": "Azure keyvault vaults count for name",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "sum:azure.keyvault_vaults.count{$subscription_name,$rg_decoder_common} by {status,name}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 3622985210747114,
			"layout": {
				"x": 216,
				"y": 212,
				"width": 48,
				"height": 20
			},
			"definition": {
				"title": "Keyvault Vaults Status",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "sum:azure.keyvault_vaults.status{$subscription_name,$rg_decoder_common} by {name,status}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 664426047540028,
			"layout": {
				"x": 216,
				"y": 181,
				"width": 27,
				"height": 8
			},
			"definition": {
				"type": "image",
				"url": "https://azure.microsoft.com/svghandler/key-vault/?width=175&height=75",
				"sizing": "center"
			}
		},
		{
			"id": 3442312163209270,
			"layout": {
				"x": 0,
				"y": 557,
				"width": 51,
				"height": 20
			},
			"definition": {
				"title": "Towns - CPU",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"alias": "Limits",
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"on_right_yaxis": false,
						"queries": [
							{
								"query": "avg:kubernetes.cpu.limits{$ocp_namespace_ext,$ocp_env,app:towns} by {pod_name}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "warm",
							"line_type": "solid",
							"line_width": "thin"
						},
						"display_type": "line"
					},
					{
						"formulas": [
							{
								"alias": "Total CPU",
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "avg:kubernetes.cpu.usage.total{$ocp_namespace_ext,$ocp_env,app:towns} by {pod_name}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 8045558153569179,
			"layout": {
				"x": 52,
				"y": 557,
				"width": 53,
				"height": 20
			},
			"definition": {
				"title": "Towns - Memory",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"alias": "Memory",
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "avg:kubernetes.memory.usage{$ocp_namespace_ext,$ocp_env,app:towns} by {pod_name}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					},
					{
						"formulas": [
							{
								"alias": "Limits",
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"on_right_yaxis": false,
						"queries": [
							{
								"query": "avg:kubernetes.memory.limits{$ocp_namespace_ext,$ocp_env,app:towns} by {pod_name}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "warm",
							"line_type": "solid",
							"line_width": "thin"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 1934364306427444,
			"layout": {
				"x": 53,
				"y": 359,
				"width": 52,
				"height": 21
			},
			"definition": {
				"title": "Running Pods & Container",
				"title_size": "16",
				"title_align": "left",
				"type": "query_table",
				"requests": [
					{
						"formulas": [
							{
								"alias": "Running Pods",
								"cell_display_mode": "bar",
								"limit": {
									"count": 10,
									"order": "desc"
								},
								"formula": "query1"
							},
							{
								"alias": "Running Containers",
								"cell_display_mode": "bar",
								"formula": "query2"
							}
						],
						"response_format": "scalar",
						"queries": [
							{
								"query": "sum:kubernetes.pods.running{$ocp_env,$ocp_namespace_ext} by {kube_app_name,host}",
								"data_source": "metrics",
								"name": "query1",
								"aggregator": "last"
							},
							{
								"query": "sum:kubernetes.containers.running{$ocp_env,$ocp_namespace_ext} by {kube_app_name,host}",
								"data_source": "metrics",
								"name": "query2",
								"aggregator": "last"
							}
						]
					}
				],
				"has_search_bar": "always"
			}
		},
		{
			"id": 4258641303521164,
			"layout": {
				"x": 53,
				"y": 381,
				"width": 52,
				"height": 17
			},
			"definition": {
				"title": "Container Restart Count",
				"title_size": "16",
				"title_align": "left",
				"time": {
					"live_span": "1d"
				},
				"type": "query_table",
				"requests": [
					{
						"formulas": [
							{
								"alias": "Restarts",
								"cell_display_mode": "bar",
								"limit": {
									"count": 10,
									"order": "desc"
								},
								"formula": "query1"
							}
						],
						"response_format": "scalar",
						"queries": [
							{
								"query": "sum:kubernetes.containers.restarts{$ocp_env,$ocp_namespace_ext} by {kube_container_name,host}",
								"data_source": "metrics",
								"name": "query1",
								"aggregator": "sum"
							}
						]
					}
				],
				"has_search_bar": "always"
			}
		},
		{
			"id": 2071890422976474,
			"layout": {
				"x": 216,
				"y": 59,
				"width": 48,
				"height": 25
			},
			"definition": {
				"title": "Successful Server Latency by SA",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_size": "0",
				"type": "timeseries",
				"requests": [
					{
						"q": "avg:azure.storage_storageaccounts_blobservices.success_server_latency{$subscription_name AND $rg_decoder_ext OR $rg_decoder_int} by {name,resource_group}",
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 1396513056661855,
			"layout": {
				"x": 216,
				"y": 152,
				"width": 48,
				"height": 22
			},
			"definition": {
				"title": "Blob Count by SA",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_size": "0",
				"type": "timeseries",
				"requests": [
					{
						"q": "sum:azure.storage_storageaccounts_blobservices.blob_count{$subscription_name AND $rg_decoder_ext OR $rg_decoder_int} by {name}.as_count()",
						"metadata": [
							{
								"expression": "sum:azure.storage_storageaccounts_blobservices.blob_count{$subscription_name AND $res_inoc OR $res_book} by {name}.as_count()",
								"alias_name": "Count"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 3437530005860438,
			"layout": {
				"x": 216,
				"y": 421,
				"width": 54,
				"height": 37
			},
			"definition": {
				"title": "Redis Cache Misses Percentage",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1 / (query1 + query2) * 100"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "avg:azure.cache_redis.cachemisses{$subscription_name,$rg_decoder_common}.as_count()",
								"data_source": "metrics",
								"name": "query1"
							},
							{
								"query": "avg:azure.cache_redis.cachehits{$subscription_name,$rg_decoder_common}.as_count()",
								"data_source": "metrics",
								"name": "query2"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 3701822556429046,
			"layout": {
				"x": 216,
				"y": 85,
				"width": 48,
				"height": 20
			},
			"definition": {
				"title": "Network Latency  Booking pvaxbsastaticint01",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_size": "0",
				"legend_layout": "vertical",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"q": "max:azure.storage_storageaccounts_blobservices.success_e2_e_latency{subscription_name:poste-rdc-produzione,resource_group:vax-prod-rg-booking,name:pvaxbsastaticint01}, max:azure.storage_storageaccounts_blobservices.success_server_latency{subscription_name:poste-rdc-produzione,resource_group:vax-prod-rg-booking,name:pvaxbsastaticint01}, max:azure.storage_storageaccounts_blobservices.success_e2_e_latency{subscription_name:poste-rdc-produzione,resource_group:vax-prod-rg-booking,name:pvaxbsastaticint01} - max:azure.storage_storageaccounts_blobservices.success_server_latency{subscription_name:poste-rdc-produzione,resource_group:vax-prod-rg-booking,name:pvaxbsastaticint01}",
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 6011116998599436,
			"layout": {
				"x": 160,
				"y": 326,
				"width": 52,
				"height": 32
			},
			"definition": {
				"title": "OCP Running Pods",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"alias": "Running Pods",
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "sum:kubernetes.pods.running{$ocp_namespace_int,$ocp_env} by {kube_app_name,kube_deployment}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 261257168893106,
			"layout": {
				"x": 107,
				"y": 359,
				"width": 52,
				"height": 39
			},
			"definition": {
				"title": "OCP Container Working Memory",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "vertical",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"alias": "Working Memory",
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "sum:kubernetes.memory.working_set{$ocp_namespace_int,$ocp_env} by {kube_container_name,kube_deployment}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 548109373932996,
			"layout": {
				"x": 107,
				"y": 399,
				"width": 52,
				"height": 22
			},
			"definition": {
				"title": "Memory Limits per Pod",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"alias": "Memory Limit",
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"on_right_yaxis": false,
						"queries": [
							{
								"query": "sum:kubernetes.memory.limits{$ocp_namespace_int,$ocp_env} by {pod_name}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": false
				},
				"markers": []
			}
		},
		{
			"id": 3128655303984318,
			"layout": {
				"x": 160,
				"y": 399,
				"width": 52,
				"height": 22
			},
			"definition": {
				"title": "Memory Usage ",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "sum:kubernetes.memory.usage{$ocp_namespace_int,$ocp_env} by {kube_deployment}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 3168921416616468,
			"layout": {
				"x": 107,
				"y": 289,
				"width": 52,
				"height": 36
			},
			"definition": {
				"title": "CPU OCP Nodes",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "100 - query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "avg:system.cpu.idle{$cluster_name_int,$ocp_env} by {host}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 4536322455061556,
			"layout": {
				"x": 160,
				"y": 289,
				"width": 52,
				"height": 36
			},
			"definition": {
				"title": "RAM OCP Nodes",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "avg:system.mem.usable{$cluster_name_int,$ocp_env} by {host}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 8813462006282880,
			"layout": {
				"x": 107,
				"y": 326,
				"width": 52,
				"height": 32
			},
			"definition": {
				"title": "OCP Container Restart",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "sum:kubernetes.containers.restarts{$ocp_namespace_int,$ocp_env} by {kube_container_name}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 4496066277170830,
			"layout": {
				"x": 131,
				"y": 256,
				"width": 21,
				"height": 7
			},
			"definition": {
				"title": "Kubelets up",
				"title_size": "16",
				"title_align": "center",
				"type": "check_status",
				"check": "kubernetes.kubelet.check",
				"grouping": "cluster",
				"group_by": [],
				"tags": [
					"$cluster_name_int"
				]
			}
		},
		{
			"id": 1377829411849586,
			"layout": {
				"x": 107,
				"y": 248,
				"width": 23,
				"height": 15
			},
			"definition": {
				"type": "image",
				"url": "/static/images/screenboard/integrations/kubernetes.jpg",
				"sizing": "zoom"
			}
		},
		{
			"id": 4762548439023778,
			"layout": {
				"x": 131,
				"y": 248,
				"width": 21,
				"height": 7
			},
			"definition": {
				"title": "Kubelet Ping",
				"title_size": "16",
				"title_align": "center",
				"type": "check_status",
				"check": "kubernetes.kubelet.check.ping",
				"grouping": "cluster",
				"group_by": [],
				"tags": [
					"$cluster_name_int"
				]
			}
		},
		{
			"id": 7193195574266638,
			"layout": {
				"x": 147,
				"y": 264,
				"width": 39,
				"height": 24
			},
			"definition": {
				"title": "Most CPU-intensive pods",
				"title_size": "16",
				"title_align": "left",
				"type": "toplist",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1",
								"limit": {
									"count": 10,
									"order": "desc"
								}
							}
						],
						"response_format": "scalar",
						"queries": [
							{
								"query": "sum:kubernetes.cpu.usage.total{$ocp_env,$ocp_namespace_int} by {pod_name}",
								"data_source": "metrics",
								"name": "query1",
								"aggregator": "avg"
							}
						]
					}
				]
			}
		},
		{
			"id": 269163774004374,
			"layout": {
				"x": 160,
				"y": 246,
				"width": 42,
				"height": 17
			},
			"definition": {
				"title": "Running pods per node",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "vertical",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "sum:kubernetes.pods.running{$ocp_env,$ocp_namespace_int,$cluster_name_ext} by {host}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "area"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 5026667877805640,
			"layout": {
				"x": 107,
				"y": 264,
				"width": 39,
				"height": 24
			},
			"definition": {
				"title": "Most memory-intensive pods",
				"title_size": "16",
				"title_align": "left",
				"type": "toplist",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1",
								"limit": {
									"count": 10,
									"order": "desc"
								}
							}
						],
						"response_format": "scalar",
						"queries": [
							{
								"query": "sum:kubernetes.memory.usage{$ocp_env,$ocp_namespace_int} by {pod_name}",
								"data_source": "metrics",
								"name": "query1",
								"aggregator": "avg"
							}
						]
					}
				]
			}
		},
		{
			"id": 3769721593982548,
			"layout": {
				"x": 160,
				"y": 359,
				"width": 52,
				"height": 21
			},
			"definition": {
				"title": "Running Pods & Container",
				"title_size": "16",
				"title_align": "left",
				"type": "query_table",
				"requests": [
					{
						"formulas": [
							{
								"alias": "Running Pods",
								"cell_display_mode": "bar",
								"limit": {
									"count": 10,
									"order": "desc"
								},
								"formula": "query1"
							},
							{
								"alias": "Running Containers",
								"cell_display_mode": "bar",
								"formula": "query2"
							}
						],
						"response_format": "scalar",
						"queries": [
							{
								"query": "sum:kubernetes.pods.running{$ocp_namespace_int,$ocp_env} by {kube_app_name,host}",
								"data_source": "metrics",
								"name": "query1",
								"aggregator": "last"
							},
							{
								"query": "sum:kubernetes.containers.running{$ocp_namespace_int,$ocp_env} by {kube_app_name,host}",
								"data_source": "metrics",
								"name": "query2",
								"aggregator": "last"
							}
						]
					}
				],
				"has_search_bar": "always"
			}
		},
		{
			"id": 156578032651702,
			"layout": {
				"x": 160,
				"y": 381,
				"width": 52,
				"height": 17
			},
			"definition": {
				"title": "Container Restart Count",
				"title_size": "16",
				"title_align": "left",
				"time": {
					"live_span": "1d"
				},
				"type": "query_table",
				"requests": [
					{
						"formulas": [
							{
								"alias": "Restarts",
								"cell_display_mode": "bar",
								"limit": {
									"count": 10,
									"order": "desc"
								},
								"formula": "query1"
							}
						],
						"response_format": "scalar",
						"queries": [
							{
								"query": "sum:kubernetes.containers.restarts{$ocp_namespace_int,$ocp_env} by {kube_container_name,host}",
								"data_source": "metrics",
								"name": "query1",
								"aggregator": "sum"
							}
						]
					}
				],
				"has_search_bar": "always"
			}
		},
		{
			"id": 5856126036605424,
			"layout": {
				"x": 107,
				"y": 422,
				"width": 52,
				"height": 22
			},
			"definition": {
				"title": "CPU Limits per Pod",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "sum:kubernetes.cpu.limits{$ocp_namespace_int,$ocp_env} by {pod_name}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 461679117590136,
			"layout": {
				"x": 107,
				"y": 445,
				"width": 52,
				"height": 22
			},
			"definition": {
				"title": "Memory rss",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "vertical",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "sum:kubernetes.memory.rss{$ocp_namespace_int,$ocp_env} by {pod_name}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 7861869402868848,
			"layout": {
				"x": 160,
				"y": 422,
				"width": 52,
				"height": 22
			},
			"definition": {
				"title": "CPU limits ",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "query1"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "avg:kubernetes.cpu.limits{$ocp_namespace_int,$ocp_env} by {kube_deployment}",
								"data_source": "metrics",
								"name": "query1"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 8763941079415928,
			"layout": {
				"x": 160,
				"y": 445,
				"width": 39,
				"height": 30
			},
			"definition": {
				"title": "check cronjob start",
				"title_size": "16",
				"title_align": "left",
				"time": {
					"live_span": "1w"
				},
				"type": "event_stream",
				"query": "cronjob_vaccinazioni:problem",
				"tags_execution": "and",
				"event_size": "s"
			}
		},
		{
			"id": 6095862440155560,
			"layout": {
				"x": 80,
				"y": 264,
				"width": 25,
				"height": 6
			},
			"definition": {
				"type": "free_text",
				"text": "EXT",
				"color": "#4d4d4d",
				"font_size": "auto",
				"text_align": "left"
			}
		},
		{
			"id": 1463214430651948,
			"layout": {
				"x": 187,
				"y": 264,
				"width": 25,
				"height": 6
			},
			"definition": {
				"type": "free_text",
				"text": "INT",
				"color": "#4d4d4d",
				"font_size": "auto",
				"text_align": "left"
			}
		},
		{
			"id": 7804726863146152,
			"layout": {
				"x": 267,
				"y": 7,
				"width": 63,
				"height": 27
			},
			"definition": {
				"title": "Coll Int HttpRequest Latency ",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "vertical",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"alias": "AVG Latency",
								"formula": "per_second(query1) / per_second(query2)"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "avg:decoder_coll_int.http_request_duration_seconds.sum{*} by {handler,code}",
								"data_source": "metrics",
								"name": "query1"
							},
							{
								"query": "avg:decoder_coll_int.http_request_duration_seconds.count{*} by {handler,code}",
								"data_source": "metrics",
								"name": "query2"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				]
			}
		},
		{
			"id": 7079013364740008,
			"layout": {
				"x": 331,
				"y": 7,
				"width": 63,
				"height": 27
			},
			"definition": {
				"title": "Coll Ext HttpRequest Latency ",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "vertical",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"alias": "AVG Latency",
								"formula": "per_second(query1) / per_second(query2)"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "avg:decoder_coll.http_request_duration_seconds.sum{$ocp_env} by {handler,code}",
								"data_source": "metrics",
								"name": "query1"
							},
							{
								"query": "avg:decoder_coll.http_request_duration_seconds.count{$ocp_env} by {handler,code}",
								"data_source": "metrics",
								"name": "query2"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				]
			}
		},
		{
			"id": 4274532864308344,
			"layout": {
				"x": 331,
				"y": 35,
				"width": 63,
				"height": 27
			},
			"definition": {
				"title": "Coll Ext HttpRequest Counter by URI",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "vertical",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "per_minute(query2)"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "sum:decoder_coll.http_request_duration_seconds.count{$ocp_env} by {handler,code}",
								"data_source": "metrics",
								"name": "query2"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "bars"
					}
				]
			}
		},
		{
			"id": 8228145412805270,
			"layout": {
				"x": 267,
				"y": 35,
				"width": 63,
				"height": 27
			},
			"definition": {
				"title": "Coll Int HttpRequest Count",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "vertical",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "per_second(query2)"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "sum:decoder_coll_int.http_request_duration_seconds.count{*} by {handler,code}",
								"data_source": "metrics",
								"name": "query2"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "bars"
					}
				]
			}
		},
		{
			"id": 2700923532451902,
			"layout": {
				"x": 331,
				"y": 63,
				"width": 63,
				"height": 27
			},
			"definition": {
				"title": "Coll Login",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "vertical",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"alias": "LoginKO",
								"formula": "query2"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "sum:decoder_coll.booking_api_loginKO{*} by {channel}.as_count()",
								"data_source": "metrics",
								"name": "query2"
							}
						],
						"style": {
							"palette": "warm",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "bars"
					},
					{
						"formulas": [
							{
								"alias": "LoginOK",
								"formula": "query0"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "sum:decoder_coll.booking_api_loginOK{*} by {channel}.as_count()",
								"data_source": "metrics",
								"name": "query0"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "bars"
					}
				]
			}
		},
		{
			"id": 3908496309779244,
			"layout": {
				"x": 331,
				"y": 91,
				"width": 63,
				"height": 27
			},
			"definition": {
				"title": "Coll OTP Error",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "vertical",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"alias": "Otp Error",
								"formula": "query2"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "sum:decoder_coll.booking_api_otpError{*} by {channel}.as_count()",
								"data_source": "metrics",
								"name": "query2"
							}
						],
						"style": {
							"palette": "warm",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "bars"
					}
				]
			}
		},
		{
			"id": 543641612600240,
			"layout": {
				"x": 331,
				"y": 119,
				"width": 63,
				"height": 27
			},
			"definition": {
				"title": "Coll Confirm",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "vertical",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"alias": "Confirm Error",
								"formula": "query2"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "sum:decoder_coll.booking_api_confirmError{*} by {channel}.as_count()",
								"data_source": "metrics",
								"name": "query2"
							}
						],
						"style": {
							"palette": "warm",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "bars"
					},
					{
						"formulas": [
							{
								"alias": "Confirm OK",
								"formula": "query0"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "avg:decoder_coll.booking_api_confirmOK{*} by {channel}.as_count()",
								"data_source": "metrics",
								"name": "query0"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "bars"
					}
				]
			}
		},
		{
			"id": 3226122966291088,
			"layout": {
				"x": 331,
				"y": 147,
				"width": 63,
				"height": 27
			},
			"definition": {
				"title": "Coll SMS Error",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "vertical",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"alias": "SMS Send Error",
								"formula": "query2"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "sum:decoder_coll.booking_api_sms_send_error{*} by {channel}.as_count()",
								"data_source": "metrics",
								"name": "query2"
							}
						],
						"style": {
							"palette": "warm",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "bars"
					}
				]
			}
		},
		{
			"id": 3151603564485770,
			"layout": {
				"x": 267,
				"y": 63,
				"width": 63,
				"height": 27
			},
			"definition": {
				"title": "Coll Int Login",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "vertical",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"alias": "LoginKO",
								"formula": "query2"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "sum:decoder_coll_int.booking_api_loginKO{*} by {channel}.as_count()",
								"data_source": "metrics",
								"name": "query2"
							}
						],
						"style": {
							"palette": "warm",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "bars"
					},
					{
						"formulas": [
							{
								"alias": "LoginOK",
								"formula": "query0"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "sum:decoder_coll_int.booking_api_loginOK{*} by {channel}.as_count()",
								"data_source": "metrics",
								"name": "query0"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "bars"
					}
				]
			}
		},
		{
			"id": 8224577073428390,
			"layout": {
				"x": 267,
				"y": 119,
				"width": 63,
				"height": 27
			},
			"definition": {
				"title": "Coll Int Confirm",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "vertical",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"alias": "Confirm OK",
								"formula": "query0"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "avg:decoder_coll_int.booking_api_confirmOK{*} by {channel}.as_count()",
								"data_source": "metrics",
								"name": "query0"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "bars"
					}
				]
			}
		},
		{
			"id": 3952295890007384,
			"layout": {
				"x": 267,
				"y": 147,
				"width": 63,
				"height": 27
			},
			"definition": {
				"title": "Coll Int SMS Error",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "vertical",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"alias": "SMS Send Error",
								"formula": "query2"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "sum:decoder_coll_int.booking_api_sms_send_error{*} by {channel}.as_count()",
								"data_source": "metrics",
								"name": "query2"
							}
						],
						"style": {
							"palette": "warm",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "bars"
					}
				]
			}
		},
		{
			"id": 1068720219463298,
			"layout": {
				"x": 267,
				"y": 175,
				"width": 63,
				"height": 27
			},
			"definition": {
				"title": "Coll Int IVR",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "vertical",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"alias": "Ivr User Fount",
								"formula": "query2"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "sum:decoder_coll_int.ivrApi_userfound{*} by {channel}.as_count()",
								"data_source": "metrics",
								"name": "query2"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "bars"
					},
					{
						"formulas": [
							{
								"alias": "Ivr User Not Fount",
								"formula": "query0"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "avg:decoder_coll_int.ivrApi_usernotfound{*} by {channel}.as_count()",
								"data_source": "metrics",
								"name": "query0"
							}
						],
						"style": {
							"palette": "warm",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "bars"
					}
				]
			}
		},
		{
			"id": 5215253389149344,
			"layout": {
				"x": 0,
				"y": 477,
				"width": 52,
				"height": 25
			},
			"definition": {
				"title": "Kubernetes Cpu Usage Total / Limits",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "((query1 / 1000000000) / query2) * 100"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "sum:kubernetes.cpu.usage.total{$ocp_namespace_ext,$cluster_name_ext} by {kube_container_name,pod_name}",
								"data_source": "metrics",
								"name": "query1"
							},
							{
								"query": "sum:kubernetes.cpu.limits{$cluster_name_ext,$ocp_namespace_ext} by {kube_container_name,pod_name}",
								"data_source": "metrics",
								"name": "query2"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 5890842590119024,
			"layout": {
				"x": 53,
				"y": 477,
				"width": 52,
				"height": 25
			},
			"definition": {
				"title": "Kubernetes Memory Usage / Limits",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "(query1 / query2) * 100"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "avg:kubernetes.memory.usage{$cluster_name_ext,$ocp_namespace_ext} by {kube_container_name}",
								"data_source": "metrics",
								"name": "query1"
							},
							{
								"query": "avg:kubernetes.memory.limits{$cluster_name_ext,$ocp_namespace_ext} by {kube_container_name}",
								"data_source": "metrics",
								"name": "query2"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 3226351050412014,
			"layout": {
				"x": 107,
				"y": 477,
				"width": 52,
				"height": 25
			},
			"definition": {
				"title": "Kubernetes Cpu Usage Total / Limits",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "((query1 / 1000000000) / query2) * 100"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "sum:kubernetes.cpu.usage.total{$cluster_name_ext,$ocp_namespace_int} by {kube_container_name,pod_name}",
								"data_source": "metrics",
								"name": "query1"
							},
							{
								"query": "sum:kubernetes.cpu.limits{$cluster_name_ext,$ocp_namespace_int} by {kube_container_name,pod_name}",
								"data_source": "metrics",
								"name": "query2"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		},
		{
			"id": 82823500078002,
			"layout": {
				"x": 160,
				"y": 477,
				"width": 52,
				"height": 25
			},
			"definition": {
				"title": "Kubernetes Memory Usage / Limits",
				"title_size": "16",
				"title_align": "left",
				"show_legend": true,
				"legend_layout": "auto",
				"legend_columns": [
					"avg",
					"min",
					"max",
					"value",
					"sum"
				],
				"type": "timeseries",
				"requests": [
					{
						"formulas": [
							{
								"formula": "(query1 / query2) * 100"
							}
						],
						"response_format": "timeseries",
						"queries": [
							{
								"query": "avg:kubernetes.memory.usage{$cluster_name_ext,$ocp_namespace_int} by {kube_container_name}",
								"data_source": "metrics",
								"name": "query1"
							},
							{
								"query": "avg:kubernetes.memory.limits{$cluster_name_ext,$ocp_namespace_int} by {kube_container_name}",
								"data_source": "metrics",
								"name": "query2"
							}
						],
						"style": {
							"palette": "dog_classic",
							"line_type": "solid",
							"line_width": "normal"
						},
						"display_type": "line"
					}
				],
				"yaxis": {
					"include_zero": true,
					"scale": "linear",
					"label": "",
					"min": "auto",
					"max": "auto"
				},
				"markers": []
			}
		}
	],
	"template_variables": [
		{
			"name": "subscription_name",
			"default": "poste-rdc-sviluppo",
			"prefix": "subscription_name",
			"available_values": [
				"poste-rdc-sviluppo",
				"poste-rdc-produzione",
				"poste-rdc-certificazione"
			]
		},
		{
			"name": "cluster_name_ext",
			"default": "gen3govazne",
			"prefix": "cluster",
			"available_values": [
				"gen3govazne",
				"gen3govazwe"
			]
		},
		{
			"name": "cluster_name_int",
			"default": "gen3govazne",
			"prefix": "cluster",
			"available_values": [
				"gen3gpazne",
				"gen3govazwe",
				"gen3govintazwe"
			]
		},
		{
			"name": "rg_decoder_ext",
			"default": "rg-decoder-ext-coll",
			"prefix": "resource_group",
			"available_values": [
				"rg-decoder-ext-cert",
				"rg-decoder-ext-coll",
				"rg-decoder-ext-prod",
				"rg-decoder-ext-svil"
			]
		},
		{
			"name": "rg_decoder_int",
			"default": "rg-decoder-int-svil",
			"prefix": "resource_group",
			"available_values": [
				"rg-decoder-int-svil",
				"rg-decoder-int-prod",
				"rg-decoder-int-cert",
				"rg-decoder-int-coll"
			]
		},
		{
			"name": "rg_decoder_common",
			"default": "rg-decoder-common-coll",
			"prefix": "resource_group",
			"available_values": [
				"rg-decoder-common-svil",
				"rg-decoder-common-prod",
				"rg-decoder-common-cert",
				"rg-decoder-common-coll"
			]
		},
		{
			"name": "rg_decoder_reports",
			"default": "rg-decoder-reports-coll",
			"prefix": "resource_group",
			"available_values": [
				"rg-decoder-reports-coll",
				"rg-decoder-reports-cert",
				"rg-decoder-reports-prod",
				"rg-decoder-reports-svil"
			]
		},
		{
			"name": "ocp_env",
			"default": "*",
			"prefix": "cluster_env",
			"available_values": [
				"cert",
				"coll",
				"svil",
				"prod"
			]
		},
		{
			"name": "ocp_namespace_ext",
			"default": "decoder-coll",
			"prefix": "kube_namespace",
			"available_values": [
				"decoder",
				"decoder-coll",
				"decoder-svil"
			]
		},
		{
			"name": "ocp_namespace_int",
			"default": "decoder-coll-int",
			"prefix": "kube_namespace",
			"available_values": [
				"decoder-coll-int",
				"decoder-int",
				"decoder-svil"
			]
		}
	],
	"layout_type": "free",
	"is_read_only": false,
	"notify_list": [],
	"id": "csn-cqg-8cj"
}
EOF
}