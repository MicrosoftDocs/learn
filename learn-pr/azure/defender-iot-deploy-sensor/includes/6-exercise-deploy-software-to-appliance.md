This unit describes how to download the OT monitoring software from the Defender for IoT in the Azure portal. Then upload the monitoring software to the virtual machine OT sensor. Afterwards, configure the network settings so that the sensor connects with the Azure portal. Finally, assign the end point interfaces, activate the sensor and set up the security certificates.
<!-- check all images for compliance - may need to redo them or edit -->

## Install Defender for IoT software

To start the software installation, open your virtual machine.

### Download the monitoring software file

In Defender for IoT select **Getting started > Sensor**, then select the latest software version and select **Download**. <!-- must ensure they download the correct software version otherwise the admin and log in will be incorrect, if it is different on older versions -->
<!-- is this file 'given' to the person as a prerequisite? -->
:::image type="content" source="../media/6-download-iso-file.png" alt-text="screenshot of Downloading ISO monitoring file from Defender for IoT":::

Save the downloaded ISO file in a location that's accessible from your VM.

All files downloaded from the Azure portal are signed by root of trust so that your machines use signed assets only.

### Install the monitoring software on the virtual machine

On your virtual machine:

1. Open your VM settings.

1. For **CD/DVD Drive 1**, select **Datastore ISO file** and select the Defender for IoT software you downloaded earlier. <!-- may need to change isnt relevant anymore!!OR change to provided as a prereq/ by the .... team MT -->

1. Select **Next** > **Finish**.

    The installation boots and a wizard opens, for example:

    :::image type="content" source="../media/6-iot-iso-boot.png" alt-text="Screenshot of the installation wizard for mounting the ISO file on the OT sensor virtual machine":::

1. Select **Install iot-sensor_<version_number>**.

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
Validate your installation using the sensor's own system health checks, available to the default *admin* user.

**To validate your installation**:

1. Sign in to the OT sensor as the `admin` user.

1. Select **System Settings** > **Sensor management** > **System Health Check**.

1. Select the following commands:

    - **Appliance** to check that the system is running. Verify that each line item shows **Running** and that the last line states that the **System is up**.
    - **Version** to verify that you have the correct version installed.
    - **ifconfig** to verify that all input interfaces configured during installation are running.
<!-- I would prefer this heading to be ## Activate and initial setup as is in the diagram before -->
## Define initial setup

Sign in to the sensor and then configure your sensor's initial settings, which has four stages.

Open a browser in the virtual machine.

1. Type the IP address given at the end of the sensor installation, ```192.168.0.101```. The initial sign-in page appears, for example:

    :::image type="content" source="../media/6-console-sign-in-page.png" alt-text="Screenshot of sensor console sign in":::
1. Type the following credentials:<!-- how do we know they have chosen the correct sensor verison? define that above-->

    Username: ```admin```
    Password: ```admin```
1. Select Login.

## Activate and initial setup

The **Defender for IoT | Overview** page opens to the **Management interface** tab. Now you start to configure the settings.
<!-- add screenshot of the Overview page here -->

### Define network details

In the **Management interface** tab, define the network details for the sensor. Even though default network values are given after the monitoring software is installed, it's best practice to give different names or settings for security purposes. For example:

|Name  |Description  |
|---------|---------|
|**Management interface**     | paris-sales-floor1  |
|**IP Address**     |   172.23.42.12 |
|**Subnet Mask**     |     255.20.98.75    |
|**Default Gateway**     |  172.18.24.214     |
|**DNS**     |   10.50.10.50  |
|**Hostname**     |    iot-sensor    |

When you're done, select **Next: Interface configurations** to continue.

### Select interfaces to monitor

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
1. Check that your sensor is listed and the status is *healthy*.
1. Check that device data appears by selecting **Device inventory**.
<!-- Cat: Add screenshot image of a successful outcome-->
:::image type="content" source="../media/6-device-inventory.png" alt-text="Screenshot of the Defender for IoT Device inventory page showing recent data from the sensor":::
