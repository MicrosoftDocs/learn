To control devices programmatically, you use the IoT Central REST API.

You want to enable your existing fleet management application to control devices connected your IoT Central application programmatically.

In this unit, you use the IoT Central REST API to query your devices, set a writeable property on a vehicle monitoring device, and then send a reboot command to the device.

*The query REST API is currently in preview.*

## View device telemetry

You can use the REST API to query for a device's telemetry measurement. Run the following commands to view the five last known location and temperature values from the **sim-truck-001** device. You may need to wait a few minutes before the simulated device starts sending telemetry and this command can run successfully:

```azurecli
# The FROM clause in the query needs the device template id.

TEMPLATE_ID=`az rest -m get -u https://$APP_NAME.azureiotcentral.com/api/devices/sim-truck-001 \
--url-parameters api-version=1.0 \
--headers Authorization="$OPERATOR_TOKEN" \
--query "template" -o tsv`

az rest -m post -u https://$APP_NAME.azureiotcentral.com/api/query \
--url-parameters api-version=1.1-preview \
--headers Authorization="$OPERATOR_TOKEN" Content-Type=application/json \
--body '{
    "query": "SELECT TOP 5 $id AS device-id, $ts AS timestamp, ContentsTemperature, Location FROM '"$TEMPLATE_ID"' WHERE device-id = '"'sim-truck-001'"' ORDER BY timestamp DESC"
}'
```

To learn more, see [How to use the IoT Central REST API to query devices](/azure/iot-central/core/howto-query-with-rest-api).

## View device properties

You can use the REST API to view device properties. Run the following command to retrieve the current properties from the **sim-truck-001** device. The property value was assigned by the simulation:

```azurecli
az rest -m get -u https://$APP_NAME.azureiotcentral.com/api/devices/sim-truck-001/properties \
--url-parameters api-version=1.0 \
--headers Authorization="$OPERATOR_TOKEN"
```

## Set a property

The refrigerated truck device template specified a **Target Temperature** property in the default component:

```json
{
  "@type": [
    "Property",
    "Temperature"
  ],
  "displayName": {
    "en": "Target Temperature"
  },
  "name": "TargetTemperature",
  "schema": "double",
  "unit": "degreeCelsius",
  "writable": true
}
```

Run the following command in the Cloud Shell to set the **Target Temperature** to **12.5** on the default component on one of the simulated devices in the application:

```azurecli
az rest -m put -u https://$APP_NAME.azureiotcentral.com/api/devices/sim-truck-001/properties \
--url-parameters api-version=1.0 \
--headers Authorization="$OPERATOR_TOKEN" --body \
'{
  "TargetTemperature": 12.5
}'

```

The response to this request echoes the requested value for the property to confirm the device received it.

Run the following command to see the new value for the property:

```azurecli
az rest -m get -u https://$APP_NAME.azureiotcentral.com/api/devices/sim-truck-001/properties \
--url-parameters api-version=1.0 \
--headers Authorization="$OPERATOR_TOKEN"
```

## Set a cloud property

*The cloud property REST APIs are currently in preview.*

The refrigerated truck device template specified a **Last maintenance date** cloud property in the solution model:

```json
{
  "@type": "CloudProperty",
  "displayName": "Last maintenance date",
  "name": "maintenancedate",
  "schema": "string",
  "valueDetail": {
    "@type": "StringValueDetail"
  }
}
```

Run the following command in the Cloud Shell to set the **Last maintenance date** to **12.5** for one of the real devices in the application:

```azurecli
az rest -m patch -u https://$APP_NAME.azureiotcentral.com/api/devices/real-truck-001/cloudProperties \
--url-parameters api-version=preview \
--headers Authorization="$OPERATOR_TOKEN" --body \
'{
  "maintenancedate": "December 2020"
}'
az rest -m get -u https://$APP_NAME.azureiotcentral.com/api/devices/real-truck-001/cloudProperties \
--url-parameters api-version=preview \
--headers Authorization="$OPERATOR_TOKEN"

```

## Send a command

The vehicle monitoring device template specified a **Get Max-Min report** command in the default component:

```json
{
  "@type": "Command",
  "name": "getMaxMinReport",
  "displayName": "Get Max-Min report.",
  "description": "This command returns the max, min and average temperature from the specified time to the current time.",
  "request": {
    "name": "since",
    "displayName": "Since",
    "description": "Period to return the max-min report.",
    "schema": "dateTime"
  },
  "response": {
    "name": "tempReport",
    "displayName": "Temperature Report",
    "schema": {
      "@type": "Object",
      "fields": [
        {
          "name": "maxTemp",
          "displayName": "Max temperature",
          "schema": "double"
        },
        {
          "name": "minTemp",
          "displayName": "Min temperature",
          "schema": "double"
        },
        {
          "name": "avgTemp",
          "displayName": "Average Temperature",
          "schema": "double"
        },
        {
          "name": "startTime",
          "displayName": "Start Time",
          "schema": "dateTime"
        },
        {
          "name": "endTime",
          "displayName": "End Time",
          "schema": "dateTime"
        }
      ]
    }
  }
}
```

Run the following command in the Cloud Shell to send a **Get Max-Min report** command to one of the simulated devices in the application. The **Get Max-Min report** command takes a parameter that specifies the the start of the time period for the report:

```azurecli
SINCE=`date -d "now -2 hours" -Ins`
az rest -m post -u https://$APP_NAME.azureiotcentral.com/api/devices/sim-truck-001/commands/getMaxMinReport \
--url-parameters api-version=1.0 \
--headers Authorization="$OPERATOR_TOKEN" --body \
'{
    "since": "'$SINCE'"
}'

```

You can view the command history for a command to retrieve the most recent response:

```azurecli
az rest -m get -u https://$APP_NAME.azureiotcentral.com/api/devices/sim-truck-001/commands/getMaxMinReport \
--url-parameters api-version=1.0 \
--headers Authorization="$OPERATOR_TOKEN"
```
