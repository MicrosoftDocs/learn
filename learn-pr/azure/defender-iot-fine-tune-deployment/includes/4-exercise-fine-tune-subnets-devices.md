Your sensor now sends data to Microsoft Defender for IoT. You need to check that the devices are recognized and configured correctly in the Operational Technology (OT) sensor software. The sensor initially scans the entire network and tries to identify where all of the devices should be located within the Purdue levels.

## Check public IP addresses

What do we do here? give example of how this is done? 

## View the subnets detected by your sensor

First you must analyze the traffic being monitored by the OT sensor.

1. Log in to your sensor
1. Select **System setting** > **Deployment**
1. Select **Analyze** to start the subnet analysis process

This tracks each interface and device the sensor is monitoring and lists the subnet associated with each one. When the analysis is complete, you need to check that each interface is monitoring the correct traffic. Use the OT network plan, from the planning team, to compare the subnet information with the results of the Analyze process.

If you find a device incorrectly configured, make the following changes:

1. Select **System setting** > **Subnets**
1. Type a new IP
1. Type a new Mask
1. Type a new name
1. Select the **Segregated** checkbox if this subnet is on a different Purdue level
1. Select **Save**

We recommend giving a meaningful name that specifies the subnet's network role. Subnet names can have up to 60 characters.

## Modify subnet data

In the **Device inventory**, you can view the subnets grouped as either *local* or *routed*. All of the devices connected to a listed subnet are called *local* devices, while the devices connected to unlisted subnets are called *routed*. <!-- is this really important, theo-->

1. Choose **Add filter**
1. Choose **Network Location**
1. Choose either **Local** or **Routed**

<!--updating the subnets listed, where do they find this data? they should have it from the original network map!? 

To update the subnet data, adjust the subnet settings. These adjustments involve changing subnet addresses that change the location of a device within the sensor's device map.

1. Select **System settings > Basic > Subnets**
1. In the **Subnets** pane, update a subnet by typing the new settings for each field, using the following options:

|Name  |Description  |
|---------|---------|
| **IP address** | < Value > |
| **Mask**| < Value > |
| **Name**| < Value >|
| **Segregated**     |   Select to show this subnet separately when displaying the device map according to Purdue level.  |

We recommend giving a meaningful name that specifies the subnet's network role. Subnet names can have up to 60 characters.

When all of the subnets are correctly set up, select **Save**.
<!-- end of section-->
Once all changes are made, return to **System setting** > **Deployment** and run the **Analyze** feature again and review the results to ensure the set up is now correct.  

## View detected devices

All of the devices detected by the OT sensor appear in the Device inventory. Check the devices listed.

To make changes to a device detail:

1. Select a specific item
1. Select **Edit**. <!-- this needs to be fixed, but need to discuss with LW first. how will we show this? Ask THeo for example -->

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
:::image type="content" source="../media/device settings edit.png" alt-text="screenshot of hte edit pane for device settings":::
<!-- It's important to review the data for the **Name**, **Class**, **Type**, and **Subtype**, **Authorized device**, **Scanner device**, and **Programming device** columns. - I think this is incorrect as per the user story <https://dev.azure.com/msft-skilling/Content/_workitems/edit/232468/> -->

## Update selected details
<!-- how to give examples of this?? how to choose a device, what will they see? should be supply a PCAP file to upload, seems too much. So how do we demonstrate the updating?-->
After checking the details of the devices, we'll update the details for one listed device. Devices can also be marked *Authorize* or *Unauthorize*. This is found in the device properties settings.

We need to update several of the fields.

1. Select a device by clicking the checkbox.
1. Select **Edit**.
1. Make the changes.
1. Select **Save**.

## Important devices

Assign a unique device as **Important**. In the Device map:

1. Select a device and right-click to open the menu options
1. Select **Important**

## Add DHCP address ranges

Add the DHCP address ranges for a device.<!-- if we think this is relevant take the info from here for instructions. <https://learn.microsoft.com/en-us/azure/defender-for-iot/organizations/how-to-control-what-traffic-is-monitored#configure-dhcp-address-ranges> -->

## Merge devices

You might identify two or more devices listed that are really the same device. To merge two devices:

1. Select **System setting** > **Subnets**
1. Select the devices you need to merge by clicking the checkboxes for those rows
1. Select **Merge**
1. Select **Confirm**

## Check your work

You now have an updated and more accurate set of devices listed in the Device inventory.
