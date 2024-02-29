Your car manufacturing organization has offices and production sites across the globe, with a network linking them together. A sensor was onboarded to Defender for IoT and the site networking is set up. Now your task is to deploy the sensor by installing the OT monitoring software and activating the sensor to send data to the Azure portal.

## Your organization's OT sensor deployment plan

The OT sensor deployment plan is shown in the following diagram:

:::image type="content" source="../media/3-deploy-sensor-path.png" alt-text="Diagram of the sensor deployment path" border="false":::

This Learn Module is divided into 2 sections.

Section 1: units 3 and 4 deal with creating and setting up the virtual machine to run the OT sensor.

Section 2: units 5 and 6 deal with installing and activiating the monitoring software on the virtual machine OT sensor.

### Set up a virtual machine

<!-- remove this: Download the OT monitoring software installation file from the Defender for IoT setup page. !-- is this provided by the previous team??? --! Save the ISO file, at a later stage you will install it on to the OT sensor appliance. LW-->

The first stage in deploying the OT sensor monitoring software is to set up a virtual machine to act as the OT sensor.

We will use the VMware ESXi to build the virtual machine, but other systems such as HyperV could also be used. The information below is for setting up the ESXi, but you may need to refer to your virtual machine software documenation for more details.

1. Create a virtual machine following the VMware directions after choosing **Create new virtual machine** and setting the correct virtual hardware parameters.

1. Configure the management connection to enable the sensor to connect to Azure. For this you need the following network parameters:

- A management network IP address
- A sensor subnet mask
- An appliance hostname
- A DNS address
- A default gateway
- Any input interfaces

1. Configure the SPAN port to enable traffic mirroring. This has a specific set up when using a virtual machine using the **Promiscuous mode**.

1. Verify that the SPAN port is correctly mirroring traffic by retrieving a PCAP file. The sample PCAP file data will confirm the switch configuiration and that the data passing through the switch is relevant for monitoring. You should also be able to idenfity the bandwidth and estimate the number of devices detetced by the switch. It is important to confirm the correct amount of data is being monitored. If the SPAN port is incorrectly set, too much data may be transferred and this can overwhelm the system, or not enough data is sent and the sensor will not correctly secure your system.

Use *Wireshark* or a similar program to record a PCAP file, and then confirm that the data recorded contains the correct data. If most of the traffic is ARP messages, your traffic mirroring configuration isn't correct.
