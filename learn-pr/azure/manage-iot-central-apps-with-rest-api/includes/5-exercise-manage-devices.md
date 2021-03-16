To manage device templates and devices programmatically, you use the IoT Central REST API

You want to enable your existing fleet management application to manage device templates and devices your IoT Central application programmatically.

In this unit, you use the IoT Central REST API to add a device template to the application and then add some real and simulated devices.

## Add a device template

Typically, the device developer provides you with the device capability model and interface definitions for the device you're using. You can import the definitions manually in the web UI or use the REST API to add the programmatically.

Run the following command in the Cloud Shell to add a device template in your IoT Central application. The template defines a [refrigerated truck device](https://raw.githubusercontent.com/Azure-Samples/iot-central-docs-samples/master/learn-rest-api/Refrigerated%20Truck.json) that sends temperature and location telemetry, has a target temperature property, and responds to a command that requests additional temperature information:

```azurecli
# Download a copy of the refrigerated truck device template JSON file
DEVICE_MODEL=`curl https://raw.githubusercontent.com/Azure-Samples/iot-central-docs-samples/master/learn-rest-api/Refrigerated%20Truck.json`

# Add the device template to your IoT Central application
az rest -m put -u https://$APP_NAME.azureiotcentral.com/api/preview/deviceTemplates/refigerated_truck_device \
--headers Authorization="$ADMIN_TOKEN" Content-Type=application/json \
--body "$DEVICE_MODEL"

# List the display names of all your device templates
az rest -m get -u https://$APP_NAME.azureiotcentral.com/api/preview/deviceTemplates /
--headers Authorization="$ADMIN_TOKEN" /
--query 'value[].displayName'
```
<!-- Does the new query feature let you list the templates in a better way? Similarly below listing the devices? -->

## Add simulated devices

Now that you've added a device template that specifies the capabilities of the refrigerated truck device you're using, you can start adding devices to your application.

Run the following commands in the Cloud Shell to add three simulated devices using the device template you added. The final command lists the devices you added and uses a query to simplify the output:

```azurecli
az rest -m put -u https://$APP_NAME.azureiotcentral.com/api/preview/devices/sim-truck-001 \
--headers Authorization="$ADMIN_TOKEN" --body \
'{
  "instanceOf": "refigerated_truck_device",
  "simulated": true,
  "displayName": "Simulated refrigerated truck - 001",
  "approved": true
}'

az rest -m put -u https://$APP_NAME.azureiotcentral.com/api/preview/devices/sim-truck-002 \
--headers Authorization="$ADMIN_TOKEN" --body \
'{
  "instanceOf": "refigerated_truck_device",
  "simulated": true,
  "displayName": "Simulated refrigerated truck - 002",
  "approved": true
}'

az rest -m put -u https://$APP_NAME.azureiotcentral.com/api/preview/devices/sim-truck-003 \
--headers Authorization="$ADMIN_TOKEN" --body \
'{
  "instanceOf": "refigerated_truck_device",
  "simulated": true,
  "displayName": "Simulated refrigerated truck - 003",
  "approved": true
}'

az rest -m get -u https://$APP_NAME.azureiotcentral.com/api/preview/devices \
--headers Authorization="$ADMIN_TOKEN" \
--query 'value[].{ID:id, Type:instanceOf, Simulated:simulated}' -o table
```

## Add real devices

Run the following commands in the Cloud Shell to add three real devices using the device template you added. The final command lists the devices you added and uses a query to simplify the output:

```azurecli
az rest -m put -u https://$APP_NAME.azureiotcentral.com/api/preview/devices/real-truck-001 \
--headers Authorization="$ADMIN_TOKEN" --body \
'{
  "instanceOf": "refigerated_truck_device",
  "simulated": false,
  "displayName": "Real refrigerated truck - 001",
  "approved": true
}'

az rest -m put -u https://$APP_NAME.azureiotcentral.com/api/preview/devices/real-truck-002 \
--headers Authorization="$ADMIN_TOKEN" --body \
'{
  "instanceOf": "refigerated_truck_device",
  "simulated": false,
  "displayName": "Real refrigerated truck - 002",
  "approved": true
}'

az rest -m put -u https://$APP_NAME.azureiotcentral.com/api/preview/devices/real-truck-003 \
--headers Authorization="$ADMIN_TOKEN" --body \
'{
  "instanceOf": "refigerated_truck_device",
  "simulated": false,
  "displayName": "Real refrigerated truck - 003",
  "approved": true
}'

az rest -m get -u https://$APP_NAME.azureiotcentral.com/api/preview/devices \
--headers Authorization="$ADMIN_TOKEN" \
--query 'value[].{ID:id, Type:instanceOf, Simulated:simulated}' -o table
```

## Connect a real device

To connect a real device to your IoT Central application, you need the real device's credentials. You can use the REST API to retrieve the SAS key for a device from IoT Central as follows:

```azurecli
az rest -m get -u https://$APP_NAME.azureiotcentral.com/api/preview/devices/real-truck-003/credentials \
--headers Authorization="$ADMIN_TOKEN"
```

## View device telemetry

You can use the REST API to view the last known value for a device's telemetry measurement. Run the following commands to view the last known location and temperature values from the **sim-truck-001** device. You may need to wait a few minutes before the simulated device starts sending telemetry and this command can run successfully:

```azurecli
az rest -m get -u https://$APP_NAME.azureiotcentral.com/api/preview/devices/sim-truck-001/telemetry/Location \
--headers Authorization="$ADMIN_TOKEN"
az rest -m get -u https://$APP_NAME.azureiotcentral.com/api/preview/devices/sim-truck-001/telemetry/ContentsTemperature \
--headers Authorization="$ADMIN_TOKEN"
```

## View device properties

You can use the REST API to view device properties. Run the following command to retrieve the current properties from the **sim-truck-001** device. The property value was assigned by the simulation:

```azurecli
az rest -m get -u https://$APP_NAME.azureiotcentral.com/api/preview/devices/sim-truck-001/properties \
--headers Authorization="$ADMIN_TOKEN"
```

## Block and unblock a device

You can use the REST API to block and unblock devices. Blocking a device prevents it from sending any telemetry or updated property values. Run the following commands to block a device and then check the status values for your devices:

<!-- This needs updating to block rather than approve -->
```azurecli
az rest -m patch -u https://$APP_NAME.azureiotcentral.com/api/preview/devices/sim-truck-002 \
--headers Authorization="$ADMIN_TOKEN" \
--body \
'{
  "approved": false
}'

az rest -m get -u https://$APP_NAME.azureiotcentral.com/api/preview/devices \
--headers Authorization="$ADMIN_TOKEN" \
--query 'value[].{ID:id, Type:instanceOf, Approved:approved, Simulated:simulated}' -o table
```