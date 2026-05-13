Azure Container Registry (ACR) provides the image storage layer for your container workloads. Securing the registry means controlling who can push, pull, and manage images; isolating registry traffic from the public internet; and ensuring that images arriving in the registry come from sources you trust. The controls in this unit cover registry access and network security — vulnerability scanning for stored images is provided by Defender for Containers, which is covered in a previous module in this learning path.

## Disable the admin account

Azure Container Registry includes a built-in admin account designed for early registry exploration and simple deployment scenarios. The admin account provides a username and two rotating passwords that authenticate to the registry with full push and pull access. It isn't linked to a Microsoft Entra ID identity, so actions taken with it aren't auditable to an individual person or workload.

In production, the admin account creates two specific risks. Because a single set of credentials covers the entire registry, any developer, pipeline, or application that knows the password has the same level of access — there's no way to grant someone only the ability to pull images. And if credentials are compromised, you can't trace which workload was using them to understand the blast radius.

Disable the admin account on production registries. In the Azure portal, open your registry, select **Access keys** under **Settings**, and set **Admin user** to **Disabled**. With the admin account disabled, all authentication must use Microsoft Entra ID-based identities, which enables role-based access control and per-identity audit logging.

```azurecli
az acr update --name <registry-name> --admin-enabled false
```

> [!IMPORTANT]
> If your Container Apps or Container Instances workloads currently authenticate to ACR using the admin account, configure managed identity authentication before you disable it. Disabling the account while workloads still depend on it causes image pull failures.

## Assign RBAC roles to control registry access

With the admin account disabled, all registry authentication uses Microsoft Entra identities — users, service principals, and managed identities. Azure Container Registry provides purpose-built RBAC roles that map to common registry operations:

| Role | Operations | Typical assignment |
|---|---|---|
| AcrPull | Pull images and artifacts | Container Apps, AKS node pools, application workloads |
| AcrPush | Push and pull images and artifacts | CI/CD pipelines, developer workstations |
| AcrDelete | Delete images and artifacts | Lifecycle management automation |
| AcrImageSigner | Sign images with Docker Content Trust | Supply chain security pipelines |
| Contributor | Manage the registry resource and configuration | Platform engineers |

Assign roles at the registry scope for most scenarios. Apply the principle of least privilege: an AKS cluster that pulls images needs `AcrPull`, not `Contributor`. A CI/CD pipeline that builds and pushes images needs `AcrPush`, not `Contributor`. Assigning `Contributor` to workloads that only need to pull images grants unnecessary write and management access.

To assign the `AcrPull` role to a managed identity:

```azurecli
az role assignment create \
  --assignee <managed-identity-principal-id> \
  --role AcrPull \
  --scope /subscriptions/<subscription-id>/resourceGroups/<rg>/providers/Microsoft.ContainerRegistry/registries/<registry-name>
```

Registries that have ABAC (attribute-based access control) repository permissions enabled support newer repository-scoped roles such as `Container Registry Repository Reader` and `Container Registry Repository Writer`. These roles support Microsoft Entra ABAC conditions that let you scope a role assignment to one or more specific repositories in the registry, which is useful in multi-team environments.

## Create scope map tokens for least-privilege pipeline access

RBAC roles apply across the entire registry. When a CI/CD pipeline needs to push images only to a specific repository — such as `contoso-retail/checkout-service` — a registry-scoped `AcrPush` assignment grants more access than necessary.

Scope maps let you define a named set of repository-level permissions, then issue a token bound to that scope map. The token can push, pull, or delete objects only in the repositories you specify. Multiple teams can share a single registry while each team's pipeline is restricted to its own repository namespace.

To create a scope map and a token for a single repository:

```azurecli
az acr scope-map create \
  --name checkout-pipeline-scope \
  --registry <registry-name> \
  --repository contoso-retail/checkout-service content/write content/read

az acr token create \
  --name checkout-pipeline-token \
  --registry <registry-name> \
  --scope-map checkout-pipeline-scope
```

> [!NOTE]
> Scope map tokens use username and password authentication rather than Microsoft Entra ID. They don't support Azure RBAC or Privileged Identity Management. Rotate token passwords regularly and store them in Azure Key Vault — don't commit them to source control.

## Isolate registry traffic with a private endpoint

By default, Azure Container Registry accepts connections from any IP address over the public internet. Configuring a private endpoint assigns the registry a private IP address in your virtual network and routes all registry traffic over the Azure backbone. When you also disable public network access, the registry is no longer reachable from outside your VNet.

Private endpoints are required when your container workloads run in a private network. An AKS cluster with a private API server, or Container Instances deployed into a VNet subnet, need a path to the registry that stays within Azure's private network backbone. Without a private endpoint, those workloads reach your registry over the public internet even though both the workload and the registry are hosted in Azure.

Private endpoints require the Premium SKU.

```azurecli
az network private-endpoint create \
  --name acr-private-endpoint \
  --resource-group <rg> \
  --vnet-name <vnet-name> \
  --subnet <subnet-name> \
  --private-connection-resource-id /subscriptions/<subscription-id>/resourceGroups/<rg>/providers/Microsoft.ContainerRegistry/registries/<registry-name> \
  --group-id registry \
  --connection-name acr-connection

az acr update --name <registry-name> --public-network-enabled false
```

## Restrict access with network firewall rules

If a private endpoint isn't available — for example, when using the Basic or Standard SKU, or when external callers outside your VNet need registry access — configure IP-based firewall rules to limit which source IP addresses or CIDR ranges can reach the registry.

Network firewall rules on ACR function as an allowlist. Under **Networking** in the Azure portal, configure individual IP addresses or ranges under **Firewall rules**, and set **Default action** to **Deny** to block all traffic except explicit allow entries:

```azurecli
az acr network-rule add \
  --name <registry-name> \
  --ip-address <allowed-ip-or-cidr>
```

IP firewall rules don't provide the same isolation guarantees as a private endpoint. The registry retains its public hostname, and traffic still reaches the Azure network boundary over the internet before being evaluated by the firewall rules. Use private endpoints for workloads that require strict network isolation.

## Enable content trust for image signing

Content trust lets you require that images are cryptographically signed before they're pushed to the registry, and lets consumers verify those signatures before pulling. Verified signatures confirm that an image came from a trusted source and hasn't been modified since it was signed.

Azure Container Registry implements content trust using Docker Content Trust (DCT), built on the Notary v1 framework. Enable it at the registry level:

```azurecli
az acr config content-trust update \
  --registry <registry-name> \
  --status enabled
```

When content trust is enabled, unsigned image pushes fail. Publishers sign images using the `DOCKER_CONTENT_TRUST=1` environment variable along with a signing key. Content trust provides the foundation for supply chain security: only images with a valid signature from an authorized identity can be stored in the registry.
