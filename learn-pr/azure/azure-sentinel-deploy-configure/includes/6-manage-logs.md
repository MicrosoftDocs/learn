Lastly, you must understand how to deploy and manage the log data that Microsoft Sentinel collects.

## Azure Monitor log management

Azure Monitor and its Log Analytics feature are the underlying log management platform that powers Microsoft Sentinel. The workspace that Microsoft Sentinel uses is essentially a container where log data is collected from a variety of sources. You might have a single Log Analytics workspace for all your monitoring data, or you might have requirements for multiple workspaces.

Any source that sends logs to Monitor or Log Analytics inherently also supports Microsoft Sentinel. Most Azure and Microsoft solutions support sending telemetry to Monitor.

### Pricing model

Microsoft Sentinel bills based on the volume of data that's ingested for analysis in Microsoft Sentinel and that's stored in the Log Analytics workspace. There are two ways to pay for the Microsoft Sentinel service: Capacity Reservations and pay-as-you-go.

The Azure Monitor Log Analytics Workspace is the location where the data is sent. Data in a workspace is organized into tables. Each table stores different kinds of data and has a unique set of properties. The properties are based on the resource that generates the data. Most data sources write to their own tables in a Log Analytics workspace.

You can get the full benefit of the Microsoft Sentinel experience when using a single workspace. Even so, some circumstances might require you to have multiple workspaces, such as:

- **Sovereignty and regulatory compliance**: A workspace is tied to a specific region. If data must be kept in different Azure geographies to satisfy regulatory requirements, it must be split into separate workspaces.
- **Data ownership**: The boundaries of data ownership, for example by subsidiaries or affiliated companies, are better delineated by using separate workspaces.
- **Multiple Azure tenants**: Microsoft Sentinel supports data collection from Microsoft and Azure software as a service (SaaS) resources only within its own Azure AD tenant boundary. Therefore, each Azure AD tenant requires a separate workspace.

You might have requirements, such as the need to have granular control over access to data. Those situations are best satisfied by using a single workspace. The following table lists some situations and ways you can reduce workspace count.

|Requirement|Description|Ways to reduce workspace count|
|---|---|---|
|Granular data access control|An organization might need to allow different groups, within or outside the organization, to access some of the data that Microsoft Sentinel collects.|Use resource Azure RBAC or table-level Azure RBAC|
|Split billing|By placing workspaces in separate subscriptions, they can bill to different parties.|Usage reporting and cross-charging|
|Legacy architecture|The use of multiple workspaces might stem from a historical design that considers outdated limitations or best practices. It might also be an arbitrary design choice that can be modified to better accommodate Microsoft Sentinel.|Re-architect workspaces|

### Microsoft Sentinel multiple workspace architecture

There are cases where multiple Microsoft Sentinel workspaces, potentially across Azure AD tenants, must be centrally monitored and managed by a single security operations center, such as:

- A managed security service provider Microsoft Sentinel service
- A security operations center that monitors multiple Azure AD tenants in an organization
- A global security operations center that serves multiple subsidiaries and each one has its own local security operations center

To address this requirement, Microsoft Sentinel offers multiple-workspace capabilities that enable central monitoring, configuration, and management. It provides a single management display console across everything that the security operations center covers.

:::image type="content" source="../media/cross-workspace-architecture.png" alt-text="Diagram showing a multiple-workspace configuration for Microsoft Sentinel." border="false":::

This multiple-workspace model offers significant advantages over a fully centralized model in which all data copies to a single workspace, such as:

- A more flexible role assignment to the global or local security operations center teams or to the managed security service provider for its customers
- Fewer challenges regarding data ownership, data privacy, and regulatory compliance
- Minimal network latency and charges
- Easy onboarding and offboarding of new subsidiaries and customers
