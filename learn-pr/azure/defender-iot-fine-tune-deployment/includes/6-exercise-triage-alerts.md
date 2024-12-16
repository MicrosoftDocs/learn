Your sensor is now fine-tuned so that the devices are correctly identified, configured, and located within the device map and system hierarchy. The final action for setting up the sensor is to triage the alerts that are listed in Microsoft Defender for IoT during the *Learning* mode.

## View your alerts

First, identify which alerts are important to triage.

1. In Defender for IoT, open **Alerts**.
1. Use the **Search** box or **Add filter** to filter/ display a set of alerts.
1. Select the alert by ticking the checkbox for that row. The alert pane opens on the right side.
1. Select **View full details** to drill down further and see the remediation suggestions. For example:

    :::image type="content" source="../media/6-alert-detected.png" alt-text="screenshot of a chosen alert to view the full alert details." lightbox="../media/6-alert-detected.png":::

## Triage an alert

The **Alerts** page provides more details about an alert.

1. Using the **Alert details** tab and the other information, analyze the alert and decide if it requires a security response or if the alert is normal network traffic.
1. The **Take action** tab lists the remediation steps or options needed to fix the problem. Choose which steps to follow depending on your analysis of the alert.
    For example:

    | Alert Response |  Action |
    |---|---|
    | If the alert indicates normal network traffic |  1. Select **Select Learn**.<br> 2. Adjust the Status to **Closed**, and select **Apply**.|
    | If the alert requires a security response | Consult a relevant Control Systems Engineer to validate the origin of the alert.<br>        :::image type="content" source="../media/6-alert-full-details-cropped.png" alt-text="Screenshot of the alert details with the Take Action box highlighted." lightbox="../media/6-alert-full-details-cropped.png" :::|
    | If you want to suppress the alert| Select **Create Suppression Rule** and the suppression rule pane opens.<br>1. Type a **Name** and a **Description**.<br>2. If this rule has a time range, select **Expiration date** and enter the dates.<br>3. Choose which sensors this alert applies to.<br>4. Select **Next**, and **Confirm** in the pop-up box.<br>5. Select **Next**.<br>6. Review the details of the rule and then select **Create**.|

1. To complete the triage, update the alert severity and alert status. Select **Apply** to keep the changes.

### Select multiple alerts

You can also select several alerts to triage at the same time, however you aren't able to see their details together. You're able to make bulk changes to their severity or status levels or apply the *learn* setting using the **Alerts** page menu bar.

:::image type="content" source="../media/6-bulk-alert-triage.png" alt-text="Screenshot of bulk update of alerts, in this case updating the severity level for these alerts." lightbox="../media/6-bulk-alert-triage.png":::

## Check your work

When you complete the triage process:

1. Go to **Alerts**.
1. Review the list of alerts which shows high level alerts.

   :::image type="content" source="../media/6-alert-after-triage.png" lightbox="../media/6-alert-after-triage.png" alt-text="Screenshot of the alerts page after triage.":::
