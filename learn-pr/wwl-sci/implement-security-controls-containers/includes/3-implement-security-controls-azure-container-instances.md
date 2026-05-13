Azure Container Instances (ACI) run containerized workloads without requiring you to manage the underlying infrastructure. This simplicity can obscure the security controls you're responsible for: how the container authenticates to other Azure services, how it receives sensitive configuration, whether it's reachable from the public internet, and what its running process can do on the host. This unit closes the gap between a default ACI deployment and one that meets enterprise security requirements.

## Assign managed identities to container groups

A managed identity is a Microsoft Entra ID identity that Azure manages automatically — you don't create or rotate credentials for it. Container groups support both system-assigned identities (created with the group and deleted when it's deleted) and user-assigned identities (exist independently and can be shared across resources).

With a managed identity, the container can authenticate to Azure Key Vault, Azure Container Registry, Azure Storage, and any other Azure service that supports Microsoft Entra authentication, without storing credentials in the container configuration.

Assign a system-assigned identity when you create the container group:

```azurecli
az container create \
  --resource-group <rg> \
  --name <container-group-name> \
  --image <image-name> \
  --assign-identity
```

After the identity is assigned, grant it the RBAC roles it needs — for example, `Key Vault Secrets User` to read secrets from Key Vault, or `AcrPull` to pull images from a private container registry.

## Reference Key Vault secrets instead of plain-text environment variables

The most common credential security gap in Container Instances deployments is passing sensitive configuration — database connection strings, API keys, storage account credentials — as plain-text environment variables. Plain-text values appear in the deployment history, in container group metadata visible to anyone with Reader access to the resource, and in source control if the template is committed.

The secure alternative is to store secrets in Azure Key Vault and reference them by secret URI in the container group definition. With a managed identity assigned and the `Key Vault Secrets User` role granted, the container group retrieves the secret value at runtime without the value appearing in the deployment manifest.

In a Bicep template, reference a Key Vault secret using `secureValue`:

```bicep
environmentVariables: [
  {
    name: 'DB_CONNECTION_STRING'
    secureValue: keyVaultRef.getSecret('db-connection-string')
  }
]
```

> [!IMPORTANT]
> Use `secureValue` instead of `value` for any environment variable that contains sensitive data. Values set as `secureValue` are encrypted at rest and not returned in GET operations on the container group — they don't appear in the Azure portal, CLI output, or API responses.

## Deploy containers into a virtual network

By default, Container Instances receive a public IP address and are reachable from the internet. VNet integration removes public network exposure by deploying the container group into a subnet of an existing virtual network. The containers receive private IP addresses and aren't reachable from outside the VNet.

To deploy into a VNet, first delegate a subnet to `Microsoft.ContainerInstance/containerGroups`:

```azurecli
az network vnet subnet update \
  --resource-group <rg> \
  --vnet-name <vnet-name> \
  --name <subnet-name> \
  --delegations Microsoft.ContainerInstance/containerGroups
```

Then create the container group specifying the VNet and subnet:

```azurecli
az container create \
  --resource-group <rg> \
  --name <container-group-name> \
  --image <image-name> \
  --vnet <vnet-name> \
  --subnet <subnet-name>
```

VNet-deployed container groups can reach private endpoints — including a private ACR endpoint and a private Key Vault endpoint — without routing traffic over the public internet. This is the recommended network configuration for container workloads that handle sensitive data.

> [!NOTE]
> Not all Container Instances features are available in VNet deployments. Review the [VNet scenarios and resources](/azure/container-instances/container-instances-vnet) documentation for current limitations before you design around this configuration.

## Apply container-level security context settings

Container Instances support security context settings that limit what a container process can do on its host. Two controls are particularly useful for hardening workloads.

**Run as non-root**: By default, container processes run as root (user ID 0) unless the container image specifies otherwise. Configure `runAsUser` and `runAsGroup` in the container security context to run the process as a non-privileged user. If an attacker finds an escape from the container, they operate with limited OS-level privileges rather than full root access.

**Read-only root filesystem**: Setting `readOnlyRootFilesystem: true` prevents the container process from writing to the container's root filesystem. Any writes must go through explicitly configured `emptyDir` volumes. This prevents an attacker from modifying binaries or configuration files on the container filesystem.

```yaml
securityContext:
  runAsUser: 1000
  runAsGroup: 3000
  readOnlyRootFilesystem: true
```

Apply both settings for production workloads. If your application writes logs or temporary files, mount an `emptyDir` volume for those paths before enabling the read-only root filesystem.

## Pull images from ACR using managed identity

Container Instances that pull images from a private Azure Container Registry need a way to authenticate. Storing the ACR admin account credentials as secrets in the container group configuration creates the same shared credential problem as using the admin account directly — any workload with access to the secret can authenticate as that shared identity.

The correct approach is to assign the container group's managed identity the `AcrPull` role on the registry, then reference that identity as the image pull identity:

```azurecli
az role assignment create \
  --assignee <managed-identity-principal-id> \
  --role AcrPull \
  --scope /subscriptions/<subscription-id>/resourceGroups/<rg>/providers/Microsoft.ContainerRegistry/registries/<registry-name>

az container create \
  --resource-group <rg> \
  --name <container-group-name> \
  --image <registry-name>.azurecr.io/<image-name>:<tag> \
  --assign-identity <identity-resource-id> \
  --acr-identity <identity-resource-id>
```

This approach eliminates stored credentials entirely. The container group authenticates to ACR using its managed identity token, which Azure rotates automatically. Combined with disabling the ACR admin account, this closes the shared credential gap for the image pull path.
