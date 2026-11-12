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

An AKS logical network uses static IP allocation. Check its DNS servers, gateway, address pool, and available addresses with the infrastructure administrator. Confirm that its DNS servers resolve the Azure Local cluster's fully qualified domain name.

Account for an address for each AKS node VM, a control-plane endpoint address for each cluster, and the documented extra address per cluster for rolling upgrades, in addition to scaling headroom. Exhausted address pools can prevent deployment. See IP address planning for the current capacity rules.

In the documented single-subnet configuration, reserve service load-balancer addresses in the same subnet as the logical network but outside its IP pool. If your application requires external load balancing on a different network, follow the network requirements for that design. In either case, check existing infrastructure allocations so that addresses don't conflict.

See Create logical networks for Kubernetes clusters for infrastructure-level network preparation. Creating a logical network is a separate task from choosing it during AKS cluster creation.

## Prepare access and application requirements

Use delegated access appropriate to the task. The Azure portal deployment guidance specifies Contributor access to the custom location and AKS logical network. The creation tutorial also uses Contributor permissions on the resource group that hosts the Kubernetes cluster.

For ongoing Arc proxy access, Contributor on the resource group is sufficient but isn't the minimum required role. The **Azure Arc-enabled Kubernetes Cluster User** role on the connected cluster provides the required Azure permission for proxy access. Users also need Kubernetes authorization, such as membership in the administrator group used in this example. In this example, an Azure management role assignment alone doesn't grant Kubernetes administrator access. See Control access using Microsoft Entra ID and Kubernetes RBAC for the access requirements.

Have an authorized administrator arrange any missing role assignments.

Create or identify a Microsoft Entra group for the cluster administrators and confirm its membership. Members of the group supplied during cluster creation receive Kubernetes administrator access. Use a dedicated administrative group rather than a broad group containing all application users.

Before you deploy, check the workload requirements:

- Supported Kubernetes versions and node VM sizes.
- Linux and optional Windows node-pool capacity.
- Persistent storage requirements and data-protection plans.
- Application identity, networking, and image-registry access.

On Azure Local release 2509 and later, an Azure Local administrator must enable the Windows node-pool feature when Windows pools are required. If a cluster has a Windows pool while the feature is disabled, cluster updates and upgrades, and node-pool add or update operations, can fail with "The Windows node pool feature is disabled." Follow Enable Windows node pools before creating Windows pools or performing those operations.

## Prepare the management workstation

On a management workstation, install a current Azure CLI release and a `kubectl` client supported by the target cluster. The `aksarc` extension currently requires Azure CLI version 2.77.0 or later. Kubernetes supports `kubectl` within one minor version, older or newer, of the Kubernetes API server. See the Kubernetes version skew policy.

The examples use Azure CLI from PowerShell. Don't install the Azure CLI extensions directly on Azure Local nodes for this workflow.

In PowerShell, replace the angle-bracketed placeholders, including the brackets, with the details supplied by your administrator. Keep the same session open for cluster creation in the next unit. PowerShell variables aren't shared between terminals, so set the required variables again whenever you open a new terminal.

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

Check what your custom location offers:

```powershell
az aksarc get-versions --custom-location $customLocationId
az aksarc vmsize list --custom-location $customLocationId --resource-group $resourceGroup
```

> [!NOTE]
> `az aksarc get-versions` automatically creates or uses the `kubernetesVersions/default` Azure resource for the custom location. It doesn't create a workload cluster, but it isn't strictly read-only.

Review the versions, operating system (OS) SKUs, readiness information where reported, and VM sizes offered by this custom location. For each intended node OS, confirm that the relevant image is ready. Follow the Kubernetes version readiness guidance and, when needed, the Windows image readiness guidance. A listed version isn't sufficient if its image download is incomplete. Ask the infrastructure administrator to resolve readiness failures before provisioning. These checks complement, rather than replace, the cluster creation command's `--validate` option.

Before you proceed, confirm that the selected account can access the target resources and belongs to the intended Kubernetes administrator group. For the current access and tool requirements, see **Create Kubernetes clusters using Azure CLI** and **Azure portal deployment prerequisites** in the Summary unit's **More info** section.
