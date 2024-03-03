<!-- can use this article for screenshots as well /organizations/how-to-manage-cloud-alerts -->
## Describe the baseline process

Your sensor is now fine tuned and almost fully operational. The final stage is to create a baseline of alerts so that Microsoft Defender for IoT understands the normal type of traffic flow through your system. This way Defender for IoT is able to identify which traffic is most dangerous or suspicious and produces accurate alerts. This *learning* process can take several weeks as you redefine any incorrect alerts that Defender for IoT flags.

Once the learning process is complete, Defender for IoT creates an accurate baseline of alerts to work from and protect your devices. It's still possible that you have to add new alerts but this occurs on a less regular basis than in the initial period.

## OT sensor learning mode

The following diagram shows the complete OT deployment path, with the team responsible for each phase:

:::image type="content" source="../media/2-ot-deploy.png" alt-text="Diagram of the complete OT deployment process" border="false":::

This Learn Module is divided into two sections.

Section 1: units 3 and 4 dealing with calibrating and fine-tuning your sensor.
Section 2: units 6 and 7 dealing with triaging the alerts.

Units 6 and 7 describes the sixth and final phase in the deployment: *Baseline learning ends*. In a real-life scenario, the deployment and connectivity teams ensure that the sensor is already activated, sending data to Defender for IoT, and is fine-tuned.

The sensor baseline learning is the phase where Defender for IoT identifies suspicious or harmful traffic and creates a list of alerts for each of them. When this traffic is identified in the future, alerts are sent to Defender for IoT, and you're able to contain and protect your devices. You must monitor these alerts and in some cases adjust them to be more accurate. This process can take anywhere from a few days to several weeks, depending on the complexity and size of your network.

## In this phase

### Triage alerts

Once the sensor is set up and sends data, Defender for IoT starts to identify normal and irregular traffic flow within the network. This state is called the learning mode, where Defender for IoT identifies regular activity, such as regular file transfers or data flows between devices. This regular activity is logged and won't trigger an alert in the future. Any traffic in the network that doesn't match these triggers an alert.

The new alerts that are sent to Defender for IoT must be checked and in some cases you need to adjust their status. This way Defender for IoT learns which alerts are real cases of harmful traffic and which are unsuspicious and can be added to the baseline. The learning process can take several weeks to complete.

### End the learning mode

The learning mode will turn off when the sensor detects a decrease in the number of new alerts produced, which is typically 2-6 weeks after deployment. You can also turn off the learning mode manually when you feel that the alerts accurately reflect your network activity.

As new alerts are detected in the future, they can be set, individually, to learning mode, and then included in a new baseline once the sensor correctly identifies them. This ensures that your baseline of alerts is up to date, doesn't miss new types of suspicious traffic and keeps your network and devices safe.
