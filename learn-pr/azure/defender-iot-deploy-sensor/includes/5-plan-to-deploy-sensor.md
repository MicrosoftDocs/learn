Your car manufacturing organization has offices and production sites across the globe, with a network linking them together. A sensor was onboarded to Defender for IoT and the site networking is set up. A virtual machine is active which runs your sensor.

Now your task is to deploy the OT monitoring software on to the sensor and activating the sensor to send data to the Azure portal.

## Your organization's OT sensor deployment plan

The OT sensor deployment plan is shown in the following diagram:

:::image type="content" source="../media/5-deploy-sensor-path.png" alt-text="Diagram of the sensor deployment path" border="false":::

## Install Defender for IoT software

Download and save the OT monitoring software installation file from the Defender for IoT setup page.

Open the virtual machine, run the installation file, and follow the stages in the wizard to install the software. Once the installation is complete the default network details are displayed. In a real life scenario, configured sensors can be bought and this step is skipped.

## Activate and set up the sensor

Configure the sensor in a browser, and provide the sensor administrator username and password.

The browser displays the **Defender for IoT | Overview** page, which leads you through the four stages of setting up the sensor. Each stage is displayed in its own tab.
<!-- Ask to have this stage checked as I havent seen it yet.  where can we see a proper screen shot of this? check the titles of each section and how best to write these items based on that - add screenshot of the overview screen -->

### Define network details

In the **Management interface** tab, you define the network details that connect the sensor to Defender for IoT. You need the following details:

|Name  |Description  |
|---------|---------|
|**Management interface**     |  Select the interface you want to use. |
|**IP Address**     |  Type the IP address for the sensor, which you use to connect to the sensor via the browser. |
|**Subnet Mask**     | Type the address you want to use as the sensor's subnet mask.        |
|**Default Gateway**     | Type the address you want to use as the sensor's default gateway.        |
|**DNS**     |   Type the sensor's DNS server IP address.      |
|**Hostname**     |  Type the hostname you want to assign to the sensor. Make sure that you use the same hostname as is defined in the DNS server.       |

### Select interfaces to monitor

The **Interface configurations** tab shows each interface on the sensor, which should match the list of endpoints in the network diagram. You set up each interface individually.

Select and enable each interface to be monitored. If you're unsure which interface to use, select the :::image type="icon" source="../media/3-blink-interface.png" alt-text="blink interface icon"::: Blink physical interface LED button to have the selected port blink on your machine. Select any of the interfaces that are connected to your switch.

### Upload activation file

In the **Activation** tab upload the activation file, provided by the deployment team.

### Define certificate settings

In the **Certificates** tab, deploy the SSL/TLS certificate settings. It's best practice to use a CA-signed certificate that's more secure, however in our test environment the self-signed certificate is secure enough.

Once these tasks are performed the sensor deployment process is complete and it can send data to the Azure portal.
