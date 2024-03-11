Your sensor is now fine-tuned so that the devices are correctly identified, configured and located within the device map and system heirachy. The final action for setting up the sensor is to triage the alerts that Microsoft Defender for IoT creates during the *Learning* mode.

## View your alerts

First, identify which alerts are important to triage.

1. In Defender for IoT, open **Alerts**.
1. Using the **Search** box or **Add filter** filter a set of alerts.
1. Select the alert by ticking the checkbox for that row.
1. Select **View full details** to drill down further and see the remediation suggestions <!-- with this last few words, the image should be of the remediation?? but here is a different image. and the remediation is in the next section. What should I do for this? -->. For example:

    :::image type="content" source="../media/7-alert-detected.png" alt-text="screenshot of a chosen alert to view the full alert details" lightbox="../media/7-alert-detected.png":::

## Triage

1. The alert details page provides more details about the alert. In the **Take action** Tab are the important remediation steps to be taken to fix the problem. For example:

    :::image type="content" source="../media/7-alert-full-details.png" alt-text="Screenshot of the alert details with the Take Action box highlighted" lightbox="../media/7-alert-full-details.png" :::

1. Other options include selecting the Learn button so that Defender for IoT knows that the traffic is authorized. And.....

1. To complete the triage, you should update the alert severity and alert status.

Give example of an alert or 2 types of alerts with different changes made. and also different severity and status changes.

### Select multiple alerts

You can also select several alerts to triage at the same time, however you will not be able to see the details of them together. You are able to make bulk changes their severity or status levels or apply the *learn* setting using the menu bar above the alerts table.

:::image type="content" source="../media/7-bulk-alert-triage.png" alt-text="Screenshot of bulk update of alerts, in this case updating the severity level for these alerts" lightbox="../media/7-bulk-alert-triage.png":::

### Add comments if possible

<!-- asked Theo and Ariel if this still exists?! -->

### Create suppression rules if possible

Select **Save** to keep these changes.

## Select a few to triage and learn to add them to your learned network baseline
<!-- how do we do this? Who to speak to? Vhathek?-->
<https://learn.microsoft.com/azure/defender-for-iot/organizations/ot-deploy/create-learned-baseline#triage-alerts>

<https://learn.microsoft.com/azure/defender-for-iot/organizations/how-to-view-alerts#prerequisites> not really important!

<https://learn.microsoft.com/azure/defender-for-iot/organizations/how-to-view-alerts#manage-alert-status-and-triage-alerts>

## End Learning mode
<!-- Should this be part of the LM? Even though this will be done at a later time in real life, as part of the exercise it should be added to this unit.-->
After a week or two Defender for IoT learns to identify suspicious traffic and not send false alerts, you can turn off the *Learn* status.

In the Sensor:

1. Select **System settings**.
1. Select **Detection Engines and Network Modeling**.
1. Under **Network modeling**, toggle the **Learning** button to **Enabled**.
1. Select **Close**.

After this change, any new devices or traffic trigger an alert, which is assessed like other alerts.

## Check your work

What do we do to show the work is successful?

Possible knowledge check questions:

## Baseline of OT network traffic for sensors created

Knowledge check (apply level): To do  

## Explain the differences between different alert status options

Questions about managing alerts in hybrid â€“ both on-premises and in the Azure portal

Apply level questions for these key takeaways?

What happens during learning mode?
<https://learn.microsoft.com/azure/defender-for-iot/organizations/ot-deploy/create-learned-baseline#understand-learning-mode>

How long should learning mode last?
<https://learn.microsoft.com/azure/defender-for-iot/organizations/ot-deploy/create-learned-baseline#learn-mode-timeline>