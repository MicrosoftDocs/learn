In this unit, you create an Azure Key Vault and service principal, then deploy the container to Azure Container Instances (ACI) using the service principal's credentials.

## Configure registry authentication

All production scenarios should use service principals to access an Azure container registry. Service principals allow you to provide role-based access control to your container images. For example, you can configure a service principal with pull-only access to a registry.

If you don't already have a vault in Azure Key Vault, create one with the Azure CLI using the following commands.

First set up some environment variables. These variables are used throughout several commands in this unit.

```azurecli
ACR_NAME=<acrName>
RES_GROUP=<resourGroupName>
AKV_NAME=$ACR_NAME-vault
```

Create an Azure Key Vault with the `az keyvault create` command.

```azurecli
az keyvault create --resource-group $RES_GROUP --name $AKV_NAME
```

You now need to create a service principal and store its credentials in your key vault.

Use the `az ad sp create-for-rbac` command to create the service principal, and `az keyvault secret set` to store the service principal's **password** in the vault:

```azurecli-interactive
az keyvault secret set \
  --vault-name $AKV_NAME \
  --name $ACR_NAME-pull-pwd \
  --value $(az ad sp create-for-rbac \
                --name $ACR_NAME-pull \
                --scopes $(az acr show --name $ACR_NAME --query id --output tsv) \
                --role reader \
                --query password \
                --output tsv)
```

The `--role` argument in the preceding command configures the service principal with the *reader* role, which grants it pull-only access to the registry. To grant both push and pull access, change the `--role` argument to *contributor*.

Next, store the service principal's *appId* in the vault, which is the **username** you pass to Azure Container Registry for authentication:

```azurecli-interactive
az keyvault secret set \
    --vault-name $AKV_NAME \
    --name $ACR_NAME-pull-usr \
    --value $(az ad sp show --id http://$ACR_NAME-pull --query appId --output tsv)
```

You've created an Azure Key Vault and stored two secrets in it:

* `$ACR_NAME-pull-usr`: The service principal ID, for use as the container registry **username**.
* `$ACR_NAME-pull-pwd`: The service principal password, for use as the container registry **password**.

You can now reference these secrets by name when you or your applications and services pull images from the registry.

### Deploy container with Azure CLI

Now that the service principal credentials are stored as Azure Key Vault secrets, your applications and services can use them to access your private registry.

Execute the following `az container create` command to deploy a container instance. The command uses the service principal's credentials stored in Azure Key Vault to authenticate to your container registry.

```azurecli-interactive
az container create \
    --resource-group $RES_GROUP \
    --name acr-build \
    --image $ACR_NAME.azurecr.io/helloacrbuild:v1 \
    --registry-login-server myacr0007.azurecr.io \
    --registry-username $(az keyvault secret show --vault-name $AKV_NAME --name $ACR_NAME-pull-usr --query value -o tsv) \
    --registry-password $(az keyvault secret show --vault-name $AKV_NAME --name $ACR_NAME-pull-pwd --query value -o tsv)
```