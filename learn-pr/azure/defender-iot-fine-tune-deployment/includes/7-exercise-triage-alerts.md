Your sensor is now fine-tuned so that the devices are correctly identified, configured, and located within the device map and system hierarchy. The final action for setting up the sensor is to triage the alerts that are listed in Microsoft Defender for IoT during the *Learning* mode.

## View your alerts

First, identify which alerts are important to triage.

1. In Defender for IoT, open **Alerts**.
1. Use the **Search** box or **Add filter** to filter/ display a set of alerts.
1. Select the alert by ticking the checkbox for that row. The alert pane opens on the right side.
1. Select **View full details** to drill down further and see the remediation suggestions. For example:

    :::image type="content" source="../media/7-alert-detected.png" alt-text="screenshot of a chosen alert to view the full alert details" lightbox="../media/7-alert-detected.png":::

## Triage an alert

The **Alerts** page provides more details about an alert.

1. Using the **Alert details** tab and the other information, analyze the alert and decide if it requires a security response or if this is normal network traffic.
1. The **Take action** tab lists the remediation steps or options needed to fix the problem. Choose which steps to follow depending on your analysis of the alert.
    For example:
    1. If the alert is normal network traffic, choose **Select Learn**.
    1. If the alert requires a security response, consult a relevant Control Systems Engineer to validate the origin of the alert.

        :::image type="content" source="../media/7-alert-full-details.png" alt-text="Screenshot of the alert details with the Take Action box highlighted" lightbox="../media/7-alert-full-details.png" :::

    1. If you want to suppress the alert, select **Create Suppression Rule** and the suppression rule pane opens.
        1. Type a Name and a description.
        1. If this rule has a time range, select the **Expiration date** toggle button and enter the dates.
        1. Choose which sensors this alert applies to.
        1. Select **Next**, and **Confirm** in the pop-up box.
        1. You might also add a filter based on IP address, MAC ID, subnet, or host address, but for this Module we aren't adding one. Select **Next**.
        1. Review the details of the rule and then select **Create**.

1. To complete the triage, update the alert severity and alert status. Select **Apply** to keep the changes.

### Select multiple alerts

You can also select several alerts to triage at the same time, however you aren't able to see their details together. You're able to make bulk changes to their severity or status levels or apply the *learn* setting using the Alerts page menu bar. <!-- highlight in image below -->

:::image type="content" source="../media/7-bulk-alert-triage.png" alt-text="Screenshot of bulk update of alerts, in this case updating the severity level for these alerts" lightbox="../media/7-bulk-alert-triage.png":::
OR
:::image type="content" source="../media/7-bulk-alert-triage1.png" alt-text="Screenshot of bulk update of alerts, in this case updating the severity level for these alerts thick box" lightbox="../media/7-bulk-alert-triage1.png":::

## Select a few to triage and learn to add them to your learned network baseline

Give example of an alert or two types of alerts with different changes made. And also different severity and status changes.
How do we do this? Who to speak to? Vhathek?
Filter alerts
choose type of alert
view full details.
<!-- <https://learn.microsoft.com/en-us/azure/defender-for-iot/organizations/how-to-manage-cloud-alerts> <https://learn.microsoft.com/azure/defender-for-iot/organizations/how-to-view-alerts#manage-alert-status-and-triage-alerts>-->
Suggested from Amit 'Unauthorised internet connectivity' + 'New Asset Detected'

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
