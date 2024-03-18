# Plan fine-tuning and calibration
<!-- what should the unit title be? change then remove the h1 title above -->
Data is now flowing from your sensor to Microsoft Defender for IoT. The Operational Technology (OT) monitoring software initially identifies the interfaces and device endpoints. The OT software builds a map of the devices in the system, the subnets they're connected to and gives security settings to each one.

However, it's possible that some of these device settings might not be correctly identified, so you need to check each one. In some cases, you need to reassign the settings or location of the device in the Perdue levels.

The OT sensor analyzes the subnets. A subnet is a group of devices or interfaces that have a specific purpose or are located in a specific area, for example all of the printers in the main offices, all of the lights in the manufacturing level, all heating systems in the administrative rooms. Each subnet is assigned its own identification code/ address.<!-- check this-->
OR
The OT sensor analyzes your system and assigns subnet settings and attempts to understand the architecture of your system and fit each device into the Purdue model set up. In some cases, the device map produced needs to be corrected. You might need to change device settings that are associated with the wrong subnet and ensure that they have the correct IP address.

## Fine tuning

The first stage of fine-tuning your sensor is to run the **Analyze** feature in the **Deployment** section of the OT sensor. When the analysis function is completed, check the information about each interface. If it isn't what you expected, you need to check the subnet and device settings and make any needed changes.

## Check public IP addresses

It's important to identify any public IP addresses that are used internally. These IP addresses must be listed and. <!--what do we need to do? remove, reassign an IP, define as authorized?--> If a public IP address isn't listed as a subnet, the sensor treats it as a public network for security settings.

## Check and modify the subnet settings

The OT sensor software identifies the subnets within your system. However, you might need to correct some of the subnet settings or update the list of subnets. Any subnets that aren't listed and configured are considered external networks. All of the devices connected to a listed subnet are called *local* devices, while the devices connected to unlisted subnets are called *routed*.

You can update the subnet settings using a .CSV file containing a new and complete list of all subnets, with the data formatted in a specific order. This update method requires the uploading of a .CSV file and is beyond the scope of this Learn Module. <!-- this can be removed, if it is beyond scope. what do you think? remove - LW-->

The subnet settings are changed manually, either by changing the subnet data or adding a new subnet. To make changes, you need the subnet:

- IP address <!-- <https://youtu.be/FbLhJZN1LdQ?si=xMBscEGQxGspzMSR&t=4635> this is class B, what does that mean?-->
- Mask IP <!-- this is class C, what does that mean?-->
- A Name to assign

We recommend giving a meaningful name that specifies the subnet's network role. Subnet names can have up to 60 characters.

You might also want to define the subnet as a segregated subnet, meaning the subnet is displayed separately in the device map for the Purdue levels view.

Changes are made and then the new subnet settings are saved.

## DHCP address ranges
<!-- exclude this or is it important??-->
Devices that have an IP address allocated by a DHCP server, which change dynamically, must define the address ranges used.

## Important devices

Devices can also be assigned as *Important*, which gives the device a greater security rating for features such as running an Attack vector or Risk assessment. So that the device is considered more important than other devices for these reports.

The *Important* setting is also useful to differentiate between similar types of devices, where some of the devices are very important to your system, but the others aren't. For example, if you have a vital cooling system and a set of air conditioning units, only set the cooling system as *important*.

The device appears in the device map with a star on it.

## Update device details
<!-- is the authorized stuff relevant here? we wont be showing how to change it. maybe it should be removed? - LW this will be relevant for a later stage. but not for exercise. just a mention. -->
When the sensor first receives network traffic it enters a state called the *Learning* stage. During the *learning* stage, all devices detected are identified as *authorized*. Meaning that the device was checked and approved as a recognized part of your system. Once the learning stage is completed, any new devices detected are logged as *unauthorized*, and must be fully checked before you update the status to *authorized*.

You can also customize other parts of the data, such as the names assigned to the detected ports, the VLAN names, and the DHCP addresses. <!-- I am not sure about some of this, <https://learn.microsoft.com/en-us/azure/defender-for-iot/organizations/device-inventory#device-inventory-column-data> this seems a list of possible detail changes, which , if any should we choose, and how many should be update? Theo which of these would be typical to be changed for a user-->

## Merge devices

In some cases, a device might be listed more than once. This could happen when a device has two or more connectors to the sensor, for example a laptop with both Wifi and a physical network card. In such a situation, you need to merge them together, using the **Merge** option. The new merged device listing contains all of the data from both merged devices.
<!-- <https://learn.microsoft.com/en-us/azure/defender-for-iot/organizations/how-to-control-what-traffic-is-monitored#manually-define-a-subnet-as-ics> why would i define something as ICS, it doesnt explain here? theo -->

## Smart IT learning
<!-- not sure if this is worth keeping. mention for the future but not in exercise -->
There's also a setting to continue a form of tracking the traffic even after the *Learning* stage is turned off, and *operational* mode starts. Activating the *Smart IT Learning* makes Defender for IoT send alerts when new suspicious traffic is tracked.
<!-- <https://learn.microsoft.com/en-us/azure/defender-for-iot/organizations/how-to-manage-individual-sensors?tabs=ca-signed#turn-off-learning-mode-manually> -->
<!-- also re read and make adjustments, also where will the items needed in the exercise unit be explained? THey should be here somewhere in the doc. Can use this page <https://learn.microsoft.com/en-us/azure/defender-for-iot/organizations/ot-deploy/update-device-inventory#edit-device-properties-per-device> for images -->