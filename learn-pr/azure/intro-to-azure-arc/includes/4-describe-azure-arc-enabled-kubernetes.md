Contoso hosts Kubernetes clusters in multiple datacenters throughout the world. The IT staff at Contoso, want to manage these disparate clusters using consistent tools and processes. Azure Arc gives the IT staff a single pane of glass and single toolset for managing the clusters.

## What is Azure Arc-enabled Kubernetes?

Using Azure Arc, you can connect Kubernetes clusters located anywhere to Azure. You can then manage these connected clusters in a consistent way, just as you would in Azure. Azure Arc-enabled Kubernetes lets you control the cluster configuration and workloads at scale using your Git repositories as the source of truth. This connection to Azure provides you with extensive management capabilities such as inventory, monitoring, policy compliance, security, user access, and more.

When you implement Azure Arc, you can use many Azure services to manage your clusters, including:

- Azure portal
- Azure Resource Graph
- Azure Policy
- Azure Monitor

Each Kubernetes cluster that you enable with Azure Arc:

- Is assigned an Azure Resource Manager ID.
- Has a managed identity.
- Is located in an Azure resource group and subscription.
- Appears in the Azure portal.
- Can be treated like other Azure resources; for example, it can be tagged for inventory management.

At minimum, you can implement Azure Arc in your Kubernetes clusters to view the inventory of your complete Kubernetes estate, and then group and tag the clusters for finer-grained inventory management. In addition, you can use:

- GitOps-based configuration management to deploy applications and configure the clusters.
- Azure Policy for Kubernetes to enforce run-time policies in your Kubernetes clusters.
- Azure Monitor for containers to consistently monitor all of your clusters.

:::image type="content" source="../media/4-kubernetes.png" alt-text="Screenshot of the Azure Arc Kubernetes clusters page in the Azure portal that displays a list of Kubernetes resources." border="false":::

### What can you do with Azure Arc-enabled Kubernetes?

You can use Azure Arc-enabled Kubernetes to address many requirements in your organization, including:

- Providing unified management and administration tools.
- Performing configuration with integrated management.
- Collecting inventory data.

#### Provide unified management and administration tools

With Azure Arc-enabled Kubernetes, you can create a shared application and infrastructure environment. This approach enables you to implement:

- Consistent management of your resources using the Azure portal and APIs across:
  - Your datacenters
  - Edge locations
  - Multiple hosting providers
- A shared management and administration view, enabling you to manage Kubernetes clusters as well as Windows Server and Linux VMs, physical servers, and Azure data services.
- Clear roles and responsibilities for your IT and engineering staff, providing role separation while still maintaining visibility and access to resources, wherever their location.

#### Perform configuration with integrated management

The integrated management features in Azure Arc-enabled Kubernetes, allow you to more efficiently create, apply, and enforce policies to Kubernetes apps, data, and infrastructure. Wherever, your Kubernetes resources are located.

- Use Azure Policy to:
  - Assure consistent configurations across all your Kubernetes clusters.
  - Enforce run-time conformance and audit resources.
- Implement role-based access control (RBAC) across systems and different types of resources to help to standardize security.
- Automate and delegate remediation of incidents and problems to service teams.
- Implement other Azure services and use your choice of Azure tools to:
  - Integrate with Azure Monitor, Defender for Cloud, GitHub, and others.
  - Automate configuration and infrastructure as code to provide repeatable deployments using templates.
  - Provide end-to-end identity for your users and your resources with Azure Resource Manager and Azure Active Directory (Azure AD).

#### Collect inventory data

By implementing Azure Arc-enabled Kubernetes, you can more efficiently collect inventory data by:

- Unifying your resources so you can organize and inventory by using Azure scopes, such as:
  - Management groups
  - Subscriptions
  - Resource Groups
- Tracking resources by creating and applying standardized and custom tags.
- Searching your global resources with Azure Resource Graph.

### Azure Arc-enabled Kubernetes agents

Similar to the way that you onboard servers to Azure Arc, you must also deploy agents to your Kubernetes clusters. The Kubernetes agents are responsible for:

- Connecting to Azure.
- Collecting Azure Arc logs and metrics.
- Managing configuration requests.

Azure Arc-enabled Kubernetes deploys several agents.

> [!NOTE]
> These agents run in the `azure-arc` namespace in your Kubernetes clusters.

The following table describes some of these agents:

|Agent|Description|
|---|---|
|`deployment.apps/config-agent`|Monitors the connected cluster for updates, compliance state, and source control configuration resources applied on the cluster.|
|`deployment.apps/controller-manager`|Orchestrates interactions between Azure Arc components.|
|`deployment.apps/metrics-agent`|Collects metrics from other Azure Arc agents to optimize the performance of these other agents.|
|`deployment.apps/cluster-metadata-operator`|Gathers cluster metadata, including cluster version, node count, and Azure Arc agent version.|
|`deployment.apps/resource-sync-agent`|Syncs cluster metadata to Azure.|
|`deployment.apps/clusteridentityoperator`|Maintains the certificate for the managed identities for Azure resources that other agents use for communication with Azure.|
|`deployment.apps/flux-logs-agent`|Collects logs from the flux operators that deploy as a part of source control configuration.|
