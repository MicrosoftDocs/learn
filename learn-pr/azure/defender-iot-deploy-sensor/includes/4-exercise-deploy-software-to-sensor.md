Before you start to deploy the sensor software, check that your environment is configured and meets the prerequisite requirements. In this unit, you download the Microsoft Defender for IoT monitoring software and install it on the Virtual Machine (VM) Operation Technology (OT) sensor. Then, configure the sensor network settings, configure the interfaces, activate the sensor, and set up the security certificates. After you complete those steps, the sensor is able to securely transfer data to the Azure portal.

## Prerequisites

Before you start the exercise, check that:

- The firewall is properly configured, ensuring that your sensor can access the cloud on port 443, and connect to each of the endpoints.
- The VM, VMware ESXi 5.5 or later, is configured to either of the following specifications:

    | Type |Memory  | Storage  | CPU Processor |
    |----|-----|---------|----|
    | Enterprise | 32 MB RAM | 1/1.8 TB |  4 Core/ 8 Threads |
    | Line | 8 MB RAM | 100/ 500 GB |  4 Core/ 4 Threads |

- The network adapter port groups for the internet and SNAP switch are configured, so that the VM is able to communicate with them. You might need to use Promiscuous mode in the VM to connect with the switches.
- The traffic mirroring is configured correctly.

## Install the monitoring software

First, download the software from Defender for IoT and then install the software on your VM.

### Download the monitoring software file

To get started, download the software from Defender for IoT.

1. In Defender for IoT select **Getting started > Sensor**.
1. Select the latest software version.

    :::image type="content" source="../media/4-download-iso-file.png" alt-text="Screenshot that highlights the option to select the software version before you download the ISO monitoring file from Defender for IoT." lightbox="../media/4-download-iso-file.png":::

1. Select **Download**.
1. Save the downloaded ISO file in a location that's accessible from your VM.

### Install the monitoring software on the VM

Connect to your VM to install the software.

1. On your VM, open the settings.

1. For **CD/DVD Drive 1**, select **Datastore ISO file** and select the ISO file of the monitoring software you downloaded earlier.

1. Select **Next** > **Finish**.

    The installation boots and a wizard opens, for example:

    :::image type="content" source="../media/4-iot-iso-boot.png" alt-text="Screenshot of the installation wizard for mounting the ISO file on the OT sensor virtual machine." :::

1. Select **Install iot-sensor_<version_number>**.

    The installation process takes 20-30 minutes. When the wizard completes the installation, it shows the default network details.

    While the default IP, subnet, and gateway addresses are identical with each installation, the UID is unique for each appliance. For example:
  
    ```bash
    IP: 192.168.0.101, 
    SUBNET: 255.255.255.0, 
    GATEWAY: 192.168.0.1,
    UID: 91F14D56-C1E4-966F-726F-006A527C61D
    ```

1. Make a note of the IP address. You need this information to access the sensor for initial setup and activation.

### Post-installation validation

Validate your installation using the sensor's own system health checks, available to the default *admin* user.

1. Sign in to the OT sensor as the `admin` user.

1. Select **System Settings** > **Sensor management** > **System Health Check**.

1. Select the following commands:

    - **Appliance** to check that the system is running. Verify that each line item shows **Running** and that the last line states that the **System is up**.
    - **Version** to verify that you have the correct version installed.
    - **ifconfig** to verify that all input interfaces configured during installation are running.

## Activate and initial setup

Sign in to the sensor to configure your sensor's initial settings. The setup has four stages.

### Sign in to the sensor

Open a browser in the VM.

1. Type the IP address given at the end of the sensor installation, ```192.168.0.101```. The initial sign-in page appears, for example:

    :::image type="content" source="../media/4-console-sign-in-page.png" alt-text="Screenshot of that shows the initial sign in for the sensor console.":::
1. Type the following credentials:

    Username: ```admin```
    Password: ```admin```

1. Select **Login**.

The **Sensor | Overview** page opens to the **Management interface** tab. Now you start to configure the settings.

### Define network details

Enter your sensor's network details so that it can connect to the interfaces and end points. In the **Management interface** tab:

1. Define the network details for the sensor. It's best practice to give different names or settings for security purposes, even though you were given default network values after the monitoring software installation. For example:

    |Name  |Description  |
    |---------|---------|
    |**Management interface**     | paris-sales-floor1  |
    |**IP Address**     |   172.23.42.12 |
    |**Subnet Mask**     |     255.20.98.75    |
    |**Default Gateway**     |  172.18.24.214     |
    |**DNS**     |   10.50.10.50  |
    |**Hostname**     |    iot-sensor    |

1. When you're done, select **Next: Interface configurations** to continue.

### Select interfaces to monitor

The **Interface configurations** tab shows all of the interfaces detected by the sensor.

In the **Interface Configurations** tab:

1. Select the interface to be monitored by setting the toggle button to **Enable**.
1. Select **Save** to save your changes.
1. Select **Next: Reboot >** to continue.
1. Select **Start reboot** to reboot your sensor machine.

### Upload activation file

The activation tab is the section to upload the activation file received from the Deployment team.

After rebooting, the VM opens to the **Defender for IoT | Overview** page. In the **Activation** tab:

1. Select **Upload** and add the activation file.
1. Select the **Terms and Condition** option.
1. Select **Next: Certificates**.

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

:::image type="content" source="../media/4-device-inventory.png" alt-text="Screenshot of the Defender for IoT Device inventory page showing recent data from the sensor."  lightbox="../media/4-device-inventory.png" :::
