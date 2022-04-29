A baseline establishes standard behavior for each device and makes it easier to establish unusual behavior or deviation from expected norms. Baseline custom checks establish a custom list of checks for each device baseline using the Module identity twin of the device.

## Setting baseline properties

1.  In your IoT Hub, locate and select the device you wish to change.
2.  Select on the device, and then select the azureiotsecurity module.
3.  Select Module Identity Twin.
4.  Upload the baseline custom checks file to the device.
5.  Add baseline properties to the security module and select Save.

### Baseline custom check file example

To configure baseline custom checks:

```json
"desired": {
   "ms_iotn:urn_azureiot_Security_SecurityAgentConfiguration": {
     "baselineCustomChecksEnabled": {
       "value" : true
     },
     "baselineCustomChecksFilePath": {
       "value" : "/home/user/full_path.xml"
     },
     "baselineCustomChecksFileHash": {
       "value" : "#hashexample!"
     }
   }
},

```

## Baseline custom check properties

:::row:::
  :::column:::
    **Name**
  :::column-end:::
  :::column:::
    **Status**
  :::column-end:::
  :::column:::
    **Valid values**
  :::column-end:::
  :::column:::
    **Default values**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    baselineCustomChecksEnabled
  :::column-end:::
  :::column:::
    Required: true
  :::column-end:::
  :::column:::
    Valid values: Boolean
  :::column-end:::
  :::column:::
    Default value: false
  :::column-end:::
  :::column:::
    Max time interval before high priority messages is sent.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    baselineCustomChecksFilePath
  :::column-end:::
  :::column:::
    Required: true
  :::column-end:::
  :::column:::
    Valid values: String, null
  :::column-end:::
  :::column:::
    Default value: null
  :::column-end:::
  :::column:::
    Full path of the baseline xml configuration.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    baselineCustomChecksFileHash
  :::column-end:::
  :::column:::
    Required: true
  :::column-end:::
  :::column:::
    Valid values: String, null
  :::column-end:::
  :::column:::
    Default value: null
  :::column-end:::
  :::column:::
    sha256sum of the xml configuration file. Use the sha256sum reference for additional information.
  :::column-end:::
:::row-end:::
