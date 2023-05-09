
As discussed already, Azure monitor has metrics, logging, and analytics features. Another feature is Monitor Alerts.

## Responding to critical situations

In addition to allowing you to interactively analyze monitoring data, an effective monitoring solution must be able to proactively respond to critical conditions identified in the data that it collects. This could be sending a text or mail to an administrator responsible for investigating an issue. Or you could launch an automated process that attempts to correct an error condition.

### Alerts

Alerts in Azure Monitor proactively notify you of critical conditions and potentially attempt to take corrective action. Alert rules based on metrics provide near real time alerting based on numeric values, while rules based on logs allow for complex logic across data from multiple sources.

Alert rules in Azure Monitor use action groups, which contain unique sets of recipients and actions that can be shared across multiple rules. Based on your requirements, action groups can perform such actions as using webhooks to have alerts start external actions or to integrate with your ITSM tools.

The unified alert experience in Azure Monitor includes alerts that were previously managed by Log Analytics and Application Insights. In the past, Azure Monitor, Application Insights, Log Analytics, and Service Health had separate alerting capabilities. Over time, Azure improved and combined both the user interface and different methods of alerting. The consolidation is still in process.

#### Overview of Alerts in Azure

The diagram below represents the flow of alerts.

:::image type="content" source="../media/az500-alerts-dae8751b.png" alt-text="An alert rule has a target and condition.":::


Alert rules are separated from alerts and the actions taken when an alert fires. The alert rule captures the target and criteria for alerting. The alert rule can be in an enabled or a disabled state. Alerts only fire when enabled.

The following are key attributes of an alert rule as shown:

:::image type="content" source="../media/az500-create-alert-a532960c.png" alt-text="Screenshot of the portal create a rule page.":::


 -  **Target Resource**: Defines the scope and signals available for alerting. A target can be any Azure resource. Example targets: a virtual machine, a storage account, a virtual machine scale set, a Log Analytics workspace, or an Application Insights resource. For certain resources (like virtual machines), you can specify multiple resources as the target of the alert rule.
 -  **Signal**: Emitted by the target resource. Signals can be of the following types: metric, activity log, Application Insights, and log.
 -  **Criteria**: A combination of signal and logic applied on a target resource. Examples:
     -  Percentage CPU &gt; 70%
     -  Server Response Time &gt; 4 ms
     -  Result count of a log query &gt; 100
 -  **Alert Name**: A specific name for the alert rule configured by the user.
 -  **Alert Description**: A description for the alert rule configured by the user.
 -  **Severity**: The severity of the alert after the criteria specified in the alert rule is met. Severity can range from 0 to 4.
     -  Sev 0 = Critical
     -  Sev 1 = Error
     -  Sev 2 = Warning
     -  Sev 3 = Informational
     -  Sev 4 = Verbose
 -  **Action**: A specific action taken when the alert is fired.

### What You Can Alert On

You can alert on metrics and logs. These include but are not limited to:

 -  Metric values
 -  Log search queries
 -  Activity log events
 -  Health of the underlying Azure platform
 -  Tests for website availability

With the consolidation of alerting services still in process, there are some alerting capabilities that are not yet in the new alerts system.

| **Monitor source**   | **Signal type**        | **Description**                                                                                                                                                                                                        |
| -------------------- | ---------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Service health       | Activity log           | Not supported. View Create activity log alerts on service notifications.                                                                                                                                               |
| Application Insights | Web availability tests | Not supported. View Web test alerts. Available to any website that's instrumented to send data to Application Insights. Receive a notification when availability or responsiveness of a website is below expectations. |
