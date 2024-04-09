Your sensor is now fine-tuned so that the devices are correctly identified, configured, and located within the device map and system hierarchy. The final action for setting up the sensor is to triage the alerts that are listed in Microsoft Defender for IoT during the *Learning* mode.

## End Learning mode
<!-- Should this be part of the LM? Even though this will be done at a later time in real life, as part of the exercise it should be added to this unit. LW -->
After a week or two, Defender for IoT learns to identify suspicious traffic and not send false alerts and then you can turn off the *Learn* mode.

In the Sensor:

1. Select **System settings**.
1. Select **Detection Engines and Network Modeling**.
1. Under **Network modeling**, toggle the **Learning** button to **Enabled**.
1. Select **Close**.

After this change, any new devices or traffic trigger an alert, which is assessed like other alerts.

## Check your work

When you complete the triage process, the **Alerts** page shows the updated status of the alerts.
