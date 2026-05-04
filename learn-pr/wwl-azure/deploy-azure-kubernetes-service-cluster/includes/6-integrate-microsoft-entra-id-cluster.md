Securing access to and from an Azure Kubernetes Service (AKS) cluster is critical. AKS identity decisions fall into two areas:

- **Inside-out access**. AKS and workloads access Azure resources such as networking infrastructure, Azure Container Registry, and Azure Key Vault. Authorize only the resources they need.
- **Outside-in access**. Users, groups, and automation need access to the Kubernetes API server and Azure Resource Manager. Authorize only the identities that need cluster credentials or Kubernetes API permissions.

## Cluster-to-Azure managed identities (control plane and kubelet)

The control-plane identity is how AKS manages Azure resources for the cluster. AKS uses a system-assigned managed identity by default when you create a cluster, and managed identity is recommended for the control-plane identity. You don't need to create or rotate a service principal secret.

Managed identities are the default and recommended identity model for AKS clusters. Service principals are still supported, but new clusters should use a managed identity. If you have an existing service-principal-based cluster, you can migrate it to a system-assigned managed identity later by running:

```bash
az aks update --resource-group <rg> --name <cluster> --enable-managed-identity
```

After running this command, the cluster's control-plane identity is migrated to a system-assigned managed identity. Two follow-up steps may be required to complete the migration to a fully managed-identity-based cluster: if your cluster previously used the AKS-to-ACR integration to pull from Azure Container Registry, you must re-grant ACR pull permissions to the new kubelet managed identity (see the IMPORTANT note below); and you must upgrade node-pool images so the kubelet on each node stops using the service principal and starts using the managed identity.

> [!IMPORTANT]
> If your cluster previously used the AKS-to-ACR integration to pull from Azure Container Registry, the new kubelet managed identity doesn't inherit registry pull permissions. After migration, re-grant access:
> - For non-ABAC ACR registries, re-run `az aks update --resource-group <rg> --name <cluster> --attach-acr <acr-resource-id>` so the new kubelet identity is granted `AcrPull` on the registry. Run this command as an identity that has permission to create role assignments on the registry; otherwise, assign the `AcrPull` role to the kubelet managed identity manually.
> - For ABAC-enabled ACR registries (RBAC Registry + ABAC Repository Permissions), the AKS-to-ACR integration command isn't supported. Manually assign the `Container Registry Repository Reader` role to the kubelet managed identity at the appropriate registry or repository scope. For more information about ABAC permissions modes on Azure Container Registry, see [Azure Container Registry role-based access control](/azure/container-registry/container-registry-rbac-abac-repository-permissions).
>
> Otherwise, image pulls fail with `ImagePullBackOff` or `ErrImagePull`; inspect `kubectl describe pod` Events and use `az aks check-acr` to diagnose. For more information, see [Authenticate with Azure Container Registry from AKS](/azure/aks/cluster-container-registry-integration).

After running the migration command, kubelet on existing nodes continues using the service principal until you upgrade the node pool images. The node-pool upgrade cordons, drains, and reimages nodes, so plan the upgrade during a maintenance window and protect workloads with multiple replicas and PodDisruptionBudgets:

```bash
az aks nodepool upgrade --resource-group <rg> --cluster-name <cluster> --name <nodepool> --node-image-only
```

The node-image upgrade only takes effect when a newer node-image VHD is available in the cluster's region. If the node pool is already on the latest image, the command has no effect and kubelet continues to use the service principal until the next image release reaches the region. Per [AKS node images](/azure/aks/node-images#node-image-releases), Linux node images typically release weekly, Windows node images monthly, and regional rollout can take up to two weeks. (Note: another AKS doc page lists "up to a week" for regional rollout — the slower two-week figure is the safer planning assumption.) For more information, see [AKS managed-identity update considerations](/azure/aks/system-assigned-managed-identity#update-cluster-considerations) and [AKS node images](/azure/aks/node-images#node-image-releases).

AKS uses two primary managed identities:

- **Control-plane identity**. The AKS control plane uses this identity to manage resources such as ingress load balancers, managed public IP addresses, cluster autoscaler resources, and storage integrations.
- **Kubelet identity**. The kubelet uses this identity to authenticate to Azure Container Registry and other Azure resources needed by nodes. Some AKS add-ons also use managed identities.

When a cluster pulls images from Azure Container Registry, avoid storing registry credentials in Kubernetes `Secret` objects and referencing them with `imagePullSecrets`. Instead, assign the registry pull role to the kubelet managed identity at the smallest practical scope: `AcrPull` for non-ABAC registries, or `Container Registry Repository Reader` for ABAC-enabled registries.

Assign Azure role-based access control (Azure RBAC) permissions to managed identities at the smallest practical scope. Common assignments include [`Network Contributor`](/azure/role-based-access-control/built-in-roles/networking#network-contributor), [`Monitoring Metrics Publisher`](/azure/role-based-access-control/built-in-roles/monitor#monitoring-metrics-publisher), and [`AcrPull`](/azure/role-based-access-control/built-in-roles/containers#acrpull) for network resources, Azure Monitor metrics, and Azure Container Registry image pulls.

## Workload identity (pods to Azure services)

For applications in pods that need Azure service access, use Microsoft Entra Workload ID. It is generally available and uses federated OpenID Connect (OIDC) so Kubernetes service accounts can exchange projected service account tokens for Microsoft Entra ID tokens.

Use Microsoft Entra Workload ID with Azure Identity client libraries or Microsoft Authentication Library (MSAL) to avoid storing service principal secrets in Kubernetes and to align workload access with Microsoft Entra ID governance.

The older pod-managed identity model, implemented by the open-source `aad-pod-identity` project, was deprecated on October 24, 2022, and the project was archived in September 2023. The AKS-managed pod identity add-on was supported through September 2025 and has since retired. Don't use pod-managed identity for new workloads, and migrate existing workloads to Microsoft Entra Workload ID.

## Microsoft Entra ID integration with the AKS API server

Microsoft Entra ID integration covers outside-in access to the Kubernetes API server.

### Authentication (who you are)

Use AKS-managed Microsoft Entra ID integration for cluster authentication. Legacy Microsoft Entra integration has retired; migrate any remaining legacy clusters by running `az aks update --resource-group <rg> --name <cluster> --enable-aad --aad-admin-group-object-ids <entra-group-object-id>`, and then refresh kubeconfig.

A user runs `az aks get-credentials` to download or merge kubeconfig. On clusters running Kubernetes 1.24 or later, the `kubelogin` exec-plugin format is configured in the kubeconfig automatically, so no manual conversion is required for interactive Azure CLI sign-in. (The `kubelogin` binary itself must still be installed on the client; recent Azure CLI versions typically install or update it for you.) Explicit `kubelogin convert-kubeconfig` is needed for non-interactive scenarios such as CI pipelines, or for sign-in methods other than interactive Azure CLI, including service principal, managed identity, workload identity, and device code authentication. Device-code authentication doesn't work when Microsoft Entra Conditional Access policies apply; use web-browser interactive authentication in that scenario.

### Authorization (what you can do)

Authorization has two distinct layers.

**Azure RBAC layer (ARM)**. The `az aks get-credentials` command is an Azure Resource Manager operation against the AKS resource. Azure RBAC controls kubeconfig download. For example, `Azure Kubernetes Service Cluster User Role` allows user kubeconfig, and `Azure Kubernetes Service Cluster Admin Role` allows admin kubeconfig. For Microsoft Entra user credentials on Microsoft Entra-integrated clusters, a Cluster User kubeconfig download alone doesn't grant Kubernetes API permissions; Kubernetes API permissions are governed by Kubernetes RBAC or Azure RBAC for Kubernetes Authorization. By contrast, `--admin` cluster-admin credentials grant Kubernetes admin access, and on clusters that don't use Microsoft Entra ID, clusterUser credentials have admin-equivalent access.

**Kubernetes API authorization**. After kubeconfig is obtained and the user is authenticated, the Kubernetes API server evaluates the requested Kubernetes action. AKS supports two models:

- **Kubernetes RBAC**. Kubernetes RBAC is the native model. Define permissions with `Role` and `ClusterRole`, and grant them with `RoleBinding` and `ClusterRoleBinding`. Use Kubernetes RBAC for in-cluster service-account permissions, GitOps, or fine-grained permissions in Kubernetes manifests.
- **Azure RBAC for Kubernetes Authorization**. Assign Azure roles such as `Azure Kubernetes Service RBAC Reader`, `Azure Kubernetes Service RBAC Writer`, `Azure Kubernetes Service RBAC Admin`, or `Azure Kubernetes Service RBAC Cluster Admin` to Microsoft Entra ID users or groups. Use Azure RBAC for Kubernetes Authorization for centralized governance, Azure Activity Log audit, and Privileged Identity Management integration. Conditional Access is enforced separately at Microsoft Entra sign-in to the cluster control plane and applies to either Kubernetes RBAC or Azure RBAC for Kubernetes Authorization.

### Conditional Access

AKS clusters with Microsoft Entra ID integration can enforce Conditional Access during cluster sign-in, including multifactor authentication, device compliance, approved locations, or other conditions before a user accesses the control plane. Conditional Access requires a Microsoft Entra ID license that supports it.

## User and group assignment

Assign cluster-admin and user roles to Microsoft Entra ID groups instead of individual users, so membership changes don't require cluster changes.

Apply least privilege at the smallest effective scope. Grant cluster-wide administrator roles only when needed. For namespace-limited access, prefer namespace-scoped Azure RBAC for Kubernetes Authorization assignments or Kubernetes `RoleBinding` resources. A `RoleBinding` can reference either a namespaced `Role` or a reusable `ClusterRole`; use `ClusterRoleBinding` only when permissions must apply across the cluster.
