Azure Monitor Alerts help you detect and address issues before users notice them. Alerts notify you when the collected data indicates a possible problem with your infrastructure or application. Alerts are created from alert rules that use metric or log data to determine when an alert should be generated.

## Viewing alerts

When an alert is created, it's displayed in the **Alerts** menu for your AKS cluster. You can view the alert's details, including what caused the alert to fire. Use this data find the cause and appropriate resolution for the issue. If Container insights determines that the issue has been corrected, it automatically resolves the alert.

## Action groups

Action groups contain automated actions that are taken when an alert is fired. These actions could proactively notify administrators by mail or text message, trigger a Logic app, or start a process to try to take corrective action. You can apply a single action group to multiple alert rules so that you can reuse a particular set of actions.

## Container insights alerts

Container insights includes a set of prebuilt alert rules for common conditions related to an AKS cluster. Container insights also provides a simplified interface for enabling the alert rules and assigning action groups. The rules include predefined thresholds that you can either accept or modify based on your particular requirements.
