Use Contoso's prepared Azure Local infrastructure and management workstation to create the workload cluster. The supported provisioning workflow also connects the cluster to Azure Arc.

## Validate and create the cluster

Use the PowerShell session and variables from the preparation unit. First validate the intended deployment:

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

Check the provisioning state and investigate failures before you deploy applications. See [Create Kubernetes clusters using Azure CLI](/azure/aks-hybrid-edge/local/aks-create-clusters-cli) for the complete parameter reference and current release requirements.

## Connect through Azure Arc

The example uses Microsoft Entra authentication and the Arc cluster connection proxy. On the management workstation, open a second PowerShell terminal in the same working directory as the original terminal. Set the resource group to the value used for deployment, then start the proxy:

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

## Prepare for ongoing operations

Record the cluster resource, custom location, network, administrator group, SSH key location, and chosen version and capacity settings. Verify that the connected cluster appears in Azure and that its Arc agents are healthy.

Don't run a separate legacy `Enable-AksHciArcConnection` onboarding sequence for this cluster. Arc integration is part of provisioning. The next unit explains how to verify that integration and plan optional management capabilities.
