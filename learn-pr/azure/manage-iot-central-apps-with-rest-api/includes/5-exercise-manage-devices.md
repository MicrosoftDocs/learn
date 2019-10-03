To manage device templates and devices programmatically, you use the IoT Central REST API

You want to enable your existing store management application to manage device templates and devices your IoT Central application programmatically.

In this unit, you use the IoT Central REST API to add a device template to the application and then add some real and simulated devices.

## Add a device template

Typically, the device developer provides you with the device capability model and interface definitions for the device you're using. You can import the definitions manually in the web UI or use the REST API to add the programmatically.

Run the following command in the Cloud Shell to add a device template in your IoT Central application. The template defines a store monitoring device that sends temperature and humidity telemetry, has brightness property, and responds to a reboot command:

```azurecli
az rest -m post -u https://$APP_NAME.azureiotcentral.com/api/preview/models \
--headers Authorization="$API_TOKEN" --body \
'{
  "@id": "urn:contoso:store_monitoring_device:1",
  "@type": "DeviceModelDefinition",
  "displayName": "Store monitoring device",
  "capabilityModel": {
      "@id": "urn:contoso:store_monitor_dcm:1",
      "@type": "CapabilityModel",
      "displayName": "Environment Sensor Capability Model",
      "implements": [
        {
              "@id": "urn:contoso:store_monitor:sensor:1",
              "@type": "InterfaceInstance",
              "name": "sensor",
              "schema": {
                  "@id": "urn:contoso:EnvironmentalSensor_api:1",
                  "@type": "Interface",
                  "displayName": "Environmental Sensor",
                  "contents": [
                    {
                          "@type": "Telemetry",
                          "description": "Current temperature on the device",
                          "displayName": "Temperature",
                          "name": "temp",
                          "schema": "double",
                          "unit": "Units/Temperature/fahrenheit"
                      },
                      {
                          "@type": "Telemetry",
                          "description": "Current humidity on the device",
                          "displayName": "Humidity",
                          "name": "humid",
                          "schema": "double",
                          "unit": "Units/Humidity/percent"
                      },
                      {
                          "@type": "Property",
                          "description": "The brightness level for the light on thdevice. Can be specified as 1 (high), 2 (medium), 3 (low)",
                          "displayName": "Brightness Level",
                          "name": "brightness",
                          "writable": true,
                          "schema": "long"
                      },
                      {
                          "@type": "Command",
                          "commandType": "synchronous",
                          "comment": "This command reboots the device.",
                          "name": "reboot"
                      }
                  ]
              }
        }
    ],
      "contents": []
  },
  "solutionModel": {
      "@type": "SolutionModel",
      "cloudProperties": [
        {
              "@type": "CloudProperty",
              "displayName": "Store Name",
              "name": "StoreName",
              "schema": "string",
              "valueDetail": {
                  "@type": "ValueDetail/StringValueDetail"
              }
          }
      ],
      "initialValues": [],
      "overrides": []
  },
  "@context": "https://apps.azureiotcentral.com/api/preview/context/ModelDefinition.json"
}'
```

## Add simulated devices

Now that you've added a device template that specifies the capabilities of the store monitoring device you're using, you can start adding devices to your application.

Run the following commands in the Cloud Shell to add three simulated devices using the device template you added. The final command lists the devices you added and uses a query to simplify the output:

```azurecli
az rest -m post -u https://$APP_NAME.azureiotcentral.com/api/preview/devices \
--headers Authorization="$API_TOKEN" --body \
'{
  "@type": "Device",
  "instanceOf": "urn:contoso:store_monitoring_device:1",
  "simulated": true,
  "deviceId": "storemon-sim-001",
  "displayName": "Simulated store monitoring device - 001"
}'

az rest -m post -u https://$APP_NAME.azureiotcentral.com/api/preview/devices \
--headers Authorization="$API_TOKEN" --body \
'{
  "@type": "Device",
  "instanceOf": "urn:contoso:store_monitoring_device:1",
  "simulated": true,
  "deviceId": "storemon-sim-002",
  "displayName": "Simulated store monitoring device - 002"
}'

az rest -m post -u https://$APP_NAME.azureiotcentral.com/api/preview/devices \
--headers Authorization="$API_TOKEN" --body \
'{
  "@type": "Device",
  "instanceOf": "urn:contoso:store_monitoring_device:1",
  "simulated": true,
  "deviceId": "storemon-sim-003",
  "displayName": "Simulated store monitoring device - 003"
}'

az rest -m get -u https://$APP_NAME.azureiotcentral.com/api/preview/devices \
--headers Authorization="$API_TOKEN" \
--query 'value[].{ID:deviceId, Type:instanceOf, Simulated:simulated}' -o table
```

## Add real devices

Run the following commands in the Cloud Shell to add three real devices using the device template you added. The final command lists the devices you added and uses a query to simplify the output:

```azurecli
az rest -m post -u https://$APP_NAME.azureiotcentral.com/api/preview/devices \
--headers Authorization="$API_TOKEN" --body \
'{
  "@type": "Device",
  "instanceOf": "urn:contoso:store_monitoring_device:1",
  "simulated": false,
  "deviceId": "storemon-real-001",
  "displayName": "Real store monitoring device - 001"
}'

az rest -m post -u https://$APP_NAME.azureiotcentral.com/api/preview/devices \
--headers Authorization="$API_TOKEN" --body \
'{
  "@type": "Device",
  "instanceOf": "urn:contoso:store_monitoring_device:1",
  "simulated": false,
  "deviceId": "storemon-real-002",
  "displayName": "Real store monitoring device - 002"
}'

az rest -m post -u https://$APP_NAME.azureiotcentral.com/api/preview/devices \
--headers Authorization="$API_TOKEN" --body \
'{
  "@type": "Device",
  "instanceOf": "urn:contoso:store_monitoring_device:1",
  "simulated": false,
  "deviceId": "storemon-real-003",
  "displayName": "Real store monitoring device - 003"
}'

az rest -m get -u https://$APP_NAME.azureiotcentral.com/api/preview/devices \
--headers Authorization="$API_TOKEN" \
--query 'value[].{ID:deviceId, Type:instanceOf, Simulated:simulated}' -o table
```
