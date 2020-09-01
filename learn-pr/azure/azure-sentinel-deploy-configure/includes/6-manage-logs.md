As the Contoso administrator who is tasked with deploying a POC environment for Azure Sentinel, you must understand how to deploy and manage the log data that will be collected.

## Manage logs for Azure Sentinel

Azure Monitor and its Log Analytics feature are the underlying log management platform that powers Azure Sentinel. The workspace that Azure Sentinel creates is essentially a container where log data is collected from a variety of sources. You might have a single Log Analytics workspace for all your monitoring data, or you might have requirements for multiple workspaces.

As such, any source that sends logs to Monitor or Log Analytics inherently also supports Azure Sentinel. Most Azure and Microsoft solutions support sending telemetry to Monitor.

### Pricing model

Azure Sentinel bills based on the volume of data that's ingested for analysis in Azure Sentinel and that's stored in the Log Analytics workspace. The Azure Sentinel pricing model is flexible and predictable. There are two ways to pay for the Azure Sentinel service: Capacity Reservations and Pay-As-You-Go.

The Azure Monitor Analytics Workspace is the location where the data is sent. Data in a workspace is organized into tables. Each table stores different kinds of data and has its own unique set of properties based on the resource that's generating the data. Most data sources write to their own tables in a Log Analytics workspace.

You can get the full benefit of the Azure Sentinel experience when using a single workspace. Even so, some circumstances might require you to have multiple workspaces. The following table lists some of these situations, and when possible, suggests how the requirement might be satisfied with a single workspace.

|Requirement|Description|Ways to reduce workspace count|
|---|---|---|
|Sovereignty and regulatory compliance|A workspace is tied to a specific region. If data must be kept in different Azure geographies to satisfy regulatory requirements, it must be split into separate workspaces.||
|Data ownership|The boundaries of data ownership, for example by subsidiaries or affiliated companies, are better delineated by using separate workspaces.||
|Multiple Azure tenants|Azure Sentinel supports data collection from Microsoft and Azure software as a service resources only within its own Azure AD tenant boundary. Therefore, each Azure AD tenant requires a separate workspace.||
|Granular data access control|An organization might need to allow different groups, within or outside the organization, to access some of the data that Azure Sentinel collects.|Use resource Azure RBAC or table-level Azure RBAC|
|Split billing|By placing workspaces in separate subscriptions, they can bill to different parties.|Usage reporting and cross-charging|
|Legacy architecture|The use of multiple workspaces might stem from a historical design that took into consideration limitations or best practices that no longer hold true. It might also be an arbitrary design choice that can be modified to better accommodate Azure Sentinel.|Re-architect workspaces|

### Azure Sentinel multiple workspace architecture

As implied by the previous requirements, there are cases where multiple Azure Sentinel workspaces, potentially across Azure AD tenants, must be centrally monitored and managed by a single security operations center, such as:

- A managed security service provider Azure Sentinel service.
- A security operations center that's monitoring multiple Azure AD tenants in an organization.
- A global security operations center that's serving multiple subsidiaries, each having its own local security operations center.

To address this requirement, Azure Sentinel offers multiple-workspace capabilities that enable central monitoring, configuration, and management, providing a single management display console across everything that the security operations center covers, as presented in the following diagram.

:::image type="content" source="../media/cross-workspace-architecture.png" alt-text="The diagram depicts a multiple-workspace configuration for Azure Sentinel." border="false":::

This multiple-workspace model offers significant advantages over a fully centralized model in which all data copies to a single workspace, including:

- A more flexible role assignment to the global or local security operations center teams or to the managed security service provider its customers.

- Fewer challenges regarding data ownership, data privacy, and regulatory compliance.

- Minimal network latency and charges.

- Easy onboarding and offboarding of new subsidiaries and customers.
