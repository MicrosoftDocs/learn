<!-- where should this unit go, here or after the fine tune exercise?-->
<!-- also re read and make adjustments, also where will the items needed in the exercise unit be explained? THey should be here somewhere in the doc. -->
# Plan fine-tuning and calibration

Data is now flowing from your sensor to Microsoft Defender for IoT. The monitoring software initially identifies the interfaces and endpoints and tries to identify where they are located in the system and what security settings should be given to each one.

However, it is possible that some of these may not be correctly identified and so you need to check each one. In some cases you need to reassign the settings or location of the devices in the Perdue levels.

## Fine tuning

The first stage in fine-tuning your sensor <!-- sensor or interfaces?--> is to run an the **Analyze** feature in the Deployment section of Defender for IoT.<!-- is it here or in the OT sensor?--> When the analysis function is completeted check the information about each interface. If it isn't what you expected, you will need to check that subnets are correct for each device.

## Check and modify the subnet settings

Defender for IoT will also identify the subnets within your system. However, you may also need to correct and change some of the subnet settings or even update the list of subnets that Defender for ioT has made.

There are several ways to do this. One is to upload a new, complete list of all subnets. This requires a .CVS file to upload.

Another is to manually change the subnet data and add new subnets, requiring knowledge of the correct IP address, Mask number, and an appropriate Name.

Changes are made and then the new subnet settings can be saved.
