When creating Azure resources, it is essential to adopt a sensible naming convention that scales well and complies with the naming rules and restrictions. The restrictions and recommendations are available online:

 -  [Naming rules and restrictions for Azure resources](/azure/azure-resource-manager/management/resource-name-rules)
 -  [Recommended naming and tagging conventions](/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging)

During this training, you will be creating Azure resources that are used to develop your IoT solution. To ensure consistency across the labs and to help in tidying up resources whenever you have finished with them, the lab instructions will include resource names that you should use. These names comply with many of the conventions suggested above. Many of these resources expose services that can be consumed across the web, which means they must have globally unique names. To achieve this, you will be using a unique identifier that will be added to the end of the resource name. The following instructions will help you to create your unique ID.

## Unique ID

Your unique ID will be constructed using your initials and the current date using the following pattern:

```text
YourInitialsYYMMDD

```

So, your initials (lower case) followed by the last two digits of the year, the current numeric month, and the numeric day. Here are some examples:

```text
cah210913
dm210920

```

Whenever you are expected to use your unique ID, you will see `{your-id}`. You will replace the entire string (including the `{}`) with your unique value.

Make a note of your unique ID now and **use the same value through the entire course** \- don't update the date each day.

Let's review some examples of resources and the names associated with them.

## Resource groups

A Resource Group must have a unique name within a subscription, however it does not need to be globally unique. Therefore, throughout this course you will be using the resource group name: **rg-az220**.

```
**Information:** Resource Group Name - **rg-az220**

```

## Publicly visible resources

Many of the resources that you create will have publicly addressable (although secured) endpoints and therefore must be globally unique. Examples of publicly addressable resources include IoT Hubs, Device Provisioning Services, and Azure Storage Accounts. For each of these, you will be provided with a name template and expected to replace `{your-id}` with your unique ID. Here are some examples:

If your Unique ID is: **cah210913**

:::row:::
  :::column:::
    **Resource Type**
  :::column-end:::
  :::column:::
    **Name Template**
  :::column-end:::
  :::column:::
    **Example**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    IoT Hub
  :::column-end:::
  :::column:::
    iot-az220-training-\{your-id\}
  :::column-end:::
  :::column:::
    iot-az220-training-cah210913
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Device Provisioning Service
  :::column-end:::
  :::column:::
    dps-az220-training-\{your-id\}
  :::column-end:::
  :::column:::
    dps-az220-training-cah210913
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Azure Storage Account
(name must be lower-case and no dashes)
  :::column-end:::
  :::column:::
    az220storage\{your-id\}
  :::column-end:::
  :::column:::
    az220storagecah210913
  :::column-end:::
:::row-end:::


In addition to supplying a unique ID in the Azure portal, you may also be required to update values within bash scripts and C\# source files. Here are some examples:

```bash
#!/bin/bash

YourID="{your-id}"
RGName="rg-az220"
IoTHubName="iot-az220-training-$YourID"

```

In the code above, if the value of your unique ID is `cah210913`, then the line containing `YourID="{your-id}"` should be updated to `YourID="cah210913"`.

> [!NOTE]
> Notice that you do not change the \`$YourID\` value on the final code line. If it isn't \`\{your-id\}\` then don't replace it.

Similarly, in C\# you might see:

```csharp
private string _yourId = "{your-id}";
private string _rgName = "rg-az220";
private string _iotHubName = $"iot-az220-training-{_yourId}";

```

In the code above, if the value of your unique ID is `cah210913`, then the line containing `private string _yourId = "{your-id}";` should be updated to `private string _yourId = "cah210913";`

> [!NOTE]
> Notice that you do not change the \`\_yourId\` value on the final code line. Once again, if it isn't \`\{your-id\}\` then don't replace it.
