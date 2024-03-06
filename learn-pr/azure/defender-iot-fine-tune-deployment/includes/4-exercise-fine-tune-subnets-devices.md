<!--<https://youtu.be/iwEAHiN6BOI?si=xUeeL_LF2T-9zjc5&t=1544>-->
Your sensor is now sending data to Microsoft Defender for IoT, but we need to check that the sensors are recognized, and configured correctly. The sensor initially scans the entire network and tries to identify where all of the devices should be located within the Purdue levels.

## Check public IP addresses

What do we do here?

## View the subnets detected by your sensor

First you analyze the traffic being monitored.

1. Lon in to your sensor.
1. Select **System setting** > **Deployment**.
1. Select **Analyze** to start the subnet analysis process.

This tracks each interface that the sensor monitors and lists the subnet associated with each one. When the analysis is complete, you need to check that each interface is monitoring the correct traffic.
<!-- example of changing interfaces and sensor location -need to get proper feedback for how this is done, below is a placeholder-->
If you find a device incorrectly configured, make the following changes:

1. Type new name
1. Type new IP
1. Type new Mask
1. Select the Segregated box if this subnet is on a different level of the Purdue system
1. Select **Save**

## Modify subnet data

In the device inventory, you can view the subnets grouped as either *local* or *routed*. All of the devices connected to a listed subnet are called *local* devices, while the devices connected to unlisted subnets are called *routed*. <!-- is this really important, and how do we find this int he filters?-->Add a filter, choose Network Location, then choose either Local or Routed.

<!--updating the subnets listed, where do they find this data? they should have it from the original network map!?-->

There are several ways to update the subnet data. If you have a .CSV file with the data correctly organized, this file can be uploaded. Any data already in the system is overwritten when you upload the file.
<!-- FOr the learn module I think we should not give an example of changing a csv file, it will be too complicated. We should just give one example of changing the settings manually below. -->

In some cases, you need to adjust the subnet settings. This adjustment might involve changing subnet addresses that change the location of a device within the sensor created device map.

<!-- how to navigate to the section?-->
**To adjust subnet settings**
In the Sensor portal (NOT Defender for IoT portal!!), select **System settings > Basic > Subnets**.
In the Subnets page, choose the subnet that needs to be updated, and type the new settings  
you can update the subnets listed using the following options:
<!-- I have removed the extra options that are not relevant for changing data, but for other actions etc. ANy other Options to remove?
|**Import subnets**     | Import a .CSV file of subnet definitions. The subnet information is updated with the information that you imported. If you import an empty field, you lose the data in that field.       |
|**Export subnets**     |  Export the currently listed subnets to a .CSV file.       |
|**Clear all**     |  Clear all currently defined subnets.      |
|**Resolve all Internet traffic as internal/private**     | Select to consider all public IP addresses as private, local addresses. If selected, public IP addresses are treated as local addresses, and alerts aren't sent about unauthorized internet activity.  <br><br>This option reduces notifications and alerts received about external addresses.      |
|**Auto subnet learning**     |  Selected by default. Clear this option to prevent the sensor from detecting your subnets automatically. |
| **Remove subnet** | Select to remove any subnets that aren't related to your IoT/OT network scope.|
-->
|Name  |Description  |
|---------|---------|
| **IP address** | < Value > |
| **Mask**| < Value > |
| **Name**| < Value >|
|**Segregated**     |   Select to show this subnet separately when displaying the device map according to Purdue level.  |

<!-- do we want to show changing a device?? or is that beyond the scope? must talk about this, but how much details??? change one ip setting? -->
When all of the subnets are correctly set up, select **Save** to save the updates.<!-- do we need to do anything to return to the deployment page? or are we on it already?-->

Once any changes are made, the analysis should be run again to ensure the set-up is now correct.  <!-- is this the way to describe this. Or should be: Once all changes are made, select **Analyze** and review the results again. -->

## Add DHCP address ranges

<!-- if we think this is relevant take the info from here for instructions. <https://learn.microsoft.com/en-us/azure/defender-for-iot/organizations/how-to-control-what-traffic-is-monitored#configure-dhcp-address-ranges> -->

## View detected devices

<!-- carry on watching this <https://youtu.be/FbLhJZN1LdQ?si=xMBscEGQxGspzMSR&t=4635> -->

All of the devices detected by Defender for IoT appear in the Device inventory and Device map. You make changes to the device details by selecting a specific item and then selecting **Edit**.

Or select a group of items to edit at the same time, select **Add field types** and make your changes. It's important to review the data for the **Name**, **Class**, **Type**, and **Subtype**, **Authorization**, **Scanner device**, and **Programming device** columns.<!-- what does this refer to? the names of the settings do not match and the multiple choice option doesnt exist either?-->

## Update selected details
<!-- go over this, how to give examples of this??-->
To display extra fields, add the columns that don't display in the device inventory by selecting **Edit columns**, and add the extra categories you.

After checking the details of the devices, we'll update the details for one listed device. <!-- how to choose a device, what will they see? should be supply a PCAP file to upload, seems too much. So how do we demonstrate the updating? -->

In the Device map, select a device and right-click to open the menu options. Define this device as *Important* or *Not important*.

Devices can also be marked *Authorize* or *Unauthorize* and also edit the device's properties.
<!-- Where do we find the information for this stage? Is it in the network map? -->
<!-- Does this categorization of devices occur now, who does it, manually or automatically? <https://learn.microsoft.com/en-us/azure/defender-for-iot/organizations/device-inventory#supported-devices>  Also the section supported devices, do these device types/ categories actually get listed anywhere or this is just showing what types of devices will be tracked, but this information will not be displayed anywhere??Could this be the categories for the business function field/ column? If so why dont we give it a drop down int he column, because the entry is completely editable and i can write whatever I want - or is that ok? Or is this device class? How does callassification work? Is this part of that? <https://learn.microsoft.com/en-us/azure/defender-for-iot/organizations/device-inventory#automatically-consolidated-devices> at the end of this section is repeated the information about transiet and unclassified devices. should these be deleted, or deleted above? -->

We need to update several of the fields.

1. Select a device by clicking the checkbox.
1. Select **Edit**.
1. Make the changes.
1. Select **Save**.

## Merge devices

You might identify two or more devices listed that are really the same device. To merge two devices:

1. Select the devices you need to merge by clicking the checkboxes for those rows.
1. Select **Merge**.
1. Select **Confirm**.

## Check your work

You now have an updated and more accurate set of devices listed in the Device inventory.

<!-- View the subnets detected by your sensor
What is the difference between the Jenkins sensor page and the D4IoT sensor page? do they control different things? They both show interfaces and subnets and a device inventory, how are they different if at all? - no real difference, MS want the D4Iot to be better than the sensor, so it should show more things and give better control.
what defines a device as authorised? or not? 
device properties - how does that relate to making changes?-->

<!--General Qu: In this section https://learn.microsoft.com/en-us/azure/defender-for-iot/organizations/how-to-control-what-traffic-is-monitored#fine-tune-your-subnet-list  why is one an Azure device, but the map isnt? - should change to either Azure device map or device inventory. Also what is the meaning of the tip in this section? how is this different from the stuff above the tip? -->