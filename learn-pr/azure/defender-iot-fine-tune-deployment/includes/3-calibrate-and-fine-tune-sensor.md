Data is now flowing from your sensor to Microsoft Defender for IoT. The operational technology (OT) monitoring software initially identifies the interfaces and device endpoints.

The OT sensor software analyzes your system and assigns subnet settings, including security settings, and attempts to understand the architecture of your system and fit each device into the Purdue model setup. However, it's possible that some of these subnet and device settings might not be correctly identified, so you need to check each one.

A subnet is a group of devices or interfaces that have a specific purpose or are located in a specific area, for example all of the printers in the main offices, all of the lights in the manufacturing level, all heating systems in the administrative rooms. Each subnet is assigned its own IP address.

## Calibrate your sensor

Once your OT sensor is receiving data, make an initial check to see that the sensor identifies each device with the correct subnet, this is called calibration. In the **Deployment** section of the OT sensor run the **Analyze** feature. When the analysis is complete, check the information. If the information isn't what you expect, check the subnet and device settings and make any changes to the settings.

In a real life scenario, incorrect subnet settings could be due to incorrect span configuration, which should be reported to the connection team.

## Fine tune the sensor results

Now that the sensor is calibrated, check the data and fine tune any items that the sensor has misidentified, such as the device details, or which subnet a device is connected to. In some cases, you need to reassign the settings or location of the device in the Purdue levels by updating the subnet. The IP and subnet addresses should be available from your IT team or be listed in the planning document.

### Check and modify the subnet settings

The OT sensor software identifies the subnets within your system. However, you might need to correct some of the subnet settings or update the list of subnets. This is the most important part of the fine tuning process. Any subnets that aren't listed and configured are considered external networks. All of the devices connected to a listed subnet are called *local* devices, while the devices connected to unlisted subnets are called *routed*.

The subnet settings are changed manually, either by changing the subnet data or adding a new subnet. To make changes, you need the subnet:

- IP address
- Mask
- Name to assign

We recommend giving a meaningful name that specifies the subnet's network role. Subnet names can have up to 60 characters.

You might also want to define the subnet as a segregated subnet, meaning the subnet is displayed separately in the device map for the Purdue levels view.

### Update device details

Check the device details in the **Device inventory**. You might need to make some of the following changes:

| Action | Description |
|----|----|
|**Merge devices** | In some cases, a device might be listed more than once. This could happen when a device has two or more connectors to the sensor, for example a laptop with both Wifi and a physical network card. In such a situation, you need to merge them together, using the **Merge** option in the **Device inventory** page. The new merged device listing contains all of the data from both merged devices.|
|**Important devices**| Devices can also be assigned as *Important*, which gives the device a greater security rating for features such as running an Attack vector or Risk assessment. So that the device is considered more important than other devices for these reports.<br><br>The *Important* setting is also useful to differentiate between similar types of devices, where some of the devices are important to your system, but the others aren't. For example, if you have a vital cooling system and a set of air conditioning units, only set the cooling system as *important*.<br><br>The device appears in the device map with a star on it.|
|**Check public IP addresses**| It's important to identify any public IP addresses that are used internally. These IP addresses must be added as a separate subnet within the Subnet settings. If a public IP address isn't listed, the sensor treats it as a public network for security settings.|
|**Schedule DNS lookup**| Enhance device data enrichment by configuring multiple DNS servers to carryout reverse lookups and resolve host names or FQDNs associated with the IP addresses detected in network subnets. You need the DNS server address, server port and the subnet addresses.|
|**DHCP address ranges**| Devices with an IP address allocated by a DHCP server, which changes dynamically, must define the range of IP addresses. This is an important step, which can affect the way your data is assessed for security risks. When the device IP address changes dynamically the device is logged as a new device, which might give misleading information about your system.|

After checking and updating the devices the fine tuning phase is complete.
