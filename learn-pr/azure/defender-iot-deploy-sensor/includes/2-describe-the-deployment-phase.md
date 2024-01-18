To deploy the OT sensors in your car manufacturing organization, you install, configure and activate the OT monitoring software on the sensor. For this, you need a Virtual Machine set up with four virtual CPU's, 8 GB memory, 100 GB storage and a maximum bandwidth of 100 Mb/sec.

Once you deploy and activate the sensor, Defender for IoT displays traffic data detected on the sensor, including detected devices and triggered alerts.
<!--It is possible that the intro lines from unit 2 and 3 should be swapped. The instructions from Cat are that unit 2 is more about the placement of this unit in the entire process, and unit 3 is the process itself. -->
## OT sensor deployment path

The following diagram shows the complete OT deployment path, with the team responsible for each phase:

:::image type="content" source="../media/2-ot-deploy.png" alt-text="Diagram of the complete OT deployment process" border="false":::

This module describes the fourth phase in the deployment: *Deploy sensors*. In a real-life scenario, the deployment and connectivity teams ensure that the sensor is already onboarded, the networks set up, and the activation file is available.

The OT sensor deployment is the phase where you upload, install, and set up the monitoring software on the sensor to securely manage and send data to the Azure portal.

## In this phase

For this module, you need to download the monitoring ISO file and install it on the sensor. The interface, the endpoint appliance being tracked/ protected <!-- which is correct term? -->by the sensor, must be set up and enabled. Finally, you upload the activation file and assign a security certificate to the sensor.

Real-life deployment of the OT sensor monitoring software can include extra security features such as using a CA-signed certificate or a proxy connection to the Azure portal. This module covers a basic deployment only and will use a self signed certificate.
