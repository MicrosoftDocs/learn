<!-- also re read and make adjustments, also where will the items needed in the exercise unit be explained? THey should be here somewhere in the doc. -->
# Plan fine-tuning and calibration

Data is now flowing from your sensor to Microsoft Defender for IoT. The monitoring software initially identifies the interfaces and endpoints and tries to identify where they are located in the system, which subnet they are connected to and what security settings should be given to each one.

However, it is possible that some of these device settings may not be correctly identified and so you need to check each one. In some cases you need to reassign the settings or location of the devices in the Perdue levels.

Subnets are also analyzed by the OT sensor. A subnet is a group of devices or interfaces that have a specific purpose or are located in a specific area, for example all of the printers in the main offices, all of the lights in the manufacturing level, all heating systems in the administrative rooms. Each subnet is assigned its own identifcation code/ address.

The sensor analyzes your system and assigns subnet settings and attemps to understand the architecture of your system and fit it into the Purdue model set up. In some cases, the device map produced needs to be corrected. You might need to change device settings that are associated with the wrong subnet and ensure that they have the correct IP address.

## Fine tuning

The first stage of fine-tuning your sensor is to run an the **Analyze** feature in the Deployment section of the sensor. When the analysis function is completeted check the information about each interface. If it isn't what you expected, you will need to check that subnet and device settings and make any needed changes.

## Check and modify the subnet settings

The sensor software will /Defender for IoT will also identify the subnets within your system. However, you may also need to correct and change some of the subnet settings or even update the list of subnets that Defender for ioT has made.

There are several ways to do this. One is to upload a new, complete list of all subnets. This requires a .CVS file to upload, and so it is beyond the scope of this Learn Module.

Another is to manually change the subnet data or add new subnets. To make changes you need:

- IP address <!-- <https://youtu.be/FbLhJZN1LdQ?si=xMBscEGQxGspzMSR&t=4635> this is class B, what does that mean?-->
- Mask IP <!-- this is class C, what does that mean?-->
- A Name for the subnet

We recommend that you enter a meaningful name that specifies the subnet's network role. Subnet names can have up to 60 characters.

You might also want to define this as a segregated subnet, which means it's displayed seperately in the device map for the Purdue levels view.

Changes are made and then the new subnet settings can be saved.

## Important devices

Devices can also be assign as *Important*, this gives the device a higher severity score for other features such as running an Attack vector or Risk assessment. So that device will be treated as more important tham most other for these reports.

This is also useful to differentiate between similar types of devices, where one or more are very important to your system, but the others aren't. For example, if you have a vital cooling system and a set of air conditioning units.

The device will appear in the device map with a star on it.

## Update device details

## Merge devices

In some cases a device might be listed more than once, this can happen when a device has two or more similar connectors, for example a laptop with both Wifi and a physical network card. In this case you will need to merge them together, using the **Merge** option. This will make a new device listing, that will contain all of the data from the merged devices.
