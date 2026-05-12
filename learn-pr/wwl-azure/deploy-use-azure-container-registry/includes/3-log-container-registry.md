Use this Try-This exercise to gain some hands-on experience with Azure Container Registry.

Before pushing and pulling container images, you must sign in to Azure and then sign in to the registry instance. [Sign in to the Azure CLI](/cli/azure/get-started-with-azure-cli) on your local machine by using `az login`, then run the [az acr login](/cli/azure/acr#az-acr-login) command. Specify only the registry resource name when signing in with the Azure CLI.

> [!NOTE]
> Don't use the fully qualified login server name, such as `newregistryapl.azurecr.io` or `newregistryapl-<hash>.azurecr.io`, with `az acr login --name`. Use the registry resource name, such as `newregistryapl`.

> [!IMPORTANT]
> Use a local terminal for this module's standard Docker workflow. You need the Azure CLI, Docker CLI, and Docker daemon running locally. Azure Cloud Shell isn't suitable because it doesn't run the Docker daemon.
> Although `az acr login --expose-token` is available for environments without a Docker daemon, such as Azure Cloud Shell or scripts, this module's standard Docker workflow still requires a local Docker CLI and daemon.

> [!NOTE]
> To complete this procedure, you need an [Azure subscription](https://azure.microsoft.com/pricing/purchase-options/azure-account?cid=msft_learn).

Sign in to the Azure CLI on your local machine by running the `az login` command.

```azurecli
az login
```

Follow the browser or device-code sign-in prompts. When sign-in completes, the Azure CLI either presents an interactive subscription selector (default subscription marked with `*`) or prints a list of your subscriptions (default marked with `isDefault: true`), depending on your CLI version and configuration. Use `az account show` to confirm the active subscription.

If you have access to multiple Azure subscriptions, verify that the Azure CLI is using the subscription that contains your registry.

```azurecli
az account show --query "{Name:name, SubscriptionId:id}" --output table
```

To change the active subscription, run:

```azurecli
az account set --subscription "<subscription-id-or-name>"
```

After repository roles are assigned, Azure role assignment changes can take up to 10 minutes to take effect. If `az acr login` fails with a 401 or 403 error shortly after assignment, wait and retry. If needed, sign out and in again to refresh your Azure CLI credentials.

Sign in to the registry using the registry resource name.

```azurecli
az acr login --name <registry-name>
```

Example:

```azurecli
az acr login --name newregistryapl
```

The command returns `Login Succeeded` when it completes.
