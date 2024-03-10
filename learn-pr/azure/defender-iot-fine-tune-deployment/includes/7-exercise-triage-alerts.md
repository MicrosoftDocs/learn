
## View your alerts

First you must identify which alerts are important to triage.

1. In Defender for IoT, open **Alerts**.
1. Using the **Search** box or the **Add filter** identify a set of alerts to filter.
1. Select the alert by ticking the checkbox for that row.
1. Select View full details to drill down further. For example:

    :::image type="content" source="../media/7-alert-detected.png" alt-text="screenshot of a chosen alert to view the full alert details" lightbox="../media/7-alert-detected.png":::

1. The alert details page provides more details about the alert, and a set of remediation steps on the Take action tab. For example:
    :::image type="content" source="../media/7-alert-full-details.png" alt-text="Screenshot of the alert details with the Take Action box highlighted":::
1. 
1. 

## Select a few to triage and learn to add them to your learned network baseline

<https://learn.microsoft.com/azure/defender-for-iot/organizations/ot-deploy/create-learned-baseline#triage-alerts>

<https://learn.microsoft.com/azure/defender-for-iot/organizations/how-to-view-alerts#prerequisites>

## triage

<https://learn.microsoft.com/azure/defender-for-iot/organizations/how-to-view-alerts#manage-alert-status-and-triage-alerts>

# knowledge check

## Baseline of OT network traffic for sensors created

Knowledge check (apply level): To do  

## Explain the differences between different alert status options

Questions about managing alerts in hybrid â€“ both on prem and in the Azure portal

Apply level questions for these key takeaways?

What happens during learning mode?
<https://learn.microsoft.com/azure/defender-for-iot/organizations/ot-deploy/create-learned-baseline#understand-learning-mode>

How long should learning mode last?
<https://learn.microsoft.com/azure/defender-for-iot/organizations/ot-deploy/create-learned-baseline#learn-mode-timeline>

## End Learning mode
<!-- Should this be part of the LM? Even though this will be done at a later time in real life, as part of the exercise it should be added to this unit.-->
After a week or two when Defender for IoT has learnt to identify suspicious traffic and not send false alerts, you can turn off the *Learn* status.

In the Sensor:

1. Select **System settings**.
1. Select **Detection Engines and Network Modelling**.
1. Under **Network modelling**, toggle the **Learning** button to **Enabled**.
1. Select **Close**.

After this change, any new devices or traffic trigger an alert, which is assessed like other alerts.

## Check your work

What do we do to show this has been successful?
