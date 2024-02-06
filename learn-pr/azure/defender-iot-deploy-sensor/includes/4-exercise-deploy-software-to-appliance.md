This unit describes how to download the OT monitoring software from the Defender for IoT site. Then upload the software to a virtual machine and start the application on the sensor. Afterwards, configure the network settings so that the sensor can connect with the Azure portal. Finally, assign the end point interfaces, activate the sensor and set up the security certificates.

## Configure firewall to allow the sensor to connect to Azure

<!--previous module add after download activation file - save a list of all the endpoints-->

Configure your firewall rules so that your sensor can access the cloud on port 443, and connect to each of the listed endpoints in the downloaded list.
<!-- Cat has said to use H2 headings as we did in unit 3. But I used numbering as we did in LM3, as per Batami (i think), I have changed it but I am not sure how this applies to uniformity between modules? THe other difference is there are more steps here? -->

## Create a virtual machine with ESXi

For this you will need VMware, ESXi 5.5 or later, installed and operational on your sensor.

- <a name="hw"></a>Available hardware resources for your VM as follows:

    | Deployment type | Corporate | Enterprise | SMB |
    |--|--|--|--|
    | **Maximum bandwidth** | 2.5 Gb/sec | 800 Mb/sec | 160 Mb/sec |
    | **Maximum protected devices** | 12,000 | 10,000 | 800 |

Details for the following network parameters to use for your sensor appliance:

    - A management network IP address
    - A sensor subnet mask
    - An appliance hostname
    - A DNS address
    - A default gateway
    - Any input interfaces

## Create a VM for your sensor

This procedure describes how to create a VM for your sensor with VMware ESXi.

<!--Defender for IoT also supports other processes, such as using Hyper-V or physical sensors. For more information, see [Defender for IoT installation](how-to-install-software.md).-->

**To create a VM for your sensor**:

1. Make sure that VMware is running on your machine.

1. Sign in to the ESXi, choose the relevant **datastore**, and select **Datastore Browser**.

1. **Upload** the image and select **Close**.

1. Go to **Virtual Machines**, and then select **Create/Register VM**.

1. Select **Create new virtual machine**, and then select **Next**.

1. Add a sensor name and then define the following options:

   - Compatibility: **&lt;latest ESXi version&gt;**

   - Guest OS family: **Linux**

   - Guest OS version: **Ubuntu Linux (64-bit)**

1. Select **Next**.

1. Choose the relevant datastore and select **Next**.

1. Change the virtual hardware parameters according to the required specifications for your needs. For more information, see the [table in the Prerequisites](#hw) section above.

Your VM is now prepared for your Defender for IoT software installation. You'll continue by installing the software later on in this tutorial, after you've onboarded your sensor in the Azure portal, configured traffic mirroring, and provisioned the machine for cloud management.

## Configure a SPAN port

Virtual switches don't have mirroring capabilities. However, for the sake of this tutorial you can use *promiscuous mode* in a virtual switch environment to view all network traffic that goes through the virtual switch.

This procedure describes how to configure a SPAN port using a workaround with VMware ESXi.

> [!NOTE]
> Promiscuous mode is an operating mode and a security monitoring technique for a VM's interfaces in the same portgroup level as the virtual switch to view the switch's network traffic. Promiscuous mode is disabled by default but can be defined at the virtual switch or portgroup level.
>

**To configure a monitoring interface with Promiscuous mode on an ESXi v-Switch**:

1. Open the vSwitch properties page and select **Add standard virtual switch**.

1. Enter **SPAN Network** as the network label.

1. In the MTU field, enter **4096**.

1. Select **Security**, and verify that the **Promiscuous Mode** policy is set to **Accept** mode.

1. Select **Add** to close the vSwitch properties.

1. Highlight the vSwitch you've created, and select **Add uplink**.

1. Select the physical NIC you'll use for the SPAN traffic, change the MTU to **4096**, then select **Save**.

1. Open the **Port Group** properties page and select **Add Port Group**.

1. Enter **SPAN Port Group** as the name, enter **4095** as the VLAN ID, and select **SPAN Network** in the vSwitch drop down, then select **Add**.

1. Open the **OT Sensor VM** properties.

1. For **Network Adapter 2**, select the **SPAN** network.

1. Select **OK**.

1. Connect to the sensor, and verify that mirroring works.

<!--[!INCLUDE [validate-traffic-mirroring](includes/validate-traffic-mirroring.md)]-->
<!-- should we keep this link or better to copy the content. ?-->

## Install Defender for IoT software

To start the software installation, open your virtual machine.

### Configure the virtual machine

The virtual machine must have two network adapters configured, one that connects to the Azure portal, and the other to the traffic mirroring ports on the sensor.

On your virtual machine:

1. Open the VM settings
1. Add two new network adaptors, give each a significant name so they're easily identifiable, such as:
    - **Azure network adapter** - to connect to the Azure portal
    - **Mirroring port adapter** - to connect to the sensor mirroring port

### Download the monitoring software file

In Defender for IoT select **Getting started > Sensor**, then select the software version and select **Download**.
<!-- what are the software names - can i copy a name from the Jenkins list of software? -->

Save the downloaded ISO file in a location that's accessible from your VM.

All files downloaded from the Azure portal are signed by root of trust so that your machines use signed assets only.

### Install the monitoring software on the virtual machine

On your virtual machine:

1. Mount the ISO file onto the virtual machine using the system specific application. In this scenario, we're using the iLO for HPE machines. <!-- is this written correctly? -->

> [!NOTE]
> Towards the end of this process you will be presented with the usernames and passwords for your device. Make sure to copy these down as these passwords will not be presented again.

**To install the software on the virtual sensor**:

1. If you closed your VM, sign into the ESXi again and open your VM settings.

<!--1. For **CD/DVD Drive 1**, select **Datastore ISO file** and select the Defender for IoT software you'd [downloaded earlier](#download-software-for-your-virtual-sensor).-->

1. Select **Next** > **Finish**.

    The installation boots and a wizard opens, for example:

    :::image type="content" source="../media/4-iot-iso-boot.png" alt-text="Screenshot of the installation wizard for mounting the ISO file on the OT sensor virtual machine":::

1. Select **Install iot-sensor_23.1.1.75399077**.

    The installation process takes 20-30 minutes. When completed the default network details are shown. While the default IP, subnet, and gateway addresses are identical with each installation, the UID is unique for each appliance. For example:
  
    ```bash
    IP: 192.168.0.101, 
    SUBNET: 255.255.255.0, 
    GATEWAY: 192.168.0.1,
    UID: 91F14D56-C1E4-966F-726F-006A527C61D
    ```

    The IP address is needed to access the sensor for initial setup and activation.

### Post-installation validation

This procedure describes how to validate your installation using the sensor's own system health checks and is available to the default *admin* user.

**To validate your installation**:

1. Sign in to the OT sensor as the `admin` user.

1. Select **System Settings** > **Sensor management** > **System Health Check**.

1. Select the following commands:

    - **Appliance** to check that the system is running. Verify that each line item shows **Running** and that the last line states that the **System is up**.
    - **Version** to verify that you have the correct version installed.
    - **ifconfig** to verify that all input interfaces configured during installation are running.

<!--For more post-installation validation tests, such as gateway, DNS or firewall checks, see [Validate an OT sensor software installation](ot-deploy/post-install-validation-ot-software.md).-->

## Define initial setup

The following procedure describes how to configure your sensor's initial setup settings, including:

- Signing into the sensor console and changing the *admin* user password
- Defining network details for your sensor
- Defining the interfaces you want to monitor
- Activating your sensor
- Configuring SSL/TLS certificate settings

### Define network settings

Open a browser in the virtual machine.

1. Enter the IP address given at the end of the sensor installation, ```192.168.0.101```. The initial sign-in page appears, for example:

    :::image type="content" source="../media/4-console-sign-in-page.png" alt-text="Screenshot of sensor console sign in":::
1. Enter the following credentials:

    Username: ```admin```
    Password: ```admin```
1. Select Login.
1. Define a new password for the admin user, containing lowercase and uppercase alphabetic characters, numbers and symbols.<!-- not sure we really need this? Although it is important , it isnt the direct part of the process? What do you think?-->

## Activate and initial setup

The **Defender for IoT | Overview** page opens to the **Management interface** tab.
<!-- add screenshot of the Overview page here -->

### Management interface tab

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

### Interface configurations tab
<!-- should the content of the next 3 sections be numbered as a procedure or are they too short?-->
The Interface configurations tab shows all of the interfaces detected by the sensor.

In the **Interface Configurations** tab:

1. Choose the interface to be monitored by setting the toggle button to **Enable**.
1. Select **Save** to save your changes.
1. Select **Next: Reboot >** to continue.
1. Select **Start reboot** to reboot your sensor machine.

### Activation tab

The activation tab is the section to upload the activation file recieved from the Deployment team.

After rebooting, the virtual machine opens to the **Defender for IoT | Overview** page. In the **Activation** tab:

1. Select **Upload** and add the activation file.
1. Select the **Terms and Condition** option.
1. Select **Next:Certificates**.

### Certificates tab

In the **Certificates** tab:

1. Select **Use Locally generated self-signed certificate (Not recommended)**.
1. Select the **Confirm** option.
1. Finally, select **Finish** to complete the initial setup and open the sensor.

## Check your work

Verify that your sensor is connected to Azure by checking its connectivity status in Defender for IoT.

1. Open Defender for IoT in the Azure portal.
1. Select the **Sites and sensors** section.
1. Check that your sensor is listed and the status is *connected*.
1. Check that data appears in Defender for IoT by opening the sensor and selecting an interface.
<!-- is this last point correct?-->
<!-- Cat: Add screenshot image of a successful outcome-->