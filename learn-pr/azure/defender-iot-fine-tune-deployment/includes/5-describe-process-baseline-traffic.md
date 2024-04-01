Your sensor is now fine tuned and almost fully operational. The final stage is to create a baseline of alerts so that Microsoft Defender for IoT understands the normal type of traffic flow through your system. Then, Defender for IoT is able to identify which traffic is most dangerous or suspicious and produces accurate alerts. This *learning* process can take a week or two as you define correct alerts for Defender for IoT to flag.

Once the learning stage is complete, Defender for IoT moves to the operational stage with an accurate baseline of alerts to work from and protect your devices. New alerts still appear, but occur less regularly, and you apply the triage process to them. <!-- is this all out of the scope of the LM? Probably-->  

## OT sensor learning mode

The following diagram shows the complete OT deployment path, with the team responsible for each phase:

:::image type="content" source="../media/5-ot-deploy.png" alt-text="Diagram of the complete OT deployment process" border="false":::

This Learn Module is divided into two sections.

Section 1: units 3 and 4 dealing with calibrating and fine-tuning your sensor.
Section 2: units 6 and 7 dealing with triaging the alerts.

Units 6 and 7 describe the sixth and final phase in the deployment: *Baseline learning ends*. In a real-life scenario, the deployment and connectivity teams ensure that the sensor is already activated, sending data to Defender for IoT, and is fine-tuned.

## The Learning mode

The sensor baseline learning is the phase where Defender for IoT identifies suspicious or harmful traffic and creates alerts for them. When this traffic is identified in the future, alerts are sent to Defender for IoT, and you're able to contain and protect your devices. You must monitor these alerts and in some cases adjust them to be more accurate. These alerts form the baseline of OT alerts for tracking activity when the system moves to the *operation* mode. This process can take anywhere from a few days to several weeks, depending on the complexity and size of your network.
<!--Over a period of weeks Defender for IoT reaches a mature stage and doesn't need regular assessment, and then ends the *Learning* mode and moves to the *operational* mode. -->

## In this phase

### Triage alerts

Once the sensor is set up and sending data, Defender for IoT starts to identify normal and irregular traffic flow within the network. This state is called the learning mode, where Defender for IoT identifies regular file transfers or data flows between devices. This regular activity is logged and won't trigger an alert in the future. Any network traffic that doesn't match these, triggers an alert.

The new alerts, listed in Defender for IoT, must be checked and in some cases you need to adjust their status. This way Defender for IoT learns which alerts are real cases of harmful traffic and which are normal, unrecognized traffic that can be added to the baseline. The learning process can take several weeks to complete.

As alerts arrive, you check that they're correctly assigned. In some cases during this phase, the alerts will be incorrect and you'll need to change the automatic settings so that the sensor learns that future traffic like this is safe. You might want to assign supression alerts to exclude minor alerts so that the alert page isnt filled with unwanted alerts.

In the early stages, you need to spend more time checking the alerts. Depending on the size and complexity of the system the learning mode could last from 2-6 weeks, and automatically turn offs when the sensor detects a decrease in newly detected alerts. However, you can also manually turn off the learning mode if you think that alerts produced accurately represent the network activity.

### End the learning mode
<!-- Should this be part of the LM? Even though this will be done at a later time in real life, as part of the exercise should it be added to this unit?-->
The learning mode will turn off when the sensor detects a decrease in the number of new alerts produced, which is typically 2-6 weeks after deployment. You can also turn off the learning mode manually when you see that the alerts accurately reflect your network activity. Going forward, anything that is new traffic creates an alert to be followed up with.

Even in the *operation* mode, you could still receive new alerts, and must check and triage them as well. Some of these new alerts are for regular network traffic. Even though the sensor isn't in the Learning mode you can assign these inaccurate alerts a learning status so that the sensor adds them to the existing baseline alerts. This ensures that your alerts baseline is up to date, doesn't miss new types of suspicious traffic and keeps your network and devices safe.

## Outcome of this process

When you complete the triage process, the **Alerts** page shows the updated status of the alerts.

OR
When you complete the triage process and the operational mode is enabled, your deployment of the OT sensor to Defender for IoT is complete. The sensor now has a verified baseline of alerts and understands the types of traffic that are considered safe and secure. <!-- do we need to add anything to this? Is there a list we can show that looks different from the original alerts list, or should we show a shortened list? Or a list of the baseline alerts? Or for this LM should the OUtcome be a shortened alert list? AN empty list? Amit LW- add filter to show differences with new alerts. -->
<!-- can use this article for screenshots as well /organizations/how-to-manage-cloud-alerts -->