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
	"title": "Dashboard from IaC",
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
				"text": "SQL DB",
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
								"query": "avg:azure.sql_servers_databases.status{$var_1} by {name}",
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
		}
	],
	"template_variables": [
		{
			"name": "var_1",
			"default": "prova1",
			"prefix": "var_1",
			"available_values": [
				"prova1",
				"prova2",
				"prova3"
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
