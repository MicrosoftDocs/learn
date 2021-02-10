Like any business, Contoso faces technology-related threats to its organization. Azure Sentinel can help Contoso's IT team organize, investigate, and track these threats from creation to resolution. The threats are called *incidents*.

## Key concepts

Before you begin managing incidents, it's important to understand the following key incident management concepts in Azure Sentinel:

- **Data connectors**. You use data connectors in Azure Sentinel to ingest and collect data from security-related services. These events are forwarded to a Log Analytics workspace associated with Azure Sentinel. Events can be collected from Linux or Windows computers running the Log Analytics agent, from a Linux syslog server (for devices like firewalls or proxies), or directly from Microsoft Azure services.
- **Events**. Azure Sentinel stores events in a Log Analytics workspace. These events contain the details of security-related activity that you want to monitor with Azure Sentinel.
- **Analytic rules**. You create analytics rules to detect important security events and generate alerts. You can create analytics rules by using built-in templates or by using custom Kusto Query Language (KQL) queries against Log Analytics workspaces in Sentinel.
- **Alerts**. Analytics rules generate alerts when they detect important security events. You can also configure alerts to generate incidents.
- **Incidents**. Azure Sentinel creates incidents from analytics rule alerts. Incidents can contain multiple related alerts. You use each incident as a starting point and tracking mechanism for investigation into security concerns in your environment.

## Incident management in Azure Sentinel

Incident management is the complete process of incident investigation, from creation, to in-depth investigation, and finally to resolution. Azure Sentinel provides a complete incident management environment in which you can perform these steps. You can use Sentinel to review detailed incident information, assign an incident owner, set and maintain incident severity, and manage incident status.

### Overview page

Incident management in Azure Sentinel begins on the overview page, where you can review the current Azure Sentinel environment.

:::image type="content" source="../media/3-sentinel-overview.png" alt-text="A screen capture of the Azure Sentinel overview page." border="false":::

The overview page contains a list of the most recent incidents, along with other important Azure Sentinel information. Use this page to understand the general security situation before investigating incidents.

Choose the best response for each of the following questions. Then select **Check your answers**.
