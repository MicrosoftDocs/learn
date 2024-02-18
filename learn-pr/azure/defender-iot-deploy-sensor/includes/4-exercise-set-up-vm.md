This unit describes how to download the OT monitoring software from the Defender for IoT in the Azure portal. Then set up a virtual machine and connect it to a device/ interface. Then upload the monitoring software to the sensor. Afterwards, configure the network settings so that the sensor connects with the Azure portal. Finally, assign the end point interfaces, activate the sensor and set up the security certificates.
<!-- check all images for compliance - may need to redo them or edit -->
## Configure firewall to allow the sensor to connect to Azure portal

Configure your firewall rules so that your sensor can access the cloud on port 443, and connect to each of the endpoints listed in the JSON file provided by the communications Team.
<!-- what are the instructions for this? Who to ask?-->

## Create a virtual machine with ESXi

To perform this procedure, VMware, ESXi 5.5 or later must be installed and operational on your ??sensor??. Defender for IoT also supports other processes, such as using Hyper-V or physical sensors.
<!-- I think the next is not important for this
Details for the following network parameters to use for your sensor appliance:

- A management network IP address
- A sensor subnet mask
- An appliance hostname
- A DNS address
- A default gateway
- Any input interfaces
-->

1. Make sure that VMware is running on your machine.

1. Sign in to <!-- removed the-->ESXi, choose the relevant **datastore**, and select **Datastore Browser**.

1. **Upload** the image and select **Close**.

1. Go to **Virtual Machines**, and then select **Create/Register VM**.

1. Select **Create new virtual machine**, and then select **Next**.

1. Add a sensor name and then define the following options:

   - Compatibility: **&lt;latest ESXi version&gt;**

   - Guest OS family: **Linux**

   - Guest OS version: **Ubuntu Linux (64-bit)**

1. Select **Next**.

1. Choose the relevant datastore and select **Next**.

1. Change the virtual hardware parameters to the following specifications:

| Type |Memory  | Storage  | CPU Processor |
|----|-----|---------|----|
| E | 32 MB RAM | 1 TB |  4 Core/ 8 Threads |
| L | 8 MB RAM | 1 TB |  4 Core/ 4 Threads |

Your VM is now prepared for the Defender for IoT software installation. Next you configure the traffic mirroring.

### Configure a SPAN port

Virtual switches don't have mirroring capabilities. However, for the sake of this learn module you can use *promiscuous mode* in a virtual switch environment to view all network traffic that goes through the virtual switch.

> [!NOTE]
> Promiscuous mode is an operating mode and a security monitoring technique for a VM's interfaces in the same portgroup level as the virtual switch to view the switch's network traffic. Promiscuous mode is disabled by default but can be defined at the virtual switch or portgroup level.
>

**To configure a monitoring interface with Promiscuous mode on an ESXi v-Switch**:

1. Open the vSwitch properties page and select **Add standard virtual switch**.

1. Enter **SPAN Network** as the network label.

1. In the MTU field, enter **4096**.

1. Select **Security**, and verify that the **Promiscuous Mode** policy is set to **Accept** mode.

1. Select **Add** to close the vSwitch properties.

1. Highlight the vSwitch created, and select **Add uplink**.

1. Select the physical NIC to use for the SPAN traffic, change the MTU to **4096**, then select **Save**.

1. Open the **Port Group** properties page and select **Add Port Group**.

1. Enter **SPAN Port Group** as the name, enter **4095** as the VLAN ID, and select **SPAN Network** in the vSwitch drop down, then select **Add**.

1. Open the **OT Sensor VM** properties.

1. For **Network Adapter 2**, select the **SPAN** network.

1. Select **OK**.

1. Connect to the sensor, and verify that mirroring works.

### Validate traffic mirroring
<!-- check if this needs to be done, or can we give them a fake file?  -->
After you configure the traffic mirroring, retrieve a PCAP file to receive a sample of recorded traffic (PCAP file) from the switch SPAN or mirror port.

A sample PCAP file helps you: <!-- helps you -->

- Validate the switch configuration
- Confirm that the traffic going through your switch is relevant for monitoring
- Identify the bandwidth and an estimated number of devices detected by the switch

1. Use a network protocol analyzer application, such as *Wireshark*, to record a sample PCAP file for a few minutes. For example, connect a laptop to a port where you've configured traffic monitoring.

1. Check that *Unicast packets* are present in the recording traffic. Unicast traffic is traffic sent from address to another.<!-- from ONE address to another OR from address to address - Make the same change in the original doc-->

    If most of the traffic is ARP messages, your traffic mirroring configuration isn't correct.

1. Verify that your OT protocols are present in the analyzed traffic.

    For example:

    :::image type="content" source="../media/4-wireshark-validation.png" alt-text="Screenshot of Wireshark validation.":::
<!-- Consider breaking this unit at this point and making a new one for the next stage -->
