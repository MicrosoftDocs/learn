Before you create Contoso's first workload cluster, collect the infrastructure details and prepare a management workstation. You use this preparation to deploy the cluster in the next unit.

## Verify the local deployment target

Start with a supported, deployed hyperconverged Azure Local environment. Work with its infrastructure administrator to confirm that Arc resource bridge and the AKS extension are healthy and that the custom location is available.

Obtain the following values:

| Value | Purpose |
| --- | --- |
| Azure subscription ID | Select the subscription associated with the deployment. |
| Resource group name | Identify the existing resource group for the AKS cluster resource. |
| Custom location resource ID | Target the prepared local environment. |
| AKS logical network resource ID | Select the network used by the cluster's underlying VMs. |
| Microsoft Entra group object ID | Grant the selected group's members Kubernetes administrator access in the example workflow. |

An AKS logical network uses static IP allocation. Check its DNS, gateway, address pool, and available addresses with the infrastructure administrator. Reserve capacity for the intended cluster and future operations; exhausted address pools can prevent deployment.

See [Create logical networks for Kubernetes clusters](/azure/aks-hybrid-edge/local/hyperconverged/aks-networks) for infrastructure-level network preparation. Creating a logical network is a separate task from choosing it during AKS cluster creation.

## Prepare access and application requirements

Use delegated access appropriate to the task. The Azure portal deployment guidance specifies Contributor access to the custom location and AKS logical network. The creation tutorial also uses Contributor permissions on the resource group that hosts the Kubernetes cluster.

For ongoing Arc proxy access, Contributor on the resource group is sufficient but isn't the minimum required role. The **Azure Arc-enabled Kubernetes Cluster User** role on the connected cluster provides the required Azure permission for proxy access. Users also need Kubernetes authorization, such as membership in the administrator group used in this example. An Azure role assignment alone doesn't grant Kubernetes administrator access. See [Control access using Microsoft Entra ID and Kubernetes RBAC](/azure/aks-hybrid-edge/local/hyperconverged/kubernetes-rbac-local) for the access requirements.

Have an authorized administrator arrange any missing role assignments.

Create or identify a Microsoft Entra group for the cluster administrators and confirm its membership. Members of the group supplied during cluster creation receive Kubernetes administrator access. Use a dedicated administrative group rather than a broad group containing all application users.

Before you deploy, check the workload requirements:

- Supported Kubernetes versions and node VM sizes.
- Linux and optional Windows node-pool capacity.
- Persistent storage requirements and data-protection plans.
- Application identity, networking, and image-registry access.

Before you create or update Windows pools on Azure Local release 2509 or later, follow [Enable Windows node pools](/azure/aks-hybrid-edge/local/hyperconverged/howto-enable-windows-node-pools).

## Prepare the management workstation

On a management workstation, install a current Azure CLI release and a `kubectl` client supported by the target cluster. The `aksarc` extension currently requires [Azure CLI version 2.77.0 or later](/cli/azure/aksarc). Kubernetes supports `kubectl` within one minor version, older or newer, of the Kubernetes API server. See the [Kubernetes version skew policy](https://kubernetes.io/releases/version-skew-policy/#kubectl).

The examples use Azure CLI from PowerShell. Don't install the Azure CLI extensions directly on Azure Local nodes for this workflow.

In PowerShell, replace the bracketed values with the details supplied by your administrator. Keep the same session open for cluster creation in the next unit.

```powershell
$subscriptionId = '<subscription-id>'
$resourceGroup = '<existing-resource-group>'
$clusterName = 'contosok8s'
$customLocationId = '<custom-location-resource-id>'
$logicalNetworkId = '<logical-network-resource-id>'
$adminGroupId = '<microsoft-entra-group-object-id>'

az login
az account set --subscription $subscriptionId
az extension add --name aksarc --upgrade
az extension add --name customlocation --upgrade
az extension add --name stack-hci-vm --upgrade
az extension add --name connectedk8s --upgrade
```

These commands authenticate the administrator, select the subscription, and install or update the management extensions. They don't deploy an AKS cluster.

Before you proceed, confirm that the selected account can access the target resources and belongs to the intended Kubernetes administrator group. See [Create Kubernetes clusters using Azure CLI](/azure/aks-hybrid-edge/local/aks-create-clusters-cli) and [Azure portal deployment prerequisites](/azure/aks-hybrid-edge/local/aks-create-clusters-portal) for the current access and tool requirements.
