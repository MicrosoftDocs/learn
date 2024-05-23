Your sensor now sends data to Microsoft Defender for IoT. You need to check that the devices are recognized and configured correctly in the Operational Technology (OT) sensor software. The sensor initially scans the entire network and tries to identify where all of the devices should be located within the Purdue levels.

The following exercises show all of the stages of fine tuning your sensor. Depending on the data available in your system, you might only be able to do some of these exercises but not all of them.

## View the subnets detected by your sensor

First you must analyze the traffic monitored by the OT sensor.

1. Log in to your sensor.
1. Select **System setting** > **Deployment**.
1. Select **Analyze** to start the subnet analysis process.

This tracks each interface and device the sensor is monitoring and lists the subnet associated with each one. When the analysis is complete, you need to check that each interface is monitoring the correct traffic. Use the OT network plan, from the planning team, to compare the subnet information with the results of the analysis process.

## Modify subnet data

If you find a device incorrectly configured, make the following changes:

1. Select **System setting** > **Subnets**.
1. Type a new **IP** address.
1. Type a new **Mask** address.
1. Type a new **name**.
1. Select the **Segregated** checkbox if this subnet is on a different Purdue level.
1. Select **Save**.

We recommend giving a meaningful name that specifies the subnet's network role. Subnet names can have up to 60 characters.

Once all changes are made, return to **System setting** > **Deployment** and select **Analyze** again to run the process. Review the results to ensure the setup is now correct.  

## View and update detected devices

All of the devices detected by the OT sensor appear in the **Device inventory**.

In the **Device inventory**, you can view the subnets grouped as either *local* or *routed*. Check through all of the devices listed.

1. Select **Device inventory**.
1. Select **Add filter**.
1. Select **Network Location**.
1. Select either **Local** or **Routed**.

Look through the list of devices and check their details. After checking the device details, as an exercise, choose one device and update several of the fields.

1. Select a device by clicking the checkbox.
1. Select **Edit**.
1. Make the changes.
1. Select **Save**.

## Merge devices

You might identify two or more devices listed that are really the same device. To merge two devices:

1. Select **Device inventory**.
1. Select the devices you need to merge by clicking the checkboxes for those rows.
1. Select **Merge**.
1. Select **Confirm**.

## Important devices

Assign a unique device as **Important**. In the **Device map**:

1. Select a device and right-click to open the menu options.
1. Select **Important**.

## Check public IP addresses

It's important list all public IP addresses that are used internally. These IP addresses must be added as a separate subnet within the Subnet settings, as follows:

1. Select **System setting** > **Basic** > **Subnets**.
1. Select **Add subnet**.
1. Type a new **IP** address.
1. Type a new **Mask** address.
1. Type a new **name**.
1. Select **Save**.

## Add DNS server settings

Define the range of IP addresses for devices with an IP address allocated by a DHCP server, which changes dynamically, as follows:

1. Select **System setting** > **Network monitoring** > **Reverse DNS lookup**.
1. Toggle **Enable**.
1. Define the time interval, either:
    - In the **Schedule Reverse Lookup**, define the time interval for your scan by typing a number in the second box.
    - Or select **By specific time** and type the time in 24 hr format.
1. Select **Add DNS server**.
1. Type the **DNS server address**, **DNS server port** and **Subnets** details.
1. Select **Save**.
1. Optionally, select **Test** at the top to check the settings are correct.

## Add DHCP address ranges

For a device that automatically refreshes its IP address, add the DHCP address ranges for that device.

1. Select **System setting** > **DHCP ranges**.
1. Select **Add range**.
1. Type the IP address ranges.

   :::image type="content" source="../media/4-dhcp-ranges.png" alt-text="Screenshot adding new DHCP ranges for changing IP addresses.":::
1. Type a name.
1. Select **Save**.

## Check your work

Verify that the devices and subnets listed are accurate in the device inventory.

1. Go to **Device inventory**.
1. The list of devices and subnets is up to date and accurate.

   :::image type="content" source="../media/4-fine-tuned-list.png" lightbox="../media/4-fine-tuned-list.png" alt-text="Screenshot of the device inventory after fine tuning.":::
