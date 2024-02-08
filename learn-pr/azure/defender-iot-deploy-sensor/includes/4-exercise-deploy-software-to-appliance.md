This unit describes how to download the OT monitoring software from the Defender for IoT in the Azure portal. Then set up a virtual machine and connect it to a device/ interface. Then upload the monitoring software to the sensor. Afterwards, configure the network settings so that the sensor connects with the Azure portal. Finally, assign the end point interfaces, activate the sensor and set up the security certificates.
<!-- check all inmages for compliance - may need to redo them or edit -->
## Configure firewall to allow the sensor to connect to Azure portal

Configure your firewall rules so that your sensor can access the cloud on port 443, and connect to each of the listed endpoints in the downloaded list.
<!-- can i see a demo file, also what are the instructions for this? Who to ask?-->

## Create a virtual machine with ESXi

To perform this procedure, VMware, ESXi 5.5 or later must be installed and operational on your ??sensor??. Defender for IoT also supports other processes, such as using Hyper-V or physical sensors. <!-- keep this or remove?-->
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
## Install Defender for IoT software

To start the software installation, open your virtual machine.

### Configure the virtual machine
<!-- is this correct, and described properly, or has it already been done above??check with Mark -->
The virtual machine must have two network adapters configured, one that connects to the Azure portal, and the other to the traffic mirroring ports on the sensor.

On your virtual machine:

1. Open the VM settings
1. Add two new network adaptors, give each a significant name so they're easily identifiable, such as:
    - **Azure network adapter** - to connect to the Azure portal
    - **Mirroring port adapter** - to connect to the sensor mirroring port

### Download the monitoring software file

In Defender for IoT select **Getting started > Sensor**, then select the latest software version and select **Download**. <!-- must ensure they download the correct software version otherwise the admin and log in will be incorrect, if it is different on older versions -->

:::image type="content" source="../media/4-download-iso-file.png" alt-text="screenshot of Downloading ISO monitoring file from Defender for IoT":::

Save the downloaded ISO file in a location that's accessible from your VM.

All files downloaded from the Azure portal are signed by root of trust so that your machines use signed assets only.

### Install the monitoring software on the virtual machine

On your virtual machine:

1. Mount the ISO file onto the virtual machine using the system specific application. In this scenario, we're using the iLO for HPE machines. <!-- is this written correctly? I think this is what comes next and the reference to iLO is irrelevant! - check with Mark-->

> [!NOTE]
> Towards the end of this process you will be presented with the usernames and passwords for your device. Make sure to copy these down as these passwords will not be presented again.

**To install the software on the virtual sensor**:

On your virtual machine:

1. Open your VM settings.

1. For **CD/DVD Drive 1**, select **Datastore ISO file** and select the Defender for IoT software you downloaded earlier. <!-- may need to change isnt relevant anymore!!OR change to provided as a prereq/ by the .... team -->

1. Select **Next** > **Finish**.

    The installation boots and a wizard opens, for example:

    :::image type="content" source="../media/4-iot-iso-boot.png" alt-text="Screenshot of the installation wizard for mounting the ISO file on the OT sensor virtual machine":::

1. Select **Install iot-sensor_23.1.1.75399077**. <!-- change this to say Select the correct install version that appears in the list, for example **Install iot-sensor_23.1.1.75399077** -->

    The installation process takes 20-30 minutes. When completed the default network details are shown. While the default IP, subnet, and gateway addresses are identical with each installation, the UID is unique for each appliance. For example:
  
    ```bash
    IP: 192.168.0.101, 
    SUBNET: 255.255.255.0, 
    GATEWAY: 192.168.0.1,
    UID: 91F14D56-C1E4-966F-726F-006A527C61D
    ```

    The IP address is needed to access the sensor for initial setup and activation.

### Post-installation validation
<!-- do we really need to include this section for the LM? -->
This procedure describes how to validate your installation using the sensor's own system health checks and is available to the default *admin* user.

**To validate your installation**:

1. Sign in to the OT sensor as the `admin` user.

1. Select **System Settings** > **Sensor management** > **System Health Check**.

1. Select the following commands:

    - **Appliance** to check that the system is running. Verify that each line item shows **Running** and that the last line states that the **System is up**.
    - **Version** to verify that you have the correct version installed.
    - **ifconfig** to verify that all input interfaces configured during installation are running.
<!-- I would prefer this heading to be ## Activate and initial setup as is in the diagram before -->
## Define initial setup

The following procedure describes how to configure your sensor's initial setup settings, including:

- Signing into the sensor console and changing the *admin* user password
- Defining network details for your sensor
- Defining the interfaces you want to monitor
- Activating your sensor
- Configuring SSL/TLS certificate settings

### Signing in to the sensor

Open a browser in the virtual machine.

1. Enter the IP address given at the end of the sensor installation, ```192.168.0.101```. The initial sign-in page appears, for example:

    :::image type="content" source="../media/4-console-sign-in-page.png" alt-text="Screenshot of sensor console sign in":::
1. Enter the following credentials:<!-- how do we know they have chosen the correct sensor verison? define that above-->

    Username: ```admin```
    Password: ```admin```
1. Select Login.
1. Define a new password for the admin user, containing lowercase and uppercase alphabetic characters, numbers and symbols.<!-- not sure we really need this? Although it is important , it isnt the direct part of the process? What do you think?-->

## Activate and initial setup

The **Defender for IoT | Overview** page opens to the **Management interface** tab.
<!-- add screenshot of the Overview page here -->

### Define network details

In the **Management interface** tab, define the network details for the sensor. Even though default network values are given after the monitoring software is installed, it's best practice to give different names or settings for security purposes. For example:
<!-- check data with engineer -->

|Name  |Description  |
|---------|---------|
|**Management interface**     | paris-sales-floor1  |
|**IP Address**     |   172.23.42.12|
|**Subnet Mask**     |     255.20.98.75    |
|**Default Gateway**     |  172.18.24.214     |
|**DNS**     |   10.50.10.50  |
|**Hostname**     |    iot-sensor    |

When you're done, select **Next: Interface configurations** to continue.

### Select interfaces to monitor
<!-- should the content of the next 3 sections be numbered as a procedure or are they too short?-->
The Interface configurations tab shows all of the interfaces detected by the sensor.

In the **Interface Configurations** tab:

1. Choose the interface to be monitored by setting the toggle button to **Enable**.
1. Select **Save** to save your changes.
1. Select **Next: Reboot >** to continue.
1. Select **Start reboot** to reboot your sensor machine.

### Upload activation file

The activation tab is the section to upload the activation file received from the Deployment team.

After rebooting, the virtual machine opens to the **Defender for IoT | Overview** page. In the **Activation** tab:

1. Select **Upload** and add the activation file.
1. Select the **Terms and Condition** option.
1. Select **Next:Certificates**.

### Define certificate settings

In the **Certificates** tab:

1. Select **Use Locally generated self-signed certificate (Not recommended)**.
1. Select the **Confirm** option.
1. Finally, select **Finish** to complete the initial setup and open the sensor.

## Check your work

Verify that your sensor is connected to Azure by checking its connectivity status in Defender for IoT.

1. Open Defender for IoT in the Azure portal.
1. Select the **Sites and sensors** section.
1. Check that your sensor is listed and the status is *connected*. <!-- there is no connected status. ....and the correct sensor version is listed, and the sensor health is healthy ? -->
1. Check that device data appears by selecting **Device inventory** and then selecting a device.
<!-- is this last point correct? what would be the correct check?  -->
<!-- Cat: Add screenshot image of a successful outcome-->
:::image type="content" source="../media/4-device-inventory.png" alt-text="Screenshot of the Defender for IoT Device inventory page showing recent data from the sensor":::
