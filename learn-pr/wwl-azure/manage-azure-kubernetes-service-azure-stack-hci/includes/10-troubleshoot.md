Contoso needs a repeatable way to distinguish platform, access, and application failures. Start with the failing layer and collect evidence before changing the environment.

## Separate provisioning and access problems

If cluster deployment fails, inspect the Azure operation and the cluster's provisioning state. Check the custom location, logical network, available IP addresses, local capacity, and required permissions with the infrastructure administrator.

```powershell
az aksarc show --name $clusterName --resource-group $resourceGroup
```

If you can't access the cluster, check the selected subscription, Azure role assignments, Microsoft Entra group membership, and the status of the Arc proxy process. An expired or stopped proxy isn't the same as a Kubernetes authorization denial.

## Diagnose a failed Arc proxy

The Arc proxy depends on the cluster's Arc agents and their outbound connection to Azure. If that path is unavailable, proxy-based `kubectl` checks might also be unavailable. First inspect the connected-cluster resource through the Azure management plane. This check requires Azure resource read access, such as Reader at that resource's scope; don't assume the proxy-access role includes it.

```powershell
az connectedk8s show --name $clusterName --resource-group $resourceGroup `
    --query "{State:provisioningState,Connectivity:connectivityStatus}" --output table
```

Interpret the reported connectivity status:

- `Connected`: Azure received an agent heartbeat within the previous 15 minutes.
- `Offline`: A previously connected resource hasn't received an agent heartbeat for at least 15 minutes.
- `Expired`: The managed identity certificate has expired.

These connectivity statuses can lag an outage. A `Connected` result doesn't prove that the proxy, Kubernetes API, or pods are healthy.

If you have direct network access to the API server, the documented Microsoft Entra user-kubeconfig workflow provides another access route. Follow its separate role and client-tool prerequisites. Don't retrieve administrator credentials automatically as a troubleshooting shortcut.

When API access is available, check the Linux node pool and the `azure-arc` agents. Investigate required outbound access and DNS rather than deleting the connected cluster resource as an initial response. If neither API route is available, continue with **Preserve keys and collect support logs** later in this unit.

## Inspect Kubernetes resources and events

With a working API access route and the appropriate kubeconfig, collect the cluster's current state. The examples use `.\contoso-aks-kubeconfig` from the proxy workflow. If you used direct user access, substitute that workflow's kubeconfig path:

```powershell
kubectl --kubeconfig .\contoso-aks-kubeconfig get nodes -o wide
kubectl --kubeconfig .\contoso-aks-kubeconfig get pods --all-namespaces -o wide
kubectl --kubeconfig .\contoso-aks-kubeconfig get events --all-namespaces --sort-by=.metadata.creationTimestamp
```

While the API is available, record the node IP addresses from `get nodes -o wide` and the time of collection. These records can help you collect logs during a later API outage, but node replacement can make old addresses stale.

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

Use the Kubernetes API for routine application operations. Node access is a separate administrative capability.

> [!IMPORTANT]
> Both log-collection methods below require the correct cluster SSH private key, permitted SSH access, and direct network reachability from the collection workstation to the nodes. If SSH authorized IP ranges are configured, they must include the workstation's address. Inspect `authorizedIpRanges` under `clusterVmAccessProfile` in the earlier `az aksarc show` output. The Arc proxy provides Kubernetes API access, not an SSH tunnel.

When Kubernetes API discovery is available, use the documented `az aksarc get-logs` command for full cluster logs. It accepts a kubeconfig, the directory containing the SSH credentials, and an output directory. Replace the example credential path with the directory containing the correct key:

```powershell
az aksarc get-logs --kubeconfig .\contoso-aks-kubeconfig `
    --credentials-dir 'C:\Users\operator\.ssh' --out-dir .\aks-support-logs
```

If API discovery is unavailable, use a verified current node IP from your saved records or the infrastructure administrator. Confirm that the address still belongs to the intended node. Replace `<node-ip-address>` with that address and `<cluster-private-key-file-or-directory>` with the path to the correct SSH private key or its directory:

```powershell
az aksarc get-logs --ip '<node-ip-address>' `
    --credentials-dir '<cluster-private-key-file-or-directory>' `
    --out-dir .\aks-support-logs
```

With `--ip`, logs come from the specified node without Kubernetes API discovery. This doesn't repair connectivity or recover a lost key.

Review the collected logs for sensitive information, protect the resulting archive, and send it through your organization's approved support process. Record timestamps, the affected resource, recent changes, and the checks already performed.

For the current diagnostic procedures, see **Get on-demand logs** and **Connect to Windows or Linux worker nodes with SSH** in the Summary unit's **More info** section.
