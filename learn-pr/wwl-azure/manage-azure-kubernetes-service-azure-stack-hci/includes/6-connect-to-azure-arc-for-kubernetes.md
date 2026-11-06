Contoso needs a consistent inventory and management experience for its local Kubernetes clusters. AKS on Azure Local automatically connects newly provisioned clusters to Azure Arc, so your next task is to verify and operate that connection.

## Distinguish platform registration from cluster integration

Azure Local registration, Arc resource bridge, and an Arc-enabled Kubernetes cluster serve related but different purposes. Registering the platform doesn't replace checking the Kubernetes cluster's connected resource and agents.

AKS on Azure Local provisioning automatically enables Azure Arc on the workload cluster. Containerized Arc agents run in the `azure-arc` namespace. Keep at least one Linux node pool available to run those agents and maintain connectivity to Azure.

See AKS on Azure Local architecture for the automatic integration and Linux node-pool requirement.

## Verify connectivity and access

Use the Azure portal to locate the Kubernetes cluster's Azure resource and review its connection status. Confirm that the resource is in the expected subscription and resource group.

The Arc proxy depends on working Arc agents and their outbound connection to Azure. If the proxy can't connect, start with the **Diagnose a failed Arc proxy** section in the troubleshooting unit before attempting the Kubernetes checks. That procedure starts with an Azure management-plane check and covers alternative access and log-collection routes.

With the proxy from the deployment unit running, inspect the Arc components:

```powershell
kubectl --kubeconfig .\contoso-aks-kubeconfig get pods --namespace azure-arc
kubectl --kubeconfig .\contoso-aks-kubeconfig get deployments --namespace azure-arc
```

If agents aren't healthy, investigate node availability, pod events, DNS, and required network connectivity. Don't assume that recreating the connected resource is the first repair step.

Also test the intended administrator's Kubernetes access. The deployment example uses a Microsoft Entra administrator group with Kubernetes authorization. In this example, Azure resource-management and proxy-access role assignments don't replace authorization inside Kubernetes. Application teams usually need narrower access than the administrator group's cluster-wide rights.

If a cluster instead uses Azure RBAC for Kubernetes authorization, Azure role assignments can also authorize Kubernetes API operations. See Use Azure RBAC for Kubernetes authorization for that model's configuration and role assignments.

The `az connectedk8s proxy` process creates an access channel. It doesn't repair failed workload pods, grant missing permissions, or replace the Arc agents.

## Plan optional management capabilities

Arc integration provides a foundation for additional services, but it doesn't automatically configure every policy, monitoring collection, or GitOps deployment.

For each capability, identify its prerequisites and configuration:

- **Azure Policy:** Configure the supported policy integration and assignments for the controls you intend to assess or enforce.
- **GitOps:** Configure the desired repositories, credentials, and reconciliation scope rather than assuming that connecting a cluster deploys application manifests.
- **Monitoring:** Configure the supported monitoring integration and destination, and verify that the expected data arrives.

Before you enable an integration, check permissions, network access, and any applicable charges. Test its behavior rather than relying on the presence of an Arc resource to confirm that the feature works.

Verify each result separately: the Azure resource is present, the agents are healthy, administrators can access Kubernetes, and each selected management integration produces its intended result. See Azure Arc-enabled Kubernetes overview for the management capabilities available through Arc.

## Validate control-plane metrics and alerts (optional)

Complete this exercise only if Contoso chooses to use Azure Monitor for control-plane metrics. It isn't required to connect the cluster to Arc. Review the supported monitoring options when choosing which signals to collect.

Follow these steps to verify collection and alerting:

1. Follow the full control-plane metrics integration guide, starting with its prerequisites. Install the `k8s-extension` Azure CLI extension as the guide directs; this module's preparation commands don't install it. Confirm the required permissions, network connectivity, and destination Azure Monitor workspace.
1. Complete the guide's collection and destination configuration. Verify collection health, then query the destination workspace for a recent control-plane metric sample from this cluster. Check the sample's cluster identity and timestamp so old data or data from another cluster doesn't appear to confirm success.
1. Create a Prometheus alerting rule in a Prometheus rule group associated with the Azure Monitor workspace receiving the metrics. Choose the appropriate cluster scope so the rule evaluates this cluster's data. Use a metric observed in the workspace and a condition that represents an actionable operational issue.
1. Attach an action group to the alerting rule following the Prometheus alerts guide. Test the alert and notification path in the exercise environment, and verify that the intended operator receives the notification. Restore the intended alert condition if you changed it for the test.
1. Record the expected signal, workspace query, alert rule, and where the operator investigates an alert. The exercise is complete when you've observed recent cluster data and confirmed notification delivery, not merely installed a collection extension.

> [!NOTE]
> Running collector pods don't prove that data is arriving at the destination. Metrics, logs, and application backups serve different purposes; enabling metrics doesn't enable the others.

For the Azure Arc, monitoring, and alerting references used in this unit, see the Summary unit's **More info** section.
