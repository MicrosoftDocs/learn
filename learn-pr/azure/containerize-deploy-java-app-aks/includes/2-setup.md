In this unit, you use the Azure CLI to create the Azure resources needed in later units. Before you start entering commands, make sure Docker Desktop or Docker Engine on Linux is installed and running.

The examples in this module use Bash syntax, including `export` and backslash line continuations. Use a local Bash session for the exercises. On Windows, use a WSL 2 Linux distribution with [Docker Desktop integration enabled](https://docs.docker.com/desktop/features/wsl/); install and use the Linux [Azure CLI](/cli/azure/install-azure-cli) and Git in that distribution. On macOS or Linux, use a local Bash session with access to your Docker daemon.

Azure Cloud Shell can run Azure management commands, but it [doesn't run a Docker daemon](/azure/container-registry/container-registry-authentication#use-az-acr-login-without-docker-daemon) and isn't a replacement for this module's local image-build and container-run steps. Native PowerShell and Command Prompt require different variable and line-continuation syntax.

From the Bash session you'll use for the exercises, check your tools before creating Azure resources:

```bash
git --version
az version
docker version
```

Confirm that all three commands succeed and that `docker version` shows a reachable `Server` as well as the client. If the server is unavailable, fix Docker Desktop, Docker Engine, or WSL integration before proceeding.

To save time, you can instruct Azure to provision the resources first and then move on to the next unit. Azure Kubernetes Service (AKS) cluster creation can take up to 10 minutes. This process can run in the background while you proceed through subsequent units.

## Authenticate with Azure Resource Manager

Use the following command to sign in:

```azurecli
az login
```

## Select an Azure subscription

Azure subscriptions are logical containers used to provision resources in Azure. Use the following command to list your Azure subscriptions, then locate the subscription ID - the `SubscriptionId` value - that you plan to use in this module.

```azurecli
az account list --output table
```

Use the following command to ensure you're using an Azure subscription that enables you to create resources for the purposes of this module, substituting your preferred `SubscriptionId` value for the placeholder:

```azurecli
az account set --subscription "<your-subscription-ID>"
```

## Define local variables

To simplify the commands that you use later, set up the following environment variables. Be sure to replace the following placeholders with your own values:

- Replace `<your-Azure-region>` with your region of choice - for example, `eastus`.
- Replace `<your-container-registry>` with a unique value. This value is used to generate a unique fully qualified domain name (FQDN) for your Azure container registry when it's created.
- Replace `<your-unique-DNS-prefix-to-access-your-AKS-cluster>` with a unique value. This value is used to generate a unique FQDN for your AKS cluster when it's created.

> [!NOTE]
> Azure container registry names must be globally unique across Azure and contain 5-50 alphanumeric characters (letters and numbers only). Hyphens and underscores aren't allowed. Replace `<your-container-registry>` with a compliant, available name before setting `AZ_CONTAINER_REGISTRY`. For more information, see [Container registry naming requirements](/azure/aks/cluster-container-registry-integration#create-a-new-acr).

```azurecli
export AZ_RESOURCE_GROUP=java-containerization-demo-rg
export AZ_CONTAINER_REGISTRY=<your-container-registry>
export AZ_KUBERNETES_CLUSTER=java-containerization-demo-aks
export AZ_LOCATION=<your-Azure-region>
export AZ_KUBERNETES_CLUSTER_DNS_PREFIX=<your-unique-DNS-prefix-to-access-your-AKS-cluster>
```

## Create an Azure resource group

Azure resource groups are Azure containers in Azure subscriptions for holding related resources for an Azure solution. Create a resource group by using the following command:

```azurecli
az group create \
    --name $AZ_RESOURCE_GROUP \
    --location $AZ_LOCATION \
| jq
```

> [!NOTE]
> This module uses the `jq` tool, which is installed by default on [Azure Cloud Shell](https://shell.azure.com/) to display JSON data and make it more readable.
>
> If you don't want to use the `jq` tool, you can safely remove the `| jq` part of all commands in this module.

## Create an Azure container registry

Azure Container Registry enables you to build, store, and manage container images, including a container image for this Java app. Create a container registry by using the following command:

```azurecli
az acr create \
    --resource-group $AZ_RESOURCE_GROUP \
    --name $AZ_CONTAINER_REGISTRY \
    --sku Basic \
    --role-assignment-mode rbac \
| jq
```

The `--role-assignment-mode rbac` option explicitly selects role-based access control (RBAC)-only permissions. This preserves the `--attach-acr` and `AcrPull` integration used in this exercise.

For any new or reused registry using **RBAC Registry + ABAC Repository Permissions**, which supports attribute-based access control (ABAC), `--attach-acr` isn't supported. The [ABAC-enabled integration workflow](/azure/aks/cluster-container-registry-integration) instead requires `Container Registry Repository Reader` for the kubelet identity and appropriate repository permissions for the publishing identity. Follow that workflow rather than running this exercise's integration commands unchanged. Microsoft [recommends ABAC-enabled mode](/azure/container-registry/container-registry-rbac-abac-repository-permissions); this exercise's RBAC-only setting isn't a recommendation to downgrade an existing ABAC-enabled registry.

Use the following command to configure the Azure CLI to use this newly created Azure container registry:

```azurecli
az configure --defaults acr=$AZ_CONTAINER_REGISTRY
```

Use the following command to authenticate to the newly created Azure container registry:

> [!NOTE]
> Before you run the `az acr login` command, ensure that Docker Desktop or Docker Engine on Linux is running and that its daemon is reachable from your Bash session. If it isn't reachable, you receive an error message similar to `Cannot connect to the Docker daemon at unix:///$HOME_DIR/.docker/run/docker.sock. Is the docker daemon running?`

```azurecli
az acr login --name $AZ_CONTAINER_REGISTRY
```

## Create an Azure Kubernetes Service cluster

You need an AKS cluster to deploy the Java app container image.

> [!IMPORTANT]
> The `--attach-acr` option assigns the `AcrPull` role to the AKS kubelet identity. In addition to permission to create the resources, your account needs `Microsoft.Authorization/roleAssignments/write` at the registry scope or an ancestor scope. [Contributor](/azure/role-based-access-control/built-in-roles/privileged#contributor) alone doesn't grant this permission. If necessary, ask your Azure administrator to perform the integration or grant appropriately scoped role-assignment access, such as [Role Based Access Control Administrator](/azure/role-based-access-control/built-in-roles/privileged#role-based-access-control-administrator) alongside the required resource-management permissions.

Create an AKS cluster by using the following command:

```azurecli
az aks create \
    --resource-group $AZ_RESOURCE_GROUP \
    --name $AZ_KUBERNETES_CLUSTER \
    --attach-acr $AZ_CONTAINER_REGISTRY \
    --dns-name-prefix=$AZ_KUBERNETES_CLUSTER_DNS_PREFIX \
    --generate-ssh-keys \
| jq
```

> [!NOTE]
> Creating an AKS cluster can take up to 10 minutes. After you run the previous command, you can let it continue in your Azure CLI tab and move on to the next unit.
