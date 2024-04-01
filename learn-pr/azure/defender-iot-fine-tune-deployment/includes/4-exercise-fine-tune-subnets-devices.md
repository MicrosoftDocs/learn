Your sensor now sends data to Microsoft Defender for IoT. You need to check that the devices are recognized and configured correctly in the Operational Technology (OT) sensor software. The sensor initially scans the entire network and tries to identify where all of the devices should be located within the Purdue levels.

## View the subnets detected by your sensor

First you must analyze the traffic monitored by the OT sensor.

1. Log in to your sensor
1. Select **System setting** > **Deployment**
1. Select **Analyze** to start the subnet analysis process

This tracks each interface and device the sensor is monitoring and lists the subnet associated with each one. When the analysis is complete, you need to check that each interface is monitoring the correct traffic. Use the OT network plan, from the planning team, to compare the subnet information with the results of the Analyze process.

## Modify subnet data

If you find a device incorrectly configured, make the following changes:

1. Select **System setting** > **Subnets**
1. Type a new IP
1. Type a new Mask
1. Type a new name
1. Select the **Segregated** checkbox if this subnet is on a different Purdue level
1. Select **Save**

We recommend giving a meaningful name that specifies the subnet's network role. Subnet names can have up to 60 characters.

Once all changes are made, return to **System setting** > **Deployment** and run the **Analyze** feature again and review the results to ensure the set up is now correct.  

## View and update detected devices

All of the devices detected by the OT sensor appear in the Device inventory.

In the **Device inventory**, you can view the subnets grouped as either *local* or *routed*. Check through all of the devices listed.

1. Select **Device inventory**
1. Select **Add filter**
1. Select **Network Location**
1. Select either **Local** or **Routed**

You can now look through the list of devices and check the details of all of the devices.

## Merge devices

You might identify two or more devices listed that are really the same device. To merge two devices:

1. Select **Device inventory**
1. Select the devices you need to merge by clicking the checkboxes for those rows
1. Select **Merge**
1. Select **Confirm**
<!-- how to give examples of this?? how to choose a device, what will they see? So how do we demonstrate the updating? -->
After checking the details of the devices, we'll update the details for one listed device.

We need to update several of the fields.

1. Select a device by clicking the checkbox.
1. Select **Edit**.
1. Make the changes.
1. Select **Save**.

## Important devices

Assign a unique device as **Important**. In the **Device map**:

1. Select a device and right-click to open the menu options
1. Select **Important**

## Check public IP addresses

Select **System setting** > **Deployment**

**What do we do here? Give example of how this is done? Ariel**

## Add DHCP address ranges

For a device which automatically refreshes its IP address, add the DHCP address ranges for that device.

1. Select **System setting** > **DHCP ranges**
1. Select **Add range**
1. Type the IP address ranges
1. Type a name
1. Select **Save**

:::image type="content" source="../media/4-dhcp-ranges.png" alt-text="Screenshot adding new DHCP ranges for changing IP addresses":::

## Check your work

You now have an updated and more accurate set of devices listed in the Device inventory.
