Once your AKS Edge Essentials cluster is connected to Azure Arc, it extends the Azure platform to the edge with core services such as governance, monitoring, application, ML, and data services.

In the retail chain scenario, we connect AKS Edge Essentials to Azure Arc, which provides a centralized management console for Kubernetes clusters running anywhere, scalability, and robust security that helps optimize the retail chain's customer experience strategies.

Here, you learn how to Arc-Enable your AKS Edge Essentials cluster and manage it using the Azure portal.

:::image type="content" source="../media/2-aks-edge-essentials-kubernetes-azure-arc-resource-inline.png" alt-text="Screenshot of AKS Edge Essentials Kubernetes Azure Arc resource in Azure portal." lightbox="../media/2-aks-edge-essentials-kubernetes-azure-arc-resource-expanded.png":::

## What is Azure Arc-enabled Kubernetes?

Using Azure Arc, you can connect Kubernetes clusters located anywhere to Azure. You can then manage these connected clusters in a consistent way, just as you would in Azure. Azure Arc-enabled Kubernetes lets you control the cluster configuration and workloads at scale, using your Git repositories as the source of truth. This connection to Azure provides management capabilities such as inventory, monitoring, policy compliance, security, user access, and more.

Azure Arc-enabled Kubernetes works with any Cloud Native Computing Foundation (CNCF) certified Kubernetes clusters, including AKS Edge Essentials.

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

## How to connect AKS Edge Essentials to Azure Arc

 You must deploy agents to your Kubernetes clusters in order to connect them. These agents are responsible for connecting to Azure, collecting Azure Arc logs and metrics, and managing configuration requests. Once your AKS Edge Essentials is deployed, you can easily connect it to Azure Arc by running the `Connect-AksEdgeArc` PowerShell command. This command deploys the Azure Arc agent to your cluster and connects it to Azure Arc:

```powershell
# Connect Arc-enabled kubernetes
Connect-AksEdgeArc -JsonConfigFilePath .\aksedge-config.json
```

Provide details of your Azure subscription in the [aksedge-config.json](https://github.com/Azure/AKS-Edge/blob/main/tools/aksedge-config.json) file under the `Arc` section as described in the following table. To successfully connect to Azure using Azure Arc-enabled kubernetes, you need a service principal with the built-in `Microsoft.Kubernetes connected cluster` role in order to access resources on Azure.

| Attribute | Value type      |  Description |
| :------------ |:-----------|:--------|
|`ClusterName` | string | Provide a name for your cluster. The default value is `hostname_cluster`. |
|`Location` | string | The location of your resource group. Choose the location closest to your deployment. |
|`SubscriptionId` | GUID | Your subscription ID. |
|`TenantId` | GUID | Your tenant ID. |
|`ResourceGroupName` | string | The name of the Azure resource group to host your Azure resources for AKS Edge Essentials. |
|`ClientId` | GUID | Provide the application ID of the Azure service principal to use as credentials. AKS Edge Essentials uses this service principal to connect your cluster to Arc. You can use the **App Registrations** page in the Microsoft Entra resource page on the Azure portal, to list and manage the service principals in a tenant.|
|`ClientSecret` | string | Provide the password for the service principal. |

## How to disconnect AKS Edge Essentials from Azure Arc

You can disconnect your AKS Edge Essentials cluster from Azure Arc by running the `Disconnect-AksEdgeArc` PowerShell command. This command removes the Azure Arc agent from your cluster and disconnects it from Azure Arc:

```powershell
# Disconnect Arc-enabled kubernetes
Disconnect-AksEdgeArc -JsonConfigFilePath .\aksedge-config.json
```