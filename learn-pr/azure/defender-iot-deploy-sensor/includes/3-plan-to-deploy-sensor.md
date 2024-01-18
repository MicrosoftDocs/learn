
Your car manufacturing organization has offices and production sites across the globe, with a network linking them together. A sensor was onboarded to Defender for IoT and the site networking is set up. Now your task is to deploy the sensor by installing the OT monitoring software and activating the sensor to send data to the Azure portal.

## Your organization's OT sensor deployment plan

The OT sensor deployment plan is shown in the following diagram:

:::image type="content" source="../media/3-deploy-sensors.png" alt-text="Diagram of the sensor deployment path" border="false":::

You download the OT monitoring software installation file from the Defender for IoT setup page, and then install it on the OT sensor appliance. In this case, the appliance is a virtual machine. You will need the details of two network adapters, one to connect the sensor to the Azure portal for could management. The second, connects the sensor to a traffic mirroring port. This information should be found in the virtual machine software documentation. <!-- as per /ot-deploy/install-software-ot-sensor does this seem correct? I think so.-->

Run the installation file on the virtual machine, and follow the stages in the wizard to install the software. When the installation is completed the default network details are displayed. In a real life scenario, configured sensors can be bought and this step is skipped.

Next, configure the sensor in a browser, which requires the sensor administrator username and password. The browser displays the **Defender for IoT | Overview** page, which leads you through the four stages of setting up the sensor, each stage is displayed in its own tab. They are:
<!-- where can we see a proper screen shot of this? check the titles of each section and how best to write these items based on that - add screenshot of the oiverview screen -->
1. The Management tab interface where you define the network details that connect the sensor to Defender for IoT. You will need to have the following details:

    |Name  |Description  |
    |---------|---------|
    |**Management interface**     |  Select the interface you want to use as the management interface to connect to the Azure portal. |
    |**IP Address**     |  Enter the IP address for the sensor, which you use to connect to the sensor via the browser. |
    |**Subnet Mask**     | Enter the address you want to use as the sensor's subnet mask.        |
    |**Default Gateway**     | Enter the address you want to use as the sensor's default gateway.        |
    |**DNS**     |   Enter the sensor's DNS server IP address.      |
    |**Hostname**     |  Enter the hostname you want to assign to the sensor. Make sure that you use the same hostname as is defined in the DNS server.       |

1. The Interface tab configuration shows each interface on the sensor, this should match the list of endpoints in the network diagram. Each interface is set up individually.

    Select and enable each interface to be monitored. If you're unsure which interface to use, select the :::image type="icon" source="../media/3-blink-interface.png" alt-text="blink interface icon"::: Blink physical interface LED button to have the selected port blink on your machine. Select any of the interfaces that you've connected to your switch. <!--is this only if you are close to the sensor? How would this work for a cloud sensor?-->
    There are optional, advanced options that can be set for each interface, as follows:

     |Name  |Description  |
     |---------|---------|
     |**Mode**| Select one of the following: </br>- SPAN Traffic (no encapsulation) to use the default SPAN port mirroring.</br> - ERSPAN if you're using ERSPAN mirroring.|
     |**Description**| Enter an optional description for the interface. These descriptions may be helpful in understanding the purpose of each interface.|

1. The Activation tab upload the activation file, downloaded after onboarding the sensor, to activate the sensor.

1. Finally, define the SSL/TLS certificate settings. It's best practice to use a CA-signed certificate that is more secure, however in our test environment the self-signed certificate is secure enough.  <!-- should there be any more added about how to make a certificate or is this enough? There is this section /defender-for-iot/organizations/how-to-manage-individual-sensors?branch=main&tabs=self-signed#manage-ssltls-certificates , but it seems a lot to add that in here, what is the expectation that they will have these? -->

The sensor is now deployed and can send data to the Azure portal. Open Defender for IoT in the Azure portal and you should already see data appear there.

Strong lead sentence; remainder of paragraph.
Visual (image, table, list)
### H3 heading
Strong lead sentence; remainder of paragraph.
Paragraph (optional)
Visual (image, table, list)
Paragraph (optional)
### H3 heading
Strong lead sentence; remainder of paragraph.
Paragraph (optional)
Visual (image, table, list)
Paragraph (optional)

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->