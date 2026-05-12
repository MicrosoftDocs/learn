## Authenticate to AKS with Microsoft Entra

By default, Azure Kubernetes Service (AKS) supports two authentication paths to the API server: local Kubernetes accounts and Microsoft Entra-based authentication. Local accounts are static credentials stored in kubeconfig that exist as long as the cluster exists. They can't be managed through your identity governance infrastructure—no conditional access policies apply, no sign-in logs appear in Microsoft Entra, and access doesn't terminate when an employee leaves. Microsoft Entra integration replaces local accounts as the identity provider for cluster authentication.

When Microsoft Entra integration is enabled, users authenticate to the API server using short-lived Microsoft Entra tokens. Microsoft Entra sign-in integrates cluster access with your organization's existing identity policies: conditional access policies apply to cluster authentication, sign-in events are recorded in Microsoft Entra audit logs, and access governance processes that apply to any other Azure resource apply here too.

To enable Microsoft Entra integration when creating a new cluster:

```azurecli
az aks create \
  --resource-group <resource-group> \
  --name <cluster-name> \
  --enable-aad \
  --aad-admin-group-object-ids <group-object-id>
```

For an existing cluster, enable Microsoft Entra integration without recreating it:

```azurecli
az aks update \
  --resource-group <resource-group> \
  --name <cluster-name> \
  --enable-aad \
  --aad-admin-group-object-ids <group-object-id>
```

### Disable local accounts

Enabling Microsoft Entra integration doesn't automatically disable local accounts. With both authentication paths active, someone with access to the cluster's static credentials can still authenticate while bypassing Microsoft Entra conditional access and audit logging. Disabling local accounts closes this path and ensures all cluster access flows through Microsoft Entra.

```azurecli
az aks update \
  --resource-group <resource-group> \
  --name <cluster-name> \
  --disable-local-accounts
```

> [!IMPORTANT]
> Before disabling local accounts, confirm that at least one Microsoft Entra group is configured as a cluster admin group. Removing local accounts without valid Microsoft Entra admin access locks you out of the cluster.

## Understand the two RBAC models

Authentication determines who can reach the API server. Authorization determines what they can do once they're authenticated. AKS supports two RBAC models for authorization: **Kubernetes RBAC** and **Azure RBAC for Kubernetes authorization**. Both can be active simultaneously, and each is suited to different scenarios.

**Kubernetes RBAC** is the native Kubernetes authorization system. It uses four resource types:

- **ClusterRole**: defines permissions that apply across all namespaces
- **Role**: defines permissions scoped to a single namespace
- **ClusterRoleBinding**: grants a ClusterRole to a user, group, or service account cluster-wide
- **RoleBinding**: grants a Role or ClusterRole to a user, group, or service account within a namespace

Kubernetes RBAC is evaluated inside the cluster and controls what authenticated identities can do with Kubernetes API resources—creating pods, listing secrets, managing deployments.

**Azure RBAC for Kubernetes authorization** uses Azure role assignments to authorize access to Kubernetes resources. Assignments are made in the Azure control plane, the same model used for any Azure resource, and are enforced when requests reach the API server. Azure RBAC is evaluated before Kubernetes RBAC, so an Azure deny assignment blocks access regardless of what a Kubernetes RoleBinding would allow.

Azure RBAC for Kubernetes includes two built-in roles that control access to cluster credentials:

- **Azure Kubernetes Service Cluster Admin Role**: grants access to pull the cluster admin kubeconfig, which provides unrestricted cluster access
- **Azure Kubernetes Service Cluster User Role**: grants access to pull the regular user kubeconfig, which provides authenticated access without predefined permissions

## Use the recommended authorization pattern

The recommended pattern combines both models: **use Azure RBAC to control who can retrieve cluster credentials, and use Kubernetes RBAC for namespace-scoped permissions inside the cluster**.

Assign Azure RBAC roles to control kubeconfig access. Grant the Azure Kubernetes Service Cluster Admin Role only to identities that need unrestricted access—platform administrators and break-glass accounts. Grant the Azure Kubernetes Service Cluster User Role to developers and operators who need authenticated but scoped access. These assignments determine what credentials someone can download from Azure; they don't determine what those credentials permit inside the cluster.

Use Kubernetes RBAC to define what authenticated users can do. Namespace-scoped RoleBindings let you grant a development team access to their own namespace without visibility into other teams' workloads.

> [!NOTE]
> AKS-hosted workloads—including AI agents, orchestrators, and services that call Azure OpenAI or Azure AI Foundry—should use workload identity rather than service principal credentials. Workload identity eliminates credential storage entirely and is covered in detail in the unit on secrets management.

## Bind roles to Microsoft Entra groups

When creating Kubernetes RoleBindings and ClusterRoleBindings, bind to Microsoft Entra groups rather than individual user accounts. Group-based bindings mean that access changes—onboarding a new team member or removing a departed employee—require only a change to group membership, not a modification to Kubernetes RBAC objects. The change takes effect at the next authentication without any cluster configuration update.

Individual user bindings require modifying Kubernetes RBAC objects for every access change. In a cluster with multiple teams and namespaces, this creates administrative overhead and increases the risk that former employees' bindings persist after their Microsoft Entra accounts are disabled.

The following RoleBinding grants the `view` ClusterRole to all members of a Microsoft Entra group within the `retail-app` namespace:

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: dev-team-readers
  namespace: retail-app
subjects:
- kind: Group
  name: <entra-group-object-id>
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: view
  apiGroup: rbac.authorization.k8s.io
```

Replace `<entra-group-object-id>` with the object ID of the Microsoft Entra group. When you add or remove users from the group, their cluster access changes automatically without any modification to the RoleBinding.

With Microsoft Entra integration enabled, local accounts disabled, and role bindings mapped to Microsoft Entra groups, Contoso Retail's cluster access model is fully governed through their identity infrastructure. Every access event is visible in Microsoft Entra audit logs, and cluster access terminates automatically when an employee's Microsoft Entra account is disabled.
