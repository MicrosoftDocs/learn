Alerts within Permissions Management give you the insight to continuously monitor your environment and take a proactive approach to preventing permissions creep. Alerts are also useful for threat detection and managing insider risk. 

There are four main types of alerts that can be created/configured within Entra Permissions Management: 
- Activity alerts 
- Rule-Based Anomaly alerts 
- Statistical Anomaly alerts 
- Permission Analytics alerts 

### Activity alerts
With Activity alerts, you create alerts based on activity that is happening in your environment. For example, you can be alerted every time a specific resource in your environment is accessed or every time a certain task is performed.

Activity alerts are the most customizable and allow you to build out your alert criteria using an easy-to-use, no code interface.

:::image type="content" source="../media/create-alert-triggers.png" alt-text="Screenshot of the Permissions Management creating alert triggers for monitoring."lightbox="../media/create-alert-triggers.png":::

> [!Tip]
> Activity alerts are useful for monitoring specific identities or resources. For example, you can set up activity alerts to notify you every time one of your critical resources is accessed. 

### Rule-Based Anomaly alerts
Rule-Based Anomaly alerts are a set of prebuilt alerts that allow you to be notified of activity that is happening for the first time in your environment. For example, you can be alerted every time a resource is accessed for the first time or every time a user performs a task for the first time.

:::image type="content" source="../media/rule-based-anomaly-alerts.png" alt-text="Screenshot of the Permissions Management creating rule-based anomaly alerts."lightbox="../media/rule-based-anomaly-alerts.png":::

> [!Tip]
> Rule-Based Anomaly alerts are useful for threat detection, as identities performing specific tasks or accessing certain resources for the first time could be a red flag that a bad actor might be at play.  
 
### Statistical Anomaly alerts
Statistical Anomaly alerts take advantage of Permissions Management’s AI and ML capabilities. Based on prior activity log information, Permissions Management classifies and determines what is considered normal behavior for each one of your identities. You then choose from a set of prebuilt alerts that alert you to any abnormal or suspicious activity in your environment. For example, you can be notified whenever an identity performs a high number of tasks or when an identity performs tasks at an unusual time of the day.

:::image type="content" source="../media/statistical-anomaly-alerts.png" alt-text="Screenshot of the Permissions Management statistical anomaly alerts."lightbox="../media/statistical-anomaly-alerts.png":::

> [!Tip] 
> Statistical Anomaly alerts are useful for threat detection, as unusual activity in your environment can be a sign of a compromised account. 

### Permissions Analytics alerts
Permissions Analytics alerts are tied to the Permissions Analytics Report and each prebuilt alert is tied to a specific category listed in the report. For example, you can be notified whenever there's an inactive user in your environment or whenever a user becomes over-permissioned.

:::image type="content" source="../media/permissions-analytics-alerts.png" alt-text="Screenshot of the Permissions Management permissions analytics alerts."lightbox="../media/permissions-analytics-alerts.png":::

> [!Tip]
> Permissions Analytics alerts can be especially useful after remediating findings in the Permissions Analytics Report, as they allow you to be proactive about acting on any future findings. 
