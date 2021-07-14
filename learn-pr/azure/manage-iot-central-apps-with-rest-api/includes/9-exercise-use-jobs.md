To manage the devices connected to your application in bulk, you use the jobs REST APIs.

*The jobs REST APIs are currently in preview.*

You want to enable your existing fleet management application to manage jobs in your IoT Central application programmatically.

In this unit, you create and run a job that reboots all the refrigerated truck devices. When the job completes, you check the results for any failed devices. If any devices fail, you fix the issue and rerun the job.

You then run a job to set the target temperature for all the refrigerated truck devices.

## Create and run a command job

Before you can create and run a job, you need the ID of the device group that you're targeting. In the application you're using, there's a device group called **Refrigerated truck - All devices**. This device group was created automatically when you added the refrigerated truck device template.

Run the following command in the Cloud Shell to retrieve the ID of this device group. The `deviceGroups` API is currently in preview:

```azurecli
DEVICE_GROUP=`az rest -m get -u https://$APP_NAME.azureiotcentral.com/api/deviceGroups \
  --url-parameters api-version=preview \
  --headers Authorization="$OPERATOR_TOKEN" \
  --query "value[?contains(displayName,'Refrigerated truck')].id" -o tsv`
echo $DEVICE_GROUP
```

Run the following command to create and run a job that calls the **Reboot** command on all the devices in the device group. The **Reboot** command has a parameter that specifies, in seconds, how long to wait before rebooting. The job is called `rebootjob`. The various `jobs` APIs are currently in preview:

```azurecli
az rest -m put -u https://$APP_NAME.azureiotcentral.com/api/jobs/rebootjob \
  --url-parameters api-version=preview \
  --headers Authorization="$OPERATOR_TOKEN" --body \
'{
  "data": [
    {
      "path": "reboot",
      "target": "dtmi:contoso:refrigerated_truck",
      "type": "CommandJobData",
      "value": 10
    }
  ],
  "description": "Reboot all connected trucks in 10 seconds",
  "displayName": "Reboot all trucks",
  "group": "'$DEVICE_GROUP'"
}'
```

The output from the previous command includes the initial status value of **Pending**. Run the following command to check the status:

```azurecli
az rest -m get -u https://$APP_NAME.azureiotcentral.com/api/jobs \
  --url-parameters api-version=preview \
  --headers Authorization="$OPERATOR_TOKEN" \
  --query "value[].{Name:displayName, Status:status, ID:id}" -o table
```

Use the following command to check the status of the individual devices:

```azurecli
az rest -m get -u https://$APP_NAME.azureiotcentral.com/api/jobs/rebootjob/devices \
  --url-parameters api-version=preview \
  --headers Authorization="$OPERATOR_TOKEN" \
  --query "value[].{ID:id, Status:status}" -o table
```

The output from the previous command shows four failed devices. The job failed on the three real devices because they're not connected to your application. The job also fails on the simulated device you blocked in a previous exercise because it's also not currently connected. The following commands unblock the device and reruns the command using `reboot-001` as the job name:

```azurecli
az rest -m patch -u https://$APP_NAME.azureiotcentral.com/api/devices/sim-truck-002 \
  --url-parameters api-version=1.0 \
  --headers Authorization="$OPERATOR_TOKEN" \
  --body \
'{
  "enabled": true
}'
az rest -m put -u https://$APP_NAME.azureiotcentral.com/api/jobs/rebootjob/rerun/reboot-001 \
--url-parameters api-version=preview \
--headers Authorization="$OPERATOR_TOKEN"
```

If you re-check the results, you can see that rerunning the job only tried the devices that failed previously:

```azurecli
az rest -m get -u https://$APP_NAME.azureiotcentral.com/api/jobs \
--url-parameters api-version=preview \
--headers Authorization="$OPERATOR_TOKEN" \
--query "value[].{Name:displayName, Status:status, ID:id}" -o table

az rest -m get -u https://$APP_NAME.azureiotcentral.com/api/jobs/reboot-001/devices \
--url-parameters api-version=preview \
--headers Authorization="$OPERATOR_TOKEN" \
--query "value[].{ID:id, Status:status}" -o table
```

## Create and run a property job

Run the following command to create and run a job that updates the `targetTemperature` writable property on all the devices in the **Refrigerated truck - All devices** device group. The type of this property is a double. The job is called `targettempjob`:

```azurecli
az rest -m put -u https://$APP_NAME.azureiotcentral.com/api/jobs/targettempjob \
--url-parameters api-version=preview \
--headers Authorization="$OPERATOR_TOKEN" --body \
'{
  "data": [
    {
      "path": "TargetTemperature",
      "target": "dtmi:contoso:refrigerated_truck",
      "type": "PropertyJobData",
      "value": 14.5
    }
  ],
  "description": "Update the target temperatures for multiple trucks",
  "displayName": "Update target temperatures",
  "group": "'$DEVICE_GROUP'"
}'
```

You can use the following commands to check the job and device status values. This job succeeds on all the devices because property updates are queued until the device connects:

```azurecli
az rest -m get -u https://$APP_NAME.azureiotcentral.com/api/jobs \
--url-parameters api-version=preview \
--headers Authorization="$OPERATOR_TOKEN" \
--query "value[].{Name:displayName, Status:status, ID:id}" -o table

az rest -m get -u https://$APP_NAME.azureiotcentral.com/api/jobs/targettempjob/devices \
--url-parameters api-version=preview \
--headers Authorization="$OPERATOR_TOKEN" \
--query "value[].{ID:id, Status:status}" -o table
```
