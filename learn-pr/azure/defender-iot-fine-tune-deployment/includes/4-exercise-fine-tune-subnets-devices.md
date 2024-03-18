Your sensor now sends data to Microsoft Defender for IoT. You need to check that the devices are recognized and configured correctly in the Operational Technology (OT) sensor software. The sensor initially scans the entire network and tries to identify where all of the devices should be located within the Purdue levels.

## Check public IP addresses

What do we do here? give example of how this is done?

## View the subnets detected by your sensor

First you must analyze the traffic being monitored by the OT sensor.

1. Log in to your sensor.
1. Select **System setting** > **Deployment**.
1. Select **Analyze** to start the subnet analysis process.

This tracks each interface and device the sensor is monitoring and lists the subnet associated with each one. When the analysis is complete, you need to check that each interface is monitoring the correct traffic. <!-- what is the difference between interface and device? Theo -->
<!-- example of changing interfaces and sensor location -need to get proper feedback for how this is done, below is a placeholder -->
If you find a device incorrectly configured, make the following changes:

1. Type new name
1. Type new IP
1. Type new Mask
1. Select the **Segregated** checkbox if this subnet is on a different Purdue level
1. Select **Save**

## Modify subnet data

In the **Device inventory**, you can view the subnets grouped as either *local* or *routed*. All of the devices connected to a listed subnet are called *local* devices, while the devices connected to unlisted subnets are called *routed*. <!-- is this really important, theo-->

1. Choose **Add filter**
1. Choose **Network Location**
1. Choose either **Local** or **Routed**

<!--updating the subnets listed, where do they find this data? they should have it from the original network map!? theo-->

To update the subnet data, adjust the subnet settings. These adjustments involve changing subnet addresses that change the location of a device within the sensor's device map.

**To adjust subnet settings**

1. Select **System settings > Basic > Subnets**
1. In the **Subnets** pane, update a subnet by typing the new settings for each field, using the following options:

|Name  |Description  |
|---------|---------|
| **IP address** | < Value > |
| **Mask**| < Value > |
| **Name**| < Value >|
| **Segregated**     |   Select to show this subnet separately when displaying the device map according to Purdue level.  |

<!-- do we want to show changing a device?? or is that beyond the scope? must talk about this, but how much details??? change one ip setting? -->
We recommend giving a meaningful name that specifies the subnet's network role. Subnet names can have up to 60 characters.

When all of the subnets are correctly set up, select **Save**.

Once all changes are made, return to **System setting** > **Deployment** and run the **Analyze** feature again and review the results to ensure the set up is now correct.  

## Add DHCP address ranges

<!-- if we think this is relevant take the info from here for instructions. <https://learn.microsoft.com/en-us/azure/defender-for-iot/organizations/how-to-control-what-traffic-is-monitored#configure-dhcp-address-ranges> -->

## View detected devices

All of the devices detected by the OT sensor appear in the Device inventory. Check the devices listed. To make changes to a device detail, select a specific item and then select **Edit**. <!-- this needs to be fixed, but need to discuss with LW first. how will we show this? Ask THeo for example -->
You can update the following fields:

1. Authorized device
1. Name
1. Description
1. OS platform
1. Type
1. Purdue level
1. Scanner
1. Programming device

Select **Save**.

It's important to review the data for the **Name**, **Class**, **Type**, and **Subtype**, **Authorized device**, **Scanner device**, and **Programming device** columns.<!-- what does this refer to? the names of the settings do not match and the multiple choice option doesnt exist either?  Should Class be OS platform- this is the list in the Azure portal. not the sensor! So this is incorrect in the documentation and doesnt apply to the page about OT sensors!! <https://learn.microsoft.com/en-us/azure/defender-for-iot/organizations/ot-deploy/update-device-inventory#view-your-device-inventory-on-the-azure-portal> Not all of the column fields are available. see screenshots.... I also dont know what this line in that section means?? 3. Understand the devices that the OT sensor's detected, and identify any sensors where you'll need to identify device properties. LW - put into new USer Story-->

## Update selected details - example exercise
<!-- go over this, how to give examples of this??-->
After checking the details of the devices, we'll update the details for one listed device. <!-- how to choose a device, what will they see? should be supply a PCAP file to upload, seems too much. So how do we demonstrate the updating? -->
We need to update several of the fields.

1. Select a device by clicking the checkbox.
1. Select **Edit**.
1. Make the changes.
1. Select **Save**.

## Important devicesAssign a unique device as **Important**. In the Device map:

1. Select a device and right-click to open the menu options
1. Select **Important**

Devices can also be marked *Authorize* or *Unauthorize*.
<!-- Where do we find the information for this stage? Is it in the network map? -->
<!-- Does this categorization of devices occur now, who does it, manually or automatically? <https://learn.microsoft.com/en-us/azure/defender-for-iot/organizations/device-inventory#supported-devices>  Also the section supported devices, do these device types/ categories actually get listed anywhere or this is just showing what types of devices will be tracked, but this information will not be displayed anywhere??Could this be the categories for the business function field/ column? If so why dont we give it a drop down int he column, because the entry is completely editable and i can write whatever I want - or is that ok? Or is this device class? How does callassification work? Is this part of that? <https://learn.microsoft.com/en-us/azure/defender-for-iot/organizations/device-inventory#automatically-consolidated-devices> at the end of this section is repeated the information about transiet and unclassified devices. should these be deleted, or deleted above? -->

## Merge devices

You might identify two or more devices listed that are really the same device. To merge two devices:

1. Select the devices you need to merge by clicking the checkboxes for those rows
1. Select **Merge**
1. Select **Confirm**

## Check your work

You now have an updated and more accurate set of devices listed in the Device inventory.

<!-- View the subnets detected by your sensor
What is the difference between the Jenkins sensor page and the D4IoT sensor page? do they control different things? They both show interfaces and subnets and a device inventory, how are they different if at all? - no real difference, MS want the D4Iot to be better than the sensor, so it should show more things and give better control.
what defines a device as authorised? or not? 
device properties - how does that relate to making changes?-->

<!--General Qu: In this section https://learn.microsoft.com/en-us/azure/defender-for-iot/organizations/how-to-control-what-traffic-is-monitored#fine-tune-your-subnet-list  why is one an Azure device, but the map isnt? - should change to either Azure device map or device inventory. Also what is the meaning of the tip in this section? how is this different from the stuff above the tip? -->