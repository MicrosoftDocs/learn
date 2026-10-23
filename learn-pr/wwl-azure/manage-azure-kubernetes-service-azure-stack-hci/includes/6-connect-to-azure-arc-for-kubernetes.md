Contoso needs a consistent inventory and management experience for its local Kubernetes clusters. AKS on Azure Local automatically connects newly provisioned clusters to Azure Arc, so your next task is to verify and operate that connection.

## Distinguish platform registration from cluster integration

Azure Local registration, Arc resource bridge, and an Arc-enabled Kubernetes cluster serve related but different purposes. Registering the platform doesn't replace checking the Kubernetes cluster's connected resource and agents.

AKS on Azure Local provisioning automatically enables Azure Arc on the workload cluster. Containerized Arc agents run in the `azure-arc` namespace. Keep at least one Linux node pool available to run those agents and maintain connectivity to Azure.

See [AKS on Azure Local architecture](/azure/aks-hybrid-edge/local/hyperconverged/cluster-architecture) for the automatic integration and Linux node-pool requirement.

## Verify connectivity and access

Use the Azure portal to locate the Kubernetes cluster's Azure resource and review its connection status. Confirm that the resource is in the expected subscription and resource group.

With the proxy from the deployment unit running, inspect the Arc components:

```powershell
kubectl --kubeconfig .\contoso-aks-kubeconfig get pods --namespace azure-arc
kubectl --kubeconfig .\contoso-aks-kubeconfig get deployments --namespace azure-arc
```

If agents aren't healthy, investigate node availability, pod events, DNS, and required network connectivity. Don't assume that recreating the connected resource is the first repair step.

Also test the intended administrator's Kubernetes access. Azure RBAC controls Azure management operations, while Kubernetes authorization controls operations on cluster resources. The deployment example supplies a Microsoft Entra administrator group. Application teams usually need narrower access than that group's cluster-wide administration rights.

The `az connectedk8s proxy` process creates an access channel. It doesn't repair failed workload pods, grant missing permissions, or replace the Arc agents.

## Plan optional management capabilities

Arc integration provides a foundation for additional services, but it doesn't automatically configure every policy, monitoring collection, or GitOps deployment.

For each capability, identify its prerequisites and configuration:

- **Azure Policy:** Configure the supported policy integration and assignments for the controls you intend to assess or enforce.
- **GitOps:** Configure the desired repositories, credentials, and reconciliation scope rather than assuming that connecting a cluster deploys application manifests.
- **Monitoring:** Configure the supported monitoring integration and destination, and verify that the expected data arrives.

Before you enable an integration, check permissions, network access, and any applicable charges. Test its behavior rather than relying on the presence of an Arc resource to confirm that the feature works.

Verify each result separately: the Azure resource is present, the agents are healthy, administrators can access Kubernetes, and each selected management integration produces its intended result. See [Azure Arc-enabled Kubernetes overview](/azure/azure-arc/kubernetes/overview) for the management capabilities available through Arc.
