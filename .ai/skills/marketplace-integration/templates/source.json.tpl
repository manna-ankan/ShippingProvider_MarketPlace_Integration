// Deterministic stub for a new Mongo `source` document (marketplace/channel).
// Fill every {{PLACEHOLDER}}. Collection is `source` — NOT shippingSource.
// Do NOT include "_id". Mask secrets. Only include properties required by the ticket.
{
	"code" : "{{SOURCE_CODE}}",
	"name" : "{{SOURCE_DISPLAY_NAME}}",
	"enabled" : true,
	"priority" : {{PRIORITY_INTEGER}},
	"type" : "{{SOURCE_TYPE}}",
	"localization" : "{{LOCALIZATION}}",
	"created" : ISODate(),
	"updated" : ISODate(),
	"sourceProperties" : [
		{
			"sourceCode" : "{{SOURCE_CODE}}",
			"name" : "active",
			"value" : "true"
		},
		{
			"sourceCode" : "{{SOURCE_CODE}}",
			"name" : "order.sync.configured",
			"value" : "{{ORDER_SYNC_CONFIGURED_TRUE_FALSE}}"
		},
		{
			"sourceCode" : "{{SOURCE_CODE}}",
			"name" : "inventory.sync.configured",
			"value" : "{{INVENTORY_SYNC_CONFIGURED_TRUE_FALSE}}"
		},
		{
			"sourceCode" : "{{SOURCE_CODE}}",
			"name" : "allow.multiple.channel",
			"value" : "true"
		},
		{
			"sourceCode" : "{{SOURCE_CODE}}",
			"name" : "third.party.configuration.required",
			"value" : "false"
		},
		{
			"sourceCode" : "{{SOURCE_CODE}}",
			"name" : "notifications.enabled",
			"value" : "{{NOTIFICATIONS_ENABLED_TRUE_FALSE}}"
		},
		{
			"sourceCode" : "{{SOURCE_CODE}}",
			"name" : "process.notification.count",
			"value" : "1"
		},
		{
			"sourceCode" : "{{SOURCE_CODE}}",
			"name" : "process.inventory.count",
			"value" : "{{PROCESS_INVENTORY_COUNT}}"
		},
		{
			"sourceCode" : "{{SOURCE_CODE}}",
			"name" : "inventory.update.cron.expression",
			"value" : "0 0/10 * * * ?"
		},
		{
			"sourceCode" : "{{SOURCE_CODE}}",
			"name" : "sale.order.import.cron.expression",
			"value" : "0 0/10 * * * ?"
		},
		{
			"sourceCode" : "{{SOURCE_CODE}}",
			"name" : "shipment.label.format",
			"value" : "PDF"
		},
		{
			"sourceCode" : "{{SOURCE_CODE}}",
			"name" : "third.party.shipping.available",
			"value" : "true"
		},
		{
			"sourceCode" : "{{SOURCE_CODE}}",
			"name" : "reserved.keywords.for.short.name",
			"value" : "{{SOURCE_CODE}},DEMO,PRODUCTION,LTD,PVT"
		},
		{
			"sourceCode" : "{{SOURCE_CODE}}",
			"name" : "inventory.update.script.name",
			"value" : "{{INVENTORY_UPDATE_SCRIPT_NAME}}"
		},
		{
			"sourceCode" : "{{SOURCE_CODE}}",
			"name" : "notification.script.name",
			"value" : "{{NOTIFICATION_SCRIPT_NAME}}"
		},
		{
			"sourceCode" : "{{SOURCE_CODE}}",
			"name" : "utils.script",
			"value" : "{{UTILS_SCRIPT_NAME}}"
		}
		/* OPTIONAL — include only if ticket requires:
		   sale.order.list.script.name, sale.order.details.script.name,
		   sale.order.status.sync.script.name, sale.order.cancellation.script.name,
		   channel.item.type.*.script.name, api base URL properties, etc.
		*/
	],
	"sourceConfigurationParameters" : [
		/* Ticket-driven channel UI params — TEXT/CHECKBOX/SELECT/FORMULA */
	],
	"sourceConnectors" : [
		{
			"sourceCode" : "{{SOURCE_CODE}}",
			"name" : "{{CONNECTOR_NAME}}",
			"displayName" : "{{CONNECTOR_DISPLAY_NAME}}",
			"helpText" : null,
			"priority" : 1,
			"requiredInOrderSync" : {{REQUIRED_IN_ORDER_SYNC}},
			"requiredInInventorySync" : {{REQUIRED_IN_INVENTORY_SYNC}},
			"requiredInReconciliationSync" : false,
			"verificationScriptName" : "{{VERIFICATION_SCRIPT_NAME}}",
			"sourceConnectorParameters" : [
				{
					"sourceConnectorName" : "{{CONNECTOR_NAME}}",
					"name" : "{{PARAM_NAME}}",
					"displayName" : "{{PARAM_DISPLAY_NAME}}",
					"displayPlaceHolder" : "",
					"type" : "{{TEXT|PASSWORD|HIDDEN|CHECKBOX|READONLY}}",
					"priority" : 1,
					"encryptionRequired" : {{TRUE_FALSE}}
				}
			]
		}
	]
}
