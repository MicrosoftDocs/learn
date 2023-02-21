Alerts in Azure Monitor help you detect and address issues before users notice them by proactively notifying you when collected data indicates that there may be a problem with your infrastructure or application. Alerts are created from alert rules that can inspect metric or log data in order to determine criteria for when an alert should be generated.

## Viewing alerts

When an alert is created, it’s displayed in the **Alerts** menu for your AKS cluster. You can view the details of the alert which will indicate what caused the alert to fire so that you can determine the cause and appropriate resolution. If Container insights determines that the condition has been corrected, then it will automatically resolve the alert.

## Action groups

Action groups contain automated actions that are taken when an alert is fired. This could be to proactively notify administrators by mail or text message, or to start some process to try to take corrective action. A single action group can be applied to multiple alert rules so that you can reuse a particular set of actions.

## Container insights alerts

Container insights includes a set of prebuilt alert rules for common conditions related to an AKS cluster. These are the same alert rules that you could create on your own with Azure Monitor, but Container insights saves you the time of having to perform manual configuration. It also provides a simplified interface for enabling the alert rules and assigning action groups. The rules include predefined thresholds that you can either accept without change or modify based on your particular requirements. 