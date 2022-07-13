To manage device templates and devices programmatically, you use the IoT Central REST API

You want to enable your existing fleet management application to manage device templates and devices your IoT Central application programmatically.

In this unit, you use the IoT Central REST API to add a device template to the application and then add some real and simulated devices.

## Add a device template

Typically, the device developer provides you with the device model and interface definitions for the device you're using. You can import the definitions manually in the web UI or use the REST API to add them programmatically.

The device template in this unit defines a [refrigerated truck device](https://raw.githubusercontent.com/Azure-Samples/iot-central-docs-samples/main/learn-rest-api/Refrigerated%20Truck.json) that sends temperature and location telemetry, has a target temperature property, and responds to a commands that request additional temperature information and reboot the device. The device template definition is stored in JSON file.

The format of device template JSON file is not the same as the format of a device model file. The device template file defines both cloud properties and the device model for the device.

Run the following commands in the Cloud Shell to add a device template in your IoT Central application:

```azurecli
# Download the device template JSON file
DEVICE_TEMPLATE=`curl https://raw.githubusercontent.com/Azure-Samples/iot-central-docs-samples/main/learn-rest-api/Refrigerated%20Truck.json`

# Add the device template to your IoT Central application
az rest -m put -u https://$APP_NAME.azureiotcentral.com/api/deviceTemplates/dtmi:contoso:refrigerated_truck \
  --url-parameters api-version=1.0 \
  --headers Authorization="$ADMIN_TOKEN" Content-Type=application/json \
  --body "$DEVICE_TEMPLATE"

# List the display names of all your device templates
az rest -m get -u https://$APP_NAME.azureiotcentral.com/api/deviceTemplates \
  --url-parameters api-version=1.0 \
  --headers Authorization="$ADMIN_TOKEN" \
  --query 'value[].displayName'

```

## Add simulated devices

Now that you've added a device template that specifies the capabilities of the refrigerated truck device you're using, you can start adding devices to your application.

Run the following commands in the Cloud Shell to add three simulated devices using the device template you added. The final command lists the devices you added and uses a query to simplify the output:

```azurecli
az rest -m put -u https://$APP_NAME.azureiotcentral.com/api/devices/sim-truck-001 \
--url-parameters api-version=1.0 \
--headers Authorization="$OPERATOR_TOKEN" --body \
'{
  "template": "dtmi:contoso:refrigerated_truck",
  "simulated": true,
  "displayName": "Simulated refrigerated truck - 001"
}'

az rest -m put -u https://$APP_NAME.azureiotcentral.com/api/devices/sim-truck-002 \
--url-parameters api-version=1.0 \
--headers Authorization="$OPERATOR_TOKEN" --body \
'{
  "template": "dtmi:contoso:refrigerated_truck",
  "simulated": true,
  "displayName": "Simulated refrigerated truck - 002"
}'

az rest -m put -u https://$APP_NAME.azureiotcentral.com/api/devices/sim-truck-003 \
--url-parameters api-version=1.0 \
--headers Authorization="$OPERATOR_TOKEN" --body \
'{
  "template": "dtmi:contoso:refrigerated_truck",
  "simulated": true,
  "displayName": "Simulated refrigerated truck - 003"
}'

az rest -m get -u https://$APP_NAME.azureiotcentral.com/api/devices \
--url-parameters api-version=1.0 \
--headers Authorization="$OPERATOR_TOKEN" \
--query 'value[].{ID:id, Type:template, Simulated:simulated, Provisioned:provisioned}' -o table
```

## Add real devices

Run the following commands in the Cloud Shell to add three real devices using the device template you added. The final command lists the devices you added and uses a query to simplify the output:

```azurecli
az rest -m put -u https://$APP_NAME.azureiotcentral.com/api/devices/real-truck-001 \
--url-parameters api-version=1.0 \
--headers Authorization="$OPERATOR_TOKEN" --body \
'{
  "template": "dtmi:contoso:refrigerated_truck",
  "simulated": false,
  "displayName": "Real refrigerated truck - 001"
}'

az rest -m put -u https://$APP_NAME.azureiotcentral.com/api/devices/real-truck-002 \
--url-parameters api-version=1.0 \
--headers Authorization="$OPERATOR_TOKEN" --body \
'{
  "template": "dtmi:contoso:refrigerated_truck",
  "simulated": false,
  "displayName": "Real refrigerated truck - 002"
}'

az rest -m put -u https://$APP_NAME.azureiotcentral.com/api/devices/real-truck-003 \
--url-parameters api-version=1.0 \
--headers Authorization="$OPERATOR_TOKEN" --body \
'{
  "template": "dtmi:contoso:refrigerated_truck",
  "simulated": false,
  "displayName": "Real refrigerated truck - 003"
}'

az rest -m get -u https://$APP_NAME.azureiotcentral.com/api/devices \
--url-parameters api-version=1.0 \
--headers Authorization="$OPERATOR_TOKEN" \
--query 'value[].{ID:id, Type:template, Simulated:simulated, Provisioned:provisioned}' -o table
```

## Connect a real device

To connect a real device to your IoT Central application, you need the real device's credentials. You can use the REST API to retrieve the SAS key for a device from IoT Central as follows:

```azurecli
az rest -m get -u https://$APP_NAME.azureiotcentral.com/api/devices/real-truck-003/credentials \
--url-parameters api-version=1.0 \
--headers Authorization="$OPERATOR_TOKEN"
```

## Block a device

You can use the REST API to block and unblock devices. Blocking a device prevents it from connecting to your application. Run the following commands to block a device and then check the status values for your devices:

```azurecli
az rest -m patch -u https://$APP_NAME.azureiotcentral.com/api/devices/sim-truck-002 \
--url-parameters api-version=1.0 \
--headers Authorization="$OPERATOR_TOKEN" \
--body \
'{
  "enabled": false
}'

az rest -m get -u https://$APP_NAME.azureiotcentral.com/api/devices \
--url-parameters api-version=1.0 \
--headers Authorization="$OPERATOR_TOKEN" \
--query 'value[].{ID:id, Type:instanceOf, Unblocked:enabled, Simulated:simulated, Provisioned:provisioned}' -o table
```
