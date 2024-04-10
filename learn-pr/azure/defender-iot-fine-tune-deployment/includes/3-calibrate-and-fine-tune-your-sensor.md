Data is now flowing from your sensor to Microsoft Defender for IoT. The Operational Technology (OT) monitoring software initially identifies the interfaces and device endpoints. The OT software builds a map of the devices in the system, the subnets they're connected to and gives security settings to each one.

However, it's possible that some of these device settings might not be correctly identified, so you need to check each one. In some cases, you need to reassign the settings or location of the device in the Purdue levels by updating the subnet. The IP and subnet addresses should be available from your IT team or be listed in the planning document.<!-- should be / are available LW-->

The OT sensor analyzes the subnets. A subnet is a group of devices or interfaces that have a specific purpose or are located in a specific area, for example all of the printers in the main offices, all of the lights in the manufacturing level, all heating systems in the administrative rooms. Each subnet is assigned its own IP address.
OR
The OT sensor analyzes your system and assigns subnet settings and attempts to understand the architecture of your system and fit each device into the Purdue model setup. In some cases, the device map produced needs to be corrected. You might need to change device settings that are associated with the wrong subnet and ensure that they have the correct IP address.

## Calibration

Calibrate the sensor by running the **Analyze** feature in the **Deployment** section of the OT sensor to get an initial . When the analysis is complete, check the information for each interface. If the information isn't what you expected, you need to check the subnet and device settings and make any changes needed.<!-- span configuration - we will assume that these are correctly set, in the LM, but if not then you should go to your connection team and get them to fix this - Sagi -->

## Fine tuning

gdgfdgd

### Check and modify the subnet settings
<!-- highlight this is the most important piece, every thing after is secondary  -->
The OT sensor software identifies the subnets within your system. However, you might need to correct some of the subnet settings or update the list of subnets. Any subnets that aren't listed and configured are considered external networks. All of the devices connected to a listed subnet are called *local* devices, while the devices connected to unlisted subnets are called *routed*.

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
|**Important devices**| devices can also be assigned as *Important*, which gives the device a greater security rating for features such as running an Attack vector or Risk assessment. So that the device is considered more important than other devices for these reports.<br><br>The *Important* setting is also useful to differentiate between similar types of devices, where some of the devices are important to your system, but the others aren't. For example, if you have a vital cooling system and a set of air conditioning units, only set the cooling system as *important*.<br><br>The device appears in the device map with a star on it.|
|**Check public IP addresses**| it's important to identify any public IP addresses that are used internally. These IP addresses must be added as a seperate subnet within the Subnet settings. If a public IP address isn't listed, the sensor treats it as a public network for security settings.|
|**Schedule DNS lookup**| enhance device data enrichment by configuring multiple DNS servers to carryout reverse lookups and resolve host names or FQDNs associated with the IP addresses detected in network subnets. You will need the DNS server address, server port and the subnet addresses.|
|**DHCP address ranges**| devices with an IP address allocated by a DHCP server, which change dynamically, must define the range of IP addresses. This is an important step, which can affect the way your data is assessed for security risks. When the device IP address changes dynamically the device is logged as a new device, which might give misleading information about your system.|

## Operational mode
<!-- is the authorized stuff relevant here? we wont be showing how to change it. maybe it should be removed? - LW this will be relevant for a later stage. but not for exercise. just a mention. LW-->
<!-- give this a different title to reflect this is about things after the scope of the LM but still important to know about....LW -->
When the sensor first receives network traffic, it enters a state called *Learning* mode. While in *learning* mode, all devices detected are identified as *authorized*. Meaning that the device was checked and approved as a recognized part of your system. Once the learning mode is complete, any new devices detected are logged as *unauthorized*, and must be fully checked before you update the status to *authorized*.

Even after *Learning* mode is turned off, and *operational* mode starts traffic can be tracked. Activating the *Smart IT Learning* makes Defender for IoT send alerts when new suspicious traffic is tracked.
