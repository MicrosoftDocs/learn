Contoso hosts Kubernetes clusters in multiple datacenters throughout the world, using many different Kubernetes distributions. Contoso's IT staff wants to manage these disparate clusters using consistent tools and processes. Azure Arc provides a single toolset for managing these clusters.

## What is Azure Arc-enabled Kubernetes?

Using Azure Arc, you can connect Kubernetes clusters located anywhere to Azure. You can then manage these connected clusters in a consistent way, just as you would in Azure. Azure Arc-enabled Kubernetes lets you control the cluster configuration and workloads at scale, using your Git repositories as the source of truth. This connection to Azure provides management capabilities such as inventory, monitoring, policy compliance, security, user access, and more.

Azure Arc-enabled Kubernetes works with any Cloud Native Computing Foundation (CNCF) certified Kubernetes clusters. This includes clusters running on other public cloud providers and clusters running in on-premises datacenters.

## Onboard Kubernetes clusters to Azure Arc

Similar to the way that you onboard servers to Azure Arc, you must deploy agents to your Kubernetes clusters in order to connect them. These agents are responsible for connecting to Azure, collecting Azure Arc logs and metrics, and managing configuration requests.

Each Kubernetes cluster that you enable with Azure Arc:

- Is assigned an Azure Resource Manager ID.
- Has a managed identity.
- Is located in an Azure resource group and subscription.
- Appears in the Azure portal.
- Can use tags and other Azure management features.

:::image type="content" source="../media/4-kubernetes.png" alt-text="Screenshot of the Azure Arc Kubernetes clusters page in the Azure portal that displays a list of Kubernetes resources." border="false" lightbox="../media/4-kubernetes.png" :::

## What can you do with Azure Arc-enabled Kubernetes?

You can use Azure Arc-enabled Kubernetes to address many requirements in your organization.

With Azure Arc-enabled Kubernetes, you can create a shared application and infrastructure environment. This approach enables you to implement:

- Consistent management of your resources using the Azure portal and APIs across:
  - Your datacenters
  - Edge locations
  - Multiple hosting providers
- Clear roles and responsibilities for your IT and engineering staff, providing role separation while still maintaining visibility and access to resources, wherever their location.
- Ability to organize your clusters with standardized and custom tags.
- Querying across clusters with Azure Resource Graph.

Once your Kubernetes clusters are connected to Azure, at scale you can:

- Configure clusters and deploy applications using GitOps-based configuration management.
- View and monitor your clusters using Azure Monitor for containers.
- Enforce threat protection using Microsoft Defender for Kubernetes.
- Ensure governance through applying policies with Azure Policy for Kubernetes.
- Grant access and connect to your Kubernetes clusters from anywhere, and manage access by using Azure role-based access control (RBAC) on your cluster.
- Deploy machine learning workloads using Azure Machine Learning for Kubernetes clusters.
- Deploy services that allow you to take advantage of specific hardware, comply with data residency requirements, or enable new scenarios.