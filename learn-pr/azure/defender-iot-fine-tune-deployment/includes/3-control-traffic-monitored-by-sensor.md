<!-- also re read and make adjustments, also where will the items needed in the exercise unit be explained? THey should be here somewhere in the doc. Can use this page <https://learn.microsoft.com/en-us/azure/defender-for-iot/organizations/ot-deploy/update-device-inventory#edit-device-properties-per-device> for images -->
# Plan fine-tuning and calibration

Data is now flowing from your sensor to Microsoft Defender for IoT. The monitoring software initially identifies the interfaces and endpoints and builds a map of the devices in the system, the subnet they're connected to and gives security settings to each one.

However, it's possible that some of these device settings might not be correctly identified and so you need to check each one. In some cases, you need to reassign the settings or location of the devices in the Perdue levels.

The OT sensor analyzes the subnets. A subnet is a group of devices or interfaces that have a specific purpose or are located in a specific area, for example all of the printers in the main offices, all of the lights in the manufacturing level, all heating systems in the administrative rooms. Each subnet is assigned its own identification code/ address.<!-- check this-->

The sensor analyzes your system and assigns subnet settings and attempts to understand the architecture of your system and fit it into the Purdue model set-up. In some cases, the device map produced needs to be corrected. You might need to change device settings that are associated with the wrong subnet and ensure that they have the correct IP address.

## Fine tuning

The first stage of fine-tuning your sensor is to run the **Analyze** feature in the Deployment section of the sensor. When the analysis function is completed, check the information about each interface. If it isn't what you expected, you need to check that subnet and device settings and make any needed changes.

## Check public IP addresses

It's important to identify any public IP addresses that are used internally. These IP addresses must be listed and <!--what do we need to do? remove, reassign an IP, define as authorized?-->. If a public IP address isn't listed as a subnet, the sensor treats it as a public network for security settings.

## Check and modify the subnet settings

The sensor software /Defender for IoT identifies the subnets within your system. However, you might also need to correct and change some of the subnet settings or even update the list of subnets made by Defender for IoT.

Any subnets that aren't listed and configured is considered as external networks.

You can update the subnet settings using a .CSV file containing a new and complete list of all subnets, with the data formatted in a specific order. This update method requires a .CSV file to upload, and is beyond the scope of this Learn Module.

The subnet settings can also be changed manually, either by changing the subnet data or adding new subnets. To make changes, you need:

- IP address <!-- <https://youtu.be/FbLhJZN1LdQ?si=xMBscEGQxGspzMSR&t=4635> this is class B, what does that mean?-->
- Mask IP <!-- this is class C, what does that mean?-->
- A Name for the subnet

We recommend that you enter a meaningful name that specifies the subnet's network role. Subnet names can have up to 60 characters.

You might also want to define the subnet as a segregated subnet, meaning the subnet is displayed separately in the device map for the Purdue levels view.

Changes are made and then the new subnet settings can be saved.

## DHCP address ranges
<!-- exclude this or is it important??-->
Devices that have an IP address allocated by a DHCP server, which change dynamically, must define the address ranges used.

## Important devices

Devices can also be assigned as *Important*, which gives the device a higher severity score for other features such as running an Attack vector or Risk assessment. So that device is treated as more important than most other for these reports.

The *Important* setting is also useful to differentiate between similar types of devices, where one or more are very important to your system, but the others aren't. For example, if you have a vital cooling system and a set of air conditioning units.

The device appears in the device map with a star on it.

## Update device details
<!-- is the authorized stuff relevant here? we wont be showing how to change it. -->
During the initial *learning* stage, all devices detected are identified as *authorized*. Meaning that the device was checked and approved as recognized parts of your system. Once the learning stage is completed, any new devices detected are logged as *unauthorized*, and must be fully checked before you update the status to *authorized*.

You can also customize other parts of the data, such as the names assigned to the detected ports, the VLAN names and the DHCP addresses. <!-- I am not sure about some of this, <https://learn.microsoft.com/en-us/azure/defender-for-iot/organizations/device-inventory#device-inventory-column-data> this seems a list of possible detail changes, which , if any should we choose, and how many should be update? -->

## Merge devices

In some cases, a device might be listed more than once, for example when a device has two or more connectors to the sensor<!-- for example a laptop with both Wifi and a physical network card - should i keep this detailed example, it made the sentence long and complicated-->. In such a situation, you need to merge them together, using the **Merge** option. The new merged device listing contains all of the data from both merged devices.
<!-- <https://learn.microsoft.com/en-us/azure/defender-for-iot/organizations/how-to-control-what-traffic-is-monitored#manually-define-a-subnet-as-ics> why would i define something as ICS, it doesnt explain here?-->

## Smart IT learning
<!-- not sure if this is worth keeping. -->
There's also a setting to continue a form of tracking the traffic even after the *Learning* stage is turned off, and *operational* mode starts. Activating the *Smart IT Learning* makes Defender for IoT send alerts when new suspicious traffic is tracked.
<!-- <https://learn.microsoft.com/en-us/azure/defender-for-iot/organizations/how-to-manage-individual-sensors?tabs=ca-signed#turn-off-learning-mode-manually> -->