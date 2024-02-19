Your car manufacturing organization has offices and production sites across the globe, with a network linking them together. A sensor was onboarded to Defender for IoT and the site networking is set up. Now your task is to deploy the sensor by installing the OT monitoring software and activating the sensor to send data to the Azure portal.

## Your organization's OT sensor deployment plan

The OT sensor deployment plan is shown in the following diagram:

:::image type="content" source="../media/3-deploy-sensors.png" alt-text="Diagram of the sensor deployment path" border="false":::

## Install Defender for IoT software
<!-- I dont understand the headings here, I would have thought this should be H3 as it is a sub category of the previous H2 heading. But Cat put this entire section as H2s? I have done that here but it seems incorrect-->
This Learn Module is divided into 2 sections, the first - units 3 and 4 - deals with creating and setting up the virtual machine to run the OT sensor. THe second - units 5 and 6 - deals with installing and activiating the monitoring software on the virtual machine OT sensor.
<!-- WHAT DOES THIS MEAN  - Ensure that the hostname is configured in the organizational DNS server. in the sensor-->

### Set up a virtual machine
<!-- placement heading - what should we do for this introduction - should it be here or probably earlier in unit 1 or 2? -->
<!-- remove this: Download the OT monitoring software installation file from the Defender for IoT setup page. !-- is this provided by the previous team??? --! Save the ISO file, at a later stage you will install it on to the OT sensor appliance.-->

The first stage in deploying the OT sensor monitoring software is to set up a virtual machine to act as the OT sensor. We will use the VMware ESXi v-Switch to build the virtual machine, but other systems such as HyperV could also be used.

For more information about setting up your virtual machine, refer to your virtual machine software documentation. <!-- not sure that we should keep this - or should adapt to: The information below is for setting up the ESXi v-Switch, but you may need to refer to your virtual machine software documenation for more details./ where details differ. -->

1. Create a virtual machine following the VMware directions after choosing **Create new virtual machine** and setting the correct virtual hardware parameters.

2. Configure the SPAN port to enable traffic mirroring. This has a specific set up when using a virtual machine using the **Promiscuous mode**.

3. Verify that the SPAN port is correctly mirroring traffic by retrieving a PCAP file. The sample PCAP file data will confirm the switch configuiration and that the data passing through the switch is relevant for monitoring. You should also be able to idenfity the bandwidth and estimate the number of devices detetced by the switch.

Use *Wireshark* or a similar program to record a PCAP file, and then confirm that the data recorded contains the correct data, with the OT protocols present. If most of the traffic is ARP messages, your traffic mirroring configuration isn't correct.

<!-- -->
You need the details of two network adapters: <!-- where does this go?-->

- One connects the sensor to the Azure portal for cloud management.<!-- is this the firewall configuration? -->
- The other connects the sensor to a traffic mirroring port. <!-- this is the configuration of the SPAN port above -->

<!-- is the following correct? -->
Details for the following network parameters to use for your sensor appliance:

- A management network IP address
- A sensor subnet mask
- An appliance hostname
- A DNS address
- A default gateway
- Any input interfaces

Run the installation file on the virtual machine, and follow the stages in the wizard to install the software.
Once the installation is completed the default network details are displayed.

In a real life scenario, configured sensors can be bought and this step is skipped.<!-- this should probably be removed, from the learn module??-->
