Contoso needs a repeatable way to distinguish platform, access, and application failures. Start with the failing layer and collect evidence before changing the environment.

## Separate provisioning and access problems

If cluster deployment fails, inspect the Azure operation and the cluster's provisioning state. Check the custom location, logical network, available IP addresses, local capacity, and required permissions with the infrastructure administrator.

```powershell
az aksarc show --name $clusterName --resource-group $resourceGroup
```

If you can't access the cluster, check the selected subscription, Azure role assignments, Microsoft Entra group membership, and the status of the Arc proxy process. An expired or stopped proxy isn't the same as a Kubernetes authorization denial.

For Arc connectivity issues, check the Linux node pool and the `azure-arc` agents. Investigate required outbound access and DNS rather than deleting the connected cluster resource as an initial response.

## Inspect Kubernetes resources and events

With the proxy running and the kubeconfig available, collect the cluster's current state:

```powershell
kubectl --kubeconfig .\contoso-aks-kubeconfig get nodes -o wide
kubectl --kubeconfig .\contoso-aks-kubeconfig get pods --all-namespaces -o wide
kubectl --kubeconfig .\contoso-aks-kubeconfig get events --all-namespaces --sort-by=.metadata.creationTimestamp
```

Use the symptoms to choose the next check:

| Symptom | Initial checks |
| --- | --- |
| Pod remains pending | Node readiness, OS selector, taints, resource requests, and volume binding events. |
| Image pull fails | Image reference, registry connectivity, pull credentials, and host/image compatibility. |
| Container repeatedly restarts | Application logs, configuration, resource limits, and health checks. |
| PVC remains pending | Storage class, binding mode, provisioner events, and available capacity. |
| Kubernetes operation is forbidden | The authenticated identity and its Kubernetes authorization, not only Azure resource visibility. |

Inspect the specific pod and container when necessary. Replace the quoted example names with resources in the relevant namespace:

```powershell
kubectl --kubeconfig .\contoso-aks-kubeconfig describe pod 'pod-name' --namespace 'application-namespace'
kubectl --kubeconfig .\contoso-aks-kubeconfig logs 'pod-name' --namespace 'application-namespace' --container 'container-name'
```

## Preserve keys and collect support logs

Use the SSH private key associated with cluster creation when a supported diagnostic procedure requires direct node access or log collection. Don't assume that a key exists in a fixed `C:\ClusterStorage` path.

Verify the actual key location, node access settings, and network reachability. The Arc proxy provides Kubernetes API access, not SSH connectivity to the nodes. Run SSH-based log collection from a workstation with network access to the node IP addresses and permitted SSH access. Use the Kubernetes API for routine application operations. Node access is a separate administrative capability.

For full cluster logs, the documented `az aksarc get-logs` command accepts a kubeconfig, the directory containing the SSH credentials, and an output directory. Replace the example credential path with the directory containing the correct key:

```powershell
az aksarc get-logs --kubeconfig .\contoso-aks-kubeconfig `
    --credentials-dir 'C:\Users\operator\.ssh' --out-dir .\aks-support-logs
```

Protect the resulting archive and send it through your organization's approved support process. Record timestamps, the affected resource, recent changes, and the checks already performed.

See [Get on-demand logs](/azure/aks-hybrid-edge/local/hyperconverged/get-on-demand-logs) and [Connect to Windows or Linux worker nodes with SSH](/azure/aks/aksarc/ssh-connect-to-windows-and-linux-worker-nodes) for the current diagnostic procedures.
