Use Contoso's prepared Azure Local infrastructure and management workstation to create the workload cluster. The supported provisioning workflow also connects the cluster to Azure Arc.

## Choose the cluster identity model

This example uses a Microsoft Entra administrator group with Kubernetes authorization. It doesn't enable Azure RBAC for Kubernetes authorization or workload identity.

> [!IMPORTANT]
> If you need Azure RBAC for Kubernetes authorization or workload identity, enable it with its required parameters when you create the cluster. In the documented AKS on Azure Local hyperconverged workflow, you currently can't enable either capability on an existing cluster or disable workload identity after enabling it. Make these choices before provisioning.
>
> Workload identity for this deployment is currently in preview. It's an opt-in feature with best-effort support, excluded from service-level agreements and limited warranty. Review the workload identity preview terms and support policy before adopting it; don't treat it as a generally available production feature.

If you need Azure RBAC for Kubernetes authorization, follow the platform-specific creation and role-assignment instructions rather than adding a flag without its prerequisites. Workload identity is a separate application-identity capability, not a replacement for human administrator authentication. Keep Azure resource-management permissions, credential or proxy access, and authorization inside Kubernetes distinct.

## Validate and create the cluster

Use the PowerShell session and variables from the preparation unit. If you opened a new terminal, set those variables again and select the intended subscription. Complete the preparation unit's custom-location version, node-image readiness, VM-size, and network-capacity checks before validating the intended deployment:

```powershell
az aksarc create --name $clusterName --resource-group $resourceGroup `
    --custom-location $customLocationId --vnet-ids $logicalNetworkId `
    --aad-admin-group-object-ids $adminGroupId --generate-ssh-keys --validate
```

Before you proceed, investigate any reported validation errors. Successful parameter validation doesn't confirm that the deployment meets application requirements or has enough production capacity.

Run the command without `--validate` to create the cluster:

```powershell
az aksarc create --name $clusterName --resource-group $resourceGroup `
    --custom-location $customLocationId --vnet-ids $logicalNetworkId `
    --aad-admin-group-object-ids $adminGroupId --generate-ssh-keys
```

The custom location selects the deployment target, and the logical network selects the VM network. The Microsoft Entra group identifies the Kubernetes administrators. Review supported Kubernetes versions, node counts, and VM-size options for your environment rather than treating defaults as production sizing.

The command requests SSH keys for node troubleshooting. Protect the private key and record its actual location. The key isn't a Kubernetes user credential. Keep node access separate from application deployment permissions.

Inspect the resulting Azure resource:

```powershell
az aksarc show --name $clusterName --resource-group $resourceGroup
```

Check the provisioning state and investigate failures before you deploy applications. See Create Kubernetes clusters using Azure CLI for the complete parameter reference and current release requirements.

## Connect through Azure Arc

The example uses Microsoft Entra authentication and the Arc cluster connection proxy. On the management workstation, open a second PowerShell terminal in the same working directory as the original terminal. PowerShell variables aren't shared between terminals. Set the resource group and cluster name again to the values used for deployment, then start the proxy:

```powershell
$resourceGroup = '<existing-resource-group>'
$clusterName = 'contosok8s'
az connectedk8s proxy --name $clusterName --resource-group $resourceGroup `
    --file .\contoso-aks-kubeconfig
```

Keep that terminal open while you access the cluster. The proxy channel remains available while the command runs. If it stops, reestablish the connection before retrying Kubernetes operations.

Return to the original management terminal and inspect the nodes. Both terminals use the same working directory, so the kubeconfig file is available there. The original deployment variables also remain available for later Azure CLI commands:

```powershell
kubectl --kubeconfig .\contoso-aks-kubeconfig get nodes -o wide
kubectl --kubeconfig .\contoso-aks-kubeconfig get pods --all-namespaces
```

Confirm that nodes reach `Ready` and investigate unhealthy system pods. Check Azure resource permissions, membership in the selected Microsoft Entra group, and Kubernetes authorization separately. A successful Azure sign-in doesn't confirm that all three are configured.

## Discover supported upgrades

For an existing cluster, use these read-only commands during maintenance planning. They aren't a required continuation of cluster creation. Use the original management terminal, or set `$resourceGroup` and `$clusterName` again in a new terminal and select the intended subscription by following the preparation steps.

```powershell
az aksarc show --name $clusterName --resource-group $resourceGroup
az aksarc get-upgrades --name $clusterName --resource-group $resourceGroup
```

Compare the current version and offered upgrades with the supported Kubernetes versions for the target Azure Local release. Don't infer the future release's version availability solely from the current environment. Upgrade Kubernetes before Azure Local when needed to preserve a supported path, proceeding one minor version at a time.

## Planned maintenance example

The following example changes an existing cluster. Run it only when you have an approved maintenance plan and a supported next version from upgrade discovery. Reserve replacement-node capacity and upgrade IP addresses, and check application disruption and recovery requirements first. If the cluster has Windows pools, satisfy the preparation unit's Windows feature-enablement requirement before upgrading.

Rolling node replacement doesn't by itself guarantee application availability. Plan replica counts, readiness behavior, and appropriate PodDisruptionBudgets for your application.

In the management terminal, replace the placeholder with the supported next version from your plan:

```powershell
$targetKubernetesVersion = '<supported-next-version-from-your-upgrade-plan>'
az aksarc upgrade --name $clusterName --resource-group $resourceGroup `
    --kubernetes-version $targetKubernetesVersion
```

Inspect the operation state:

```powershell
az aksarc show --name $clusterName --resource-group $resourceGroup
```

Check both `provisioningState` and `currentState`. If the command times out and `currentState` still shows `Upgrading`, the upgrade guide explains that the operation can continue in the background even when `provisioningState` shows `Failed`. Inspect its state rather than immediately starting another upgrade.

After the operation completes, check the resulting versions, node readiness, and application health. Keep the Arc proxy running in its separate terminal, or reestablish it if necessary, before using `kubectl`. Use the same working directory that contains `contoso-aks-kubeconfig`:

```powershell
kubectl --kubeconfig .\contoso-aks-kubeconfig get nodes
```

> [!NOTE]
> AKS on Azure Local doesn't currently support node-image-only updates across all supported Kubernetes versions; the upgrade guide says the `node-image-only` option returns a not-yet-supported message. To incorporate the latest node-image updates, follow the documented path to the latest Kubernetes version available for the cluster, proceeding one minor version at a time.

## Prepare for ongoing operations

Record the cluster resource, custom location, network, administrator group, SSH key location, and chosen version and capacity settings. Verify that the connected cluster appears in Azure and that its Arc agents are healthy.

Don't run a separate legacy `Enable-AksHciArcConnection` onboarding sequence for this cluster. Arc integration is part of provisioning. The next unit explains how to verify that integration and plan optional management capabilities.

The Summary unit's **More info** section contains the deployment, identity, and upgrade references used in this unit.
