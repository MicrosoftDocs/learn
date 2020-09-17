Contoso currently host a number of Kubernetes clusters in a datacenter in London. They want to be able to manage these resources using a consistent collection of tools and processes. In addition to managing servers, Contoso could use Azure Arc to configure and manage their Kubernetes clusters. 

## What is Azure Arc enabled Kubernetes?

Using Azure Arc, you can attach and then configure Kubernetes clusters, whether they're hosted on Azure or elsewhere. A significant benefit of implementing Azure Arc enabled Kubernetes is that you can bring a consistent management interface and approach to managing your resources. 

> [!NOTE]
> This is true even if those resources are located outside of Azure, either in your on-premises datacenter, or else hosted by a third party provider. 

As a result, you can use the following to manage your clusters:

- Azure Policy
- Azure Monitor
- Azure Resource Graph

When you attach a Kubernetes cluster to Azure Arc, it:

- Is assigned an Azure Resource Manager ID. 
- Has a managed identity.
- Is located in an Azure resource group.
- Appears in the Azure portal.
- Can receive tags like any other Azure resource.

You can implement Azure Arc enabled Kubernetes to support Kubernetes clusters that are deployed outside Azure for inventorying, grouping, and tagging. In addition, you can use:

- GitOps-based configuration management to deploy applications and apply configurations.
- Azure Policy to apply policies to Kubernetes clusters.
- Azure Monitor for containers to display and monitor your clusters.

:::image type="content" source="../media/4-kubernetes.png" alt-text="A screenshot of the Kubernetes services blade of the Azure portal that displays a list of Kubernetes resources." border="false":::

### What can you do with Azure Arc enabled Kubernetes?

You can use Azure Arc enabled Kubernetes to address several needs in your organization. These include: 

- Providing for unification of management and administration tools.
- Performing configuration with integrated management.
- Collecting inventory data.

#### Provide for unification of management and administration tools

With Azure Arc enabled Kubernetes, you can create a shared application and infrastructure environment. This approach enables you to implement:

- A consistent view of your resources using the Azure portal and APIs across:
    - Your datacenters
    - Edge locations
    - Multiple hosting providers 
- A shared management and administration view, enabling you to connect to Kubernetes alongside Windows Server and Linux VMs, physical servers, and Azure data services.
- Clear roles and responsibilities for your IT staff, providing for role separation while still maintaining visibility of and access to resources, whatever their location.

#### Perform configuration with integrated management

Use Azure Arc enabled Kubernetes integrated management to more efficiently create, apply, and enforce policies to Kubernetes apps, data, and infrastructure, wherever those resources are located. Specifically, you can:

- Use Azure Policy to:
    - Establish consistent configurations across all your Kubernetes clusters
    - Enforce run-time conformance and to audit resources
- Implement role-based access control (RBAC) across systems and different types of resources to help to standardize security.
- Automate and delegate remediation of incidents and problems to service teams.
- Implement additional Azure services and leverage your choice of Azure tools:
    - Integrate with Azure Monitor, Security Center, GitHub, and others.
    - Automate configuration and infrastructure as code provide repeatable deployments using templates
    - Provide end-to-end identity for your users and your resources with Azure Resource Manager and Azure Active Directory (Azure AD).

#### Collect inventory data

By implementing Azure Arc enabled Kubernetes, you can more efficiently collect inventory data by:

- Unifying your resources so you can organize and inventory by using Azure scopes, such as:
    - Management groups
    - Subscriptions
    - Resource Groups
- Tracking resources by creating and applying standardized and custom tags.
- Searching your global resources with Azure Resource Graph.


### Azure Arc enabled Kubernetes agents

Similar to the way that you onboard servers to Azure Arc, you must also deploy agents to your Kubernetes clusters. The Kubernetes agent is responsible for:

- Connectivity to Azure.
- Collecting Azure Arc logs and metrics.
- Monitoring configuration requests.

Azure Arc enabled Kubernetes provides a number of agents. 

> [!NOTE]
> These agents run in the Kubernetes cluster that you deploy to the `azure-arc` namespace. 

The following table describes these agents.

|Agent|Description|
|---|---|
|`deployment.apps/config-agent`|Monitors the connected cluster for updates, compliance state, and source control configuration resources applied on the cluster.|
|`deployment.apps/controller-manager`|Orchestrates interactions between Azure Arc components.|
|`deployment.apps/metrics-agent`|Collects metrics from other Azure Arc agents to optimize the performance of these other agents.|
|`deployment.apps/cluster-metadata-operator`|Gathers cluster metadata, including cluster version, node count, and Azure Arc agent version.|
|`deployment.apps/resource-sync-agent`|Syncs cluster metadata to Azure.|
|`deployment.apps/clusteridentityoperator`|Maintains the certificate for the managed identities for Azure resources that other agents use for communication with Azure.|
|`deployment.apps/flux-logs-agent`|Collects logs from the flux operators that deploy as a part of source control configuration.|
