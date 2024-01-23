This unit describes how to download the OT monitoring software from the Defender for IoT site. Then upload the software to a virtual machine and start the application on the sensor. Afterwards, configure the network settings so that the sensor can connect with the Azure portal. Finally, assign the end point interfaces, activate the sensor and set up the security certificates.

1. **Configure firewall so that the sensor can connect to Azure**

    <!--previous module add after download activation file - save list of endpoints-->

    Configure your firewall rules so that your sensor can access the cloud on port 443, and connect to each of the listed endpoints in the downloaded list.
<!-- Cat has said to use H2 headings as we did in unit 3. But I used numbering as we did in LM3, as per Batami (i think), I have changed it but I am not sure how this applies to uniformity between modules? THe other difference is there are more steps here? -->

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

    In Defender for IoT select **Getting started > Sensor**, then select the software version 
<!-- what are the software names - can i copy a name from the Jenkins list of software? --> and select **Download**.

    Save the ISO file to a safe location on your computer, so that it can be uploaded to the virtual machine. 
<!-- [Is this correct? can it be saved directly to the virtual machine?]-->

### Install the monitoring software on the virtual machine

    On the virtual machine, use the system specific application for mounting the ISO file onto the machine. In this scenario, we're using the iLO for HPE machines. <!-- is this written correctly? -->

    The installation boots and a wizard opens, for example:

    :::image type="content" source="../media/4-iot-iso-boot.png" alt-text="Screenshot of the installation wizard for mounting the ISO file on the OT sensor virtual machine":::

    Select **Install iot-sensor_23.1.1.75399077**. The installation process takes 20-30 minutes. When completed the default network details are shown. While the default IP, subnet, and gateway addresses are identical with each installation, the UID is unique for each appliance. For example:

    ```bash
    IP: 192.168.0.101, 
    SUBNET: 255.255.255.0, 
    GATEWAY: 192.168.0.1,
    UID: 91F14D56-C1E4-966F-726F-006A527C61D
    ```

    The IP address is needed to access the sensor for initial setup and activation.

### Define network settings

    Open a browser in the virtual machine, enter the IP address given at the end of the sensor installation, ```192.168.0.101```. The initial sign-in page appears, for example:

    :::image type="content" source="../media/4-console-sign-in-page.png" alt-text="Screenshot of sensor console sign in":::

    Enter the following credentials and select Login:

    Username: ```admin```
    Password: ```admin```

    Define a new password for the admin user, containing lowercase and uppercase alphabetic characters, numbers and symbols.<!-- not sure we really need this? Although it is important , it isnt the direct part of the process? What do you think?-->
<!-- what login credentials are to be used? -->
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
    The Interface configurations tab shows all of the interfaces detected by the sensor. In the **Interface Configurations** tab, choose the interface to be monitored by setting the toggle button to **Enable**.

    Select **Save** to save your changes.

    Select **Next: Reboot >** to continue, and then **Start reboot** to reboot your sensor machine.

### Activation tab

    After rebooting, the virtual machine opens to the **Defender for IoT | Overview** page. In the **Activation** tab, select **Upload** and add the activation file. Select the **Terms and Condition** option and then select **Next:Certificates**.

### Certificates tab

    In the **Certificates** tab, select **Use Locally generated self-signed certificate (Not recommended)**, and then select the **Confirm** option.

    Finally, select **Finish** to complete the initial setup and open the sensor.

## Check your work

Verify that your sensor is connected to Azure by checking its connectivity status in Defender for IoT.

    1. Open Defender for IoT in the Azure portal. 
    1. Select the **Sites and sensors** section. 
    1. Check that your sensor is listed and the status is *connected*.
    1. Check that data appears in Defender for IoT by opening the sensor and selecting an interface.
<!-- is this last point correct?-->
<!-- Cat: Add screenshot image of a successful outcome-->