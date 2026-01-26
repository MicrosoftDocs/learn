Deployment mechanics shape how reliably you can ship changes to an AI service. Azure Container Apps supports a fast, CLI-first workflow and a more controlled workflow where configuration is stored in YAML. This unit shows both approaches and explains when each one helps.

## Prepare Azure CLI for Container Apps

Before you deploy, you need an authenticated and up-to-date CLI. This reduces the chance of confusing errors during deployment, especially when the service adds or changes command options. You also need resource providers registered in the subscription so Azure can create Container Apps resources.

The following commands match the setup flow used in the Container Apps quickstart.

```azurecli
az login
az upgrade
az extension add --name containerapp --upgrade

az provider register --namespace Microsoft.App
az provider register --namespace Microsoft.OperationalInsights
```

## Deploy quickly with `az containerapp up`

The `az containerapp up` command is the fastest way to deploy an initial version of an app. It can create the environment and supporting resources for you, which reduces the number of decisions you must make up front. This is useful for prototypes or for the first deployment when you are still exploring the service.

The following example deploys a public container image and returns the fully qualified domain name (FQDN) for the app.

```azurecli
az containerapp up \
    --name my-container-app \
    --resource-group rg-aca-demo \
    --location centralus \
    --environment aca-env-demo \
    --image mcr.microsoft.com/k8se/quickstart:latest \
    --target-port 80 \
    --ingress external \
    --query properties.configuration.ingress.fqdn
```

If you use a container image reference, make sure the repository name is lower case. In practice, this means the image path portion (for example, `mcr.microsoft.com/k8se/quickstart`) should be lower case. This avoids image pull failures that can look like authentication errors.

## Deploy with `az containerapp create`

When you want a more explicit deployment, you can create the environment first and then use `az containerapp create`. This approach is useful when you must align the app to an existing environment and resource group. It also makes it easier to introduce consistent defaults across environments.

The following example shows a simple create flow. In later units, you add environment variables, secrets, and registry authentication.

```azurecli
az containerapp create \
    --name ai-api \
    --resource-group rg-aca-demo \
    --environment aca-env-demo \
    --image mcr.microsoft.com/k8se/quickstart:latest \
    --ingress external \
    --target-port 80
```

## Update an app by creating a new revision

Container Apps uses revisions to version configuration changes. When you update an app, you usually create a new revision that represents the new configuration, such as a new image tag or new environment variables. This revision model matters for AI services because you can validate a new revision before shifting all traffic.

The following example updates only the image. In practice, you often combine image updates with configuration updates.

```azurecli
az containerapp update \
    --name ai-api \
    --resource-group rg-aca-demo \
    --image myregistry.azurecr.io/ai-api:v2
```

## Use YAML for consistent, reviewable deployments

YAML-based configuration helps you make deployments repeatable and reviewable. You can store the YAML file in source control and apply changes through code review, which reduces configuration drift across environments. This approach is especially helpful when your AI service has many settings, such as feature flags, dependency endpoints, and scaling configuration.

Azure CLI supports creating and updating a container app using YAML. When you use `--yaml`, other flags are ignored, so the YAML becomes the source of truth.

```azurecli
az containerapp create \
    --name ai-api \
    --resource-group rg-aca-demo \
    --environment aca-env-demo \
    --yaml ./containerapp.yml
```

```azurecli
az containerapp update \
    --name ai-api \
    --resource-group rg-aca-demo \
    --yaml ./containerapp.yml
```

## Be aware of other deployment options

In real projects, you often move from CLI-first deployment to more structured deployment pipelines. Azure Container Apps supports multiple approaches, and you should choose one based on team workflow and compliance requirements. For example, you can use Bicep for infrastructure as code, GitHub Actions for continuous deployment, or the Azure portal for ad hoc changes.

Even when you use these other approaches, the CLI and YAML patterns in this unit remain useful. They help you understand which properties change when you deploy and where to look when troubleshooting.

## Additional resources

These resources reinforce how Container Apps deployments work as you move from a first deployment to a repeatable, reviewable workflow. Use the quickstart to compare a minimal deployment to the patterns in this unit. Use the CLI reference to confirm the current flags and to understand how updates create new revisions.

- [Quickstart: Deploy your first container app](/azure/container-apps/get-started)
- [Azure CLI: az containerapp](/cli/azure/containerapp?view=azure-cli-latest)
- [Revisions in Azure Container Apps](/azure/container-apps/revisions)
