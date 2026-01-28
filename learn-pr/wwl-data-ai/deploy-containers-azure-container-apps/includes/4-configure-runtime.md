AI services often depend on external systems and require many runtime settings. You typically configure endpoints, feature flags, and model selection settings using environment variables. You handle sensitive settings, such as API keys, using secrets and secret references.

## Configure nonsensitive settings with environment variables

Environment variables are a good fit for non-sensitive configuration like log levels, feature flags, and dependency URLs. This approach keeps container images portable across environments because you can run the same image with different configuration values. For AI workloads, environment variables also help you tune behavior such as request timeouts and batch sizes without rebuilding images.

You can set environment variables during create, or you can add them later. The following example uses `--env-vars` during create.

```azurecli
az containerapp create -n ai-api -g rg-aca-demo \
    --environment aca-env-demo \
    --image myregistry.azurecr.io/ai-api:v1 \
    --ingress external --target-port 8000 \
    --env-vars LOG_LEVEL=info FEATURE_EMBEDDINGS=true
```

If you want to add or update variables without removing existing ones, you can use `--set-env-vars` during an update.

```azurecli
az containerapp update -n ai-api -g rg-aca-demo \
    --set-env-vars LOG_LEVEL=debug
```

## Store sensitive settings as Container Apps secrets

Secrets let you keep sensitive values out of container images and out of source control. Protecting sensitive values matters for AI services because provider API keys, database credentials, and signing keys rotate regularly. By storing secrets separately, you can rotate secrets without rebuilding or redeploying the image.

You can create or update secrets using `az containerapp secret set`. Secrets are provided as `key=value` pairs.

```azurecli
az containerapp secret set -n ai-api -g rg-aca-demo \
    --secrets embeddings-api-key="REPLACE_WITH_REAL_VALUE"
```

If you need to reference Azure Key Vault, the CLI also supports a Key Vault reference format for secrets. You use this approach when you want Key Vault to be the system of record and you want your container app to fetch the secret at runtime.

## Reference secrets from environment variables

Most application frameworks read configuration from environment variables. Container Apps supports secret references so you can map a secret to an environment variable without exposing the value, which is a common pattern for AI apps that call external model endpoints.

You reference a secret by setting the environment variable value to `secretref:<secret-name>`. The following example sets `EMBEDDINGS_API_KEY` to the secret value.

```azurecli
az containerapp update -n ai-api -g rg-aca-demo \
    --set-env-vars EMBEDDINGS_API_KEY=secretref:embeddings-api-key
```

## Use YAML to standardize runtime configuration

YAML-based configuration is useful when you want a single, reviewable source of truth for runtime settings. This is especially important for AI services where small configuration changes can affect cost, latency, and data flow. A YAML file also becomes a stable artifact for CI and CD pipelines.

The following example shows a focused YAML fragment that sets one non-sensitive environment variable and one secret reference. You should keep secret values out of YAML files and store only secret names in source control.

```yaml
# Code fragment - focus on environment variables and secret references
properties:
  template:
    containers:
    - name: ai-api
      env:
      - name: LOG_LEVEL
        value: info
      - name: EMBEDDINGS_API_KEY
        secretRef: embeddings-api-key
```

After you update the YAML file, you can apply it with `az containerapp update --yaml`. This command treats the YAML file as the full configuration source.

```azurecli
az containerapp update -n ai-api -g rg-aca-demo \
    --yaml ./containerapp.yml
```

## Best practices for runtime configuration

Runtime configuration should reduce risk and simplify operations. You can use the following practices to keep configuration manageable as your AI solution grows.

- **Separate config from images:** Use environment variables and secrets so the same image can run across multiple environments.
- **Prefer secret references:** Use `secretref:` and `secretRef` so secret values don't appear in YAML files or shell history.
- **Rotate secrets intentionally:** Update secrets independently of images so you can respond quickly to credential rotation requirements.
- **Use YAML for consistency:** Store YAML in source control to reduce drift and make configuration changes reviewable.

## Additional resources

These resources provide deeper reference material for how Container Apps stores secrets and projects them into your containers at runtime. Use the CLI reference for `az containerapp secret` when you need the exact supported secret formats, including Key Vault references and identity requirements. Use the secrets management article for operational guidance on updates and rotation.

- [Azure CLI: az containerapp secret](/cli/azure/containerapp/secret)
- [Azure CLI: az containerapp](/cli/azure/containerapp)
- [Manage secrets in Azure Container Apps](/azure/container-apps/manage-secrets)
