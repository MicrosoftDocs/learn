To deploy the Operational Technology (OT) sensors in your car manufacturing organization, install, configure, and activate the OT monitoring software on the sensor. In our case, the software is installed on a virtual machine (VM).

Once you deploy and activate the sensor, Defender for IoT displays traffic data sent by the sensor, including detected devices and triggered alerts.

## OT sensor deployment path

The following diagram shows the complete OT deployment path, with the team responsible for each phase:

:::image type="content" source="../media/2-ot-deploy.png" alt-text="Diagram of the complete OT deployment process." border="false":::

This module describes the fourth phase in the deployment: *Deploy sensors*. In a real-life scenario, the deployment and connectivity teams ensure that the sensor is already onboarded, the networks are set up, and the activation file is available.

The OT sensor deployment is the phase where you upload, install, and set up the monitoring software on the sensor to securely manage and send data to the Azure portal.

## In this phase

In this module, you perform these processes:

- Check your environment meets the prerequisites.
- Download the monitoring ISO file.
- Install the monitoring software on the VM sensor.
- Configure the network and interface settings that the sensor monitors.
- Upload the activation file and assign a security certificate to the sensor.

Real-life deployment of the OT sensor monitoring software can include extra security features such as using a CA-signed certificate or a proxy connection to the Azure portal. This module covers a basic deployment only and uses a self signed certificate.
