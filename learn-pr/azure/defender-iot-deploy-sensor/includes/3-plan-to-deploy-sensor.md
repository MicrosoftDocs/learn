Your car manufacturing organization has offices and production sites across the globe, with a network linking them together. In earlier phases, the deployment team onboarded a sensor to Defender for IoT and the connectivity team set-up the site networking. For this module, you have a virtual machine (VM) ready to act as the operational technology (OT) sensor. Your task is to deploy the sensor by installing the OT monitoring software and activate the sensor to send data to the Azure portal. This unit provides an overview of this process.

## Your organization's OT sensor deployment plan

The OT sensor deployment plan is shown in the following diagram:

:::image type="content" source="../media/3-deploy-sensor-path.png" alt-text="Diagram of the sensor deployment path" border="false":::
<!-- redo this image, it is now incorrect with the set up VM, must be removed-->
This Learn Module deals with installing and activating the monitoring software on the virtual machine OT sensor.

### Check your virtual machine

The first stage in deploying the OT sensor monitoring software is to check that your virtual machine is correctly configured to act as the OT sensor.

We use the VMware ESXi virtual machine, but other systems such as HyperV could also be used. The information below is for setting up the ESXi, but you might need to refer to your virtual machine software documentation for more details.

## Install Defender for IoT software

In a real life scenario, your organization can buy configured sensors. So, you wouldn't need to complete this step. But for this module, to install software in the VM, you complete the following steps in the exercise unit:

1. Download and save the OT monitoring software installation file from the Defender for IoT setup page.

1. Open the virtual machine, run the installation file, and follow the stages in the installation wizard. Once the installation is complete the default network details are displayed.

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
