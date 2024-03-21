Your sensor is now fine-tuned so that the devices are correctly identified, configured, and located within the device map and system hierarchy. The final action for setting up the sensor is to triage the alerts that Microsoft Defender for IoT creates during the *Learning* mode.

## View your alerts
<!-- is this supposed to be in portal or sensor? -->
First, identify which alerts are important to triage.

1. In Defender for IoT, open **Alerts**.
1. Use the **Search** box or **Add filter** to filter/ display a set of alerts.
1. Select the alert by ticking the checkbox for that row.
1. Select **View full details** to drill down further and see the remediation suggestions.<!-- with this last few words, the image should be of the remediation?? but here is a different image. and the remediation is in the next section. What should I do for this? LW --> For example:

    :::image type="content" source="../media/7-alert-detected.png" alt-text="screenshot of a chosen alert to view the full alert details" lightbox="../media/7-alert-detected.png":::

## Triage an alert

The **Alerts** page provides more details about the alert.

1. Using the **Alert details** tab and the other information, analyze the alert and decide if it requires a security response or is normal network traffic.
1. The **Take action** Tab lists the remediation steps or options needed to fix the problem. Choose which steps to follow depending on your analysis of the alert.
    For example:
    1. If the alert is normal network traffic, choose Select Learn.
    1. If the alert requires a security response, consult a relevant Control Systems Engineer to validate the origin of the alert.

    :::image type="content" source="../media/7-alert-full-details.png" alt-text="Screenshot of the alert details with the Take Action box highlighted" lightbox="../media/7-alert-full-details.png" :::

1. To complete the triage, update the alert severity and alert status. Select **Apply** to keep the changes.

Give example of an alert or two types of alerts with different changes made. And also different severity and status changes.

### Select multiple alerts

You can also select several alerts to triage at the same time, however you aren't able to see their details together. You're able to make bulk changes to their severity or status levels or apply the *learn* setting using the Alerts page menu bar. <!-- highlight in image below -->

:::image type="content" source="../media/7-bulk-alert-triage.png" alt-text="Screenshot of bulk update of alerts, in this case updating the severity level for these alerts" lightbox="../media/7-bulk-alert-triage.png":::
OR
:::image type="content" source="../media/7-bulk-alert-triage1.png" alt-text="Screenshot of bulk update of alerts, in this case updating the severity level for these alerts thick box" lightbox="../media/7-bulk-alert-triage1.png":::

### Create suppression rules if possible

What to write here?

## Select a few to triage and learn to add them to your learned network baseline

 how do we do this? Who to speak to? Vhathek?
Filter alerts
choose type of alert
view full details
<!-- <https://learn.microsoft.com/en-us/azure/defender-for-iot/organizations/how-to-manage-cloud-alerts> <https://learn.microsoft.com/azure/defender-for-iot/organizations/how-to-view-alerts#manage-alert-status-and-triage-alerts>-->

## End Learning mode
<!-- Should this be part of the LM? Even though this will be done at a later time in real life, as part of the exercise it should be added to this unit. LW -->
After a week or two Defender for IoT learns to identify suspicious traffic and not send false alerts, you can turn off the *Learn* status.

In the Sensor:

1. Select **System settings**.
1. Select **Detection Engines and Network Modeling**.
1. Under **Network modeling**, toggle the **Learning** button to **Enabled**.
1. Select **Close**.

After this change, any new devices or traffic trigger an alert, which is assessed like other alerts.

## Check your work

What do we do to show the work is successful?
When you complete the triage process, the **Alerts** page shows the updated status of the alerts.