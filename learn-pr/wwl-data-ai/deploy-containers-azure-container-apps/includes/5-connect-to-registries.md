Production AI services often run images from private registries. A private registry helps you control supply chain risk, apply vulnerability scanning, and manage who can pull images. Azure Container Apps supports registry authentication through username and password and through managed identity when the registry is Azure Container Registry.

> [!NOTE]
> Registry configuration is separate from application configuration. If your app fails to start after a registry change, container logs often show image pull failures that look like authentication or permission errors.

## Understand registry options

When you configure a container app to pull from a private registry, you must provide credentials or an identity that can pull images. The simplest option is username and password, which is useful for quick validation and for registries that don't support Azure-managed identities. For Azure Container Registry, managed identity is often a better fit because it avoids storing long-lived credentials.

Your choice is a trade-off. Username and password works broadly, but it increases secret management overhead. Managed identity requires Azure role assignments, but it reduces the number of secrets your team must rotate.

## Configure a registry using username and password

You can configure registry settings on an existing app using `az containerapp registry set`. This command associates registry configuration with the container app so image pulls succeed for future revisions.

The following example configures a registry server and credentials.

```azurecli
az containerapp registry set -n ai-api -g rg-aca-demo \
    --server myregistry.azurecr.io \
    --username MyRegistryUsername \
    --password MyRegistryPassword
```

If you're using Azure Container Registry, Azure CLI can sometimes infer credentials if you omit them. You should still prefer an explicit authentication approach in production so behavior is predictable.

## Configure a registry using managed identity for Azure Container Registry

Managed identity is a good fit for production because it avoids username and password in deployment scripts. This is useful for AI systems where many services pull images, and rotating registry credentials across services becomes operationally expensive. With managed identity, you grant the identity the `AcrPull` role on the registry.

The following example configures the app to authenticate to the registry using a managed identity reference. Before you use this pattern, assign the identity and grant it pull permissions.

```azurecli
az containerapp registry set -n ai-api -g rg-aca-demo \
    --server myregistry.azurecr.io \
    --identity system
```

## Verify configured registries

When debugging image pull failures, it helps to confirm which registries are configured on the app. This is also useful when multiple registries exist across environments and you want to detect drift.

You can list and inspect registry configuration using the following commands.

```azurecli
az containerapp registry list -n ai-api -g rg-aca-demo
```

```azurecli
az containerapp registry show -n ai-api -g rg-aca-demo \
    --server myregistry.azurecr.io
```

## Best practices for registry authentication

Registry authentication affects both security and reliability. You can use the following practices to keep image pulls consistent and secure.

- **Prefer managed identity for Azure Container Registry:** Use `--identity` to reduce reliance on long-lived credentials.
- **Grant least privilege:** Assign only `AcrPull` to identities that pull images.
- **Keep image references consistent:** Use fully qualified image names, including the registry hostname, to avoid ambiguity.
- **Validate auth during rollout:** Deploy a new revision and verify the revision starts before you assume the registry change is correct.

## Additional resources

These resources help you verify the supported registry authentication options and understand the trade-offs for production deployments. Use the CLI reference to confirm the current parameters for registry configuration and managed identity support. Use the Azure Container Registry overview when you want more context on registry capabilities like role-based access control and image management.

- [Azure CLI: az containerapp registry](/cli/azure/containerapp/registry?view=azure-cli-latest)
- [Azure Container Registry overview](/azure/container-registry/container-registry-overview)
- [Azure Container Apps overview](/azure/container-apps/overview)
