Alerts proactively notify you when important conditions are found in your monitoring data. They allow you to identify and address issues before the users of your system notice them. Alerts consist of alert rules, action groups, and monitor conditions.

:::image type="content" source="../media/create-alert-337a7110.png" alt-text="Screenshot of the create rule page with resource, condition, and action group.":::


The alert rule captures the target and criteria for alerting. The alert rule can be in an enabled or a disabled state. Alerts only fire when enabled. The key attributes of an alert rule are:

 -  **Target Resource** – Defines the scope and signals available for alerting. A target can be any Azure resource. Example targets: a virtual machine, a storage account, a virtual machine scale set, a Log Analytics workspace, or an Application Insights resource. For certain resources (like Virtual Machines), you can specify multiple resources as the target of the alert rule.
 -  **Signal** – Signals are emitted by the target resource and can be of several types. Metric, Activity log, Application Insights, and Log.
 -  **Criteria** – Criteria is a combination of Signal and Logic applied on a Target resource. Examples: \* Percentage CPU &gt; 70%; Server Response Time &gt; 4 ms; and Result count of a log query &gt; 100.
 -  **Alert Name** – A specific name for the alert rule configured by the user.
 -  **Alert Description** – A description for the alert rule configured by the user.
 -  **Severity** – The severity of the alert once the criteria specified in the alert rule is met. Severity can range from 0 to 4.
 -  **Action** – A specific action taken when the alert is fired.
