Using Azure CLI to implement automatic device management is functionality equivalent to the process for using automatic device management from the Azure portal.

## CLI prerequisites

 -  An IoT hub in your Azure subscription.
 -  Azure CLI in your environment. At a minimum, your Azure CLI version must be 2.0.24 or above. Use az –-version to validate. This version supports az extension commands and introduces the Knack command framework.
 -  The IoT extension for Azure CLI.

## Create a configuration

You configure target devices by creating a configuration that consists of the target content and metrics.

Use the following command to create a configuration:

```cli
  az iot hub configuration create --config-id [configuration id] \
    --labels [labels] --content [file path] --hub-name [hub name] \
    --target-condition [target query] --priority [int] \
    --metrics [metric queries]

```

 -  `--config-id` \- The name of the configuration that will be created in the IoT hub. Give your configuration a unique name that is up to 128 lowercase letters. Avoid spaces and the following invalid characters: `& ^ [ ] { } \ | " < > /`
 -  `--labels` \- Add labels to help track your configuration. Labels are Name, Value pairs that describe your deployment. For example, `HostPlatform`, `Linux` or `Version`, `3.0.1`
 -  `--content` \- Inline JSON or file path to the target content to be set as twin desired properties.
 -  `--hub-name` \- Name of the IoT hub in which the configuration will be created. The hub must be in the current subscription. Switch to the desired subscription with the command `az account set -s [subscription name]`
 -  `--target-condition` \- Enter a target condition to determine which devices will be targeted with this configuration. The condition is based on device twin tags or device twin desired properties and should match the expression format. For example, `tags.environment='test'` or `properties.desired.devicemodel='4000x'`.
 -  `--priority` \- A positive integer. When two or more configurations are targeted at the same device, the configuration with the highest numerical value for Priority will apply.
 -  `--metrics` \- Filepath to the metric queries. Metrics provide summary counts of the various states that a device may report back after applying configuration content. For example, you may create a metric for pending settings changes, a metric for errors, and a metric for successful settings changes.

## Monitor a configuration

Use the following command to display the contents of a configuration:

```cli
az iot hub configuration show --config-id [configuration id] \
  --hub-name [hub name]

```

 -  `--config-id` \- The name of the configuration that exists in the IoT hub.
 -  `--hub-name` \- Name of the IoT hub in which the configuration exists. The hub must be in the current subscription. Switch to the desired subscription with the command `az account set -s [subscription name]`

Inspect the configuration in the command window. The metrics property lists a count for each metric that is evaluated by each hub:

 -  **targetedCount** \- A system metric that specifies the number of device twins in IoT Hub that match the targeting condition.
 -  **appliedCount** \- A system metric specifies the number of devices that have had the target content applied.
 -  **Your custom metric** \- Any metrics you've defined are user metrics.

You can show a list of device IDs or objects for each of the metrics by using the following command:

```cli
az iot hub configuration show-metric --config-id [configuration id] \
  --metric-id [metric id] --hub-name [hub name] --metric-type [type]

```

 -  `--config-id` \- The name of the deployment that exists in the IoT hub.
 -  `--metric-id` \- The name of the metric for which you want to see the list of device IDs, for example `appliedCount`.
 -  `--hub-name` \- Name of the IoT hub in which the deployment exists. The hub must be in the current subscription. Switch to the desired subscription with the command `az account set -s [subscription name]`
 -  `--metric-type` \- Metric type can be `system` or `user`. System metrics are `targetedCount` and `appliedCount`. All other metrics are user metrics.

## Modify a configuration

When you modify a configuration, the changes immediately replicate to all targeted devices.

If you update the target condition, the following updates occur:

 -  If a device twin didn't meet the old target condition, but meets the new target condition and this configuration is the highest priority for that device twin, then this configuration is applied to the device twin.
 -  If a device twin no longer meets the target condition, the settings from the configuration will be removed and the device twin will be modified by the next highest priority configuration.
 -  If a device twin currently running this configuration no longer meets the target condition and doesn't meet the target condition of any other configurations, then the settings from the configuration will be removed and no other changes will be made on the twin.

Use the following command to update a configuration:

```cli
az iot hub configuration update --config-id [configuration id] \
  --hub-name [hub name] --set [property1.property2='value']

```

 -  `--config-id` \- The name of the configuration that exists in the IoT hub.
 -  `--hub-name` \- Name of the IoT hub in which the configuration exists. The hub must be in the current subscription. Switch to the desired subscription with the command `az account set -s [subscription name]`
 -  `--set` \- Update a property in the configuration. You can update the following properties:
    
     -  targetCondition - for example `targetCondition=tags.location.state='Oregon'`
     -  labels
     -  priority

## Delete a configuration

When you delete a configuration, any device twins take on their next highest priority configuration. If device twins don't meet the target condition of any other configuration, then no other settings are applied.

Use the following command to delete a configuration:

```cli
az iot hub configuration delete --config-id [configuration id] \
  --hub-name [hub name]

```

`--config-id` \- The name of the configuration that exists in the IoT hub.

`--hub-name` \- Name of the IoT hub in which the configuration exists. The hub must be in the current subscription. Switch to the desired subscription with the command `az account set -s [subscription name]`
