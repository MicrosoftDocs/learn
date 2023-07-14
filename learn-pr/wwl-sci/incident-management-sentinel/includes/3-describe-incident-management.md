
Technology-related threats to an organization are called *incidents*. Incident management is the complete process of incident investigation, from incident creation to in-depth investigation and resolution. Microsoft Sentinel can help your IT team organize, investigate, and track incidents from creation through resolution.

You can use Microsoft Sentinel to review detailed incident information, assign an incident owner, set and maintain incident severity, and manage incident status. Microsoft Sentinel provides a complete incident management environment to handle these steps. 

## Key concepts

It's important to understand the following key Microsoft Sentinel incident management concepts:

- **Data connectors**. You can use Microsoft Sentinel data connectors to ingest and collect data from security-related services. Data connectors can collect events from Linux or Windows computers running the Log Analytics agent, from a Linux syslog server for devices like firewalls or proxies, or directly from Microsoft Azure services. These events forward to a Log Analytics workspace associated with Microsoft Sentinel.
- **Events**. Microsoft Sentinel stores events in a Log Analytics workspace. These events contain the details of security-related activity that you want Microsoft Sentinel to monitor.
- **Analytics rules**. Analytics rules detect important security events and generate alerts. You can create analytics rules by using built-in templates or by using custom Kusto Query Language (KQL) queries against Log Analytics workspaces in Microsoft Sentinel.
- **Alerts**. Analytics rules generate alerts when they detect important security events. You can configure alerts to generate incidents.
- **Incidents**. Microsoft Sentinel creates incidents from analytics rule alerts. Incidents can contain multiple related alerts. You use each incident as a starting point and tracking mechanism for investigation into security concerns in your environment.

### Microsoft Sentinel Overview page

Incident management in Microsoft Sentinel begins on the **Overview** page, where you can review the current Microsoft Sentinel environment. The **Overview** page shows a list of the most recent incidents, along with other important Microsoft Sentinel information. You can use this page to understand the general security situation before investigating incidents.

:::image type="content" source="../media/3-sentinel-overview.png" alt-text="A screen capture of the Microsoft Sentinel Overview page." lightbox="../media/3-sentinel-overview.png":::

