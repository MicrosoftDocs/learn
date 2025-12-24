You can pull container images from Azure Container Registry using various container management platforms, such as Azure Container Instances, Azure Kubernetes Service, or Docker for Windows or Mac. In this module, you deploy the image to an Azure Container Instance.

## Registry authentication

Azure Container Registry doesn't support unauthenticated access and requires authentication for all operations. Registries support two types of identities:

- **Microsoft Entra identities**, including both user and service principals. Access to a registry with a Microsoft Entra identity is role-based, and you can assign identities using one of three roles: _Reader_ (pull access only), _Contributor_ (push and pull access), or _Owner_ (pull, push, and assign roles to other users).
- The **admin account** included with each registry. The admin account is disabled by default.

> [!IMPORTANT]
> The admin account provides a quick option to try a new registry. You can enable the account and use the username and password in workflows and apps that need access. After you confirmed the registry works as expected, you should disable the admin account and use Microsoft Entra identities to ensure the security of your registry. Don't share the admin account credentials with others.

## Enable the registry admin account

1. Enable the admin account on your registry using the `az acr update` command.

    ```azurecli
    az acr update --name $ACR_NAME --admin-enabled true
    ```

1. Retrieve the username and password for the admin account using the `az acr credential show` command. The values are stored in the `ACR_USERNAME` and `ACR_PASSWORD` variables for use in the next section.

   ```azurecli
   ACR_USERNAME=$(az acr credential show --name $ACR_NAME --query username --output tsv)
   ACR_PASSWORD=$(az acr credential show --name $ACR_NAME --query passwords[0].value --output tsv)
   ```

## Deploy a container with Azure CLI

1. Deploy a container instance using the `az container create` command. The command uses the `ACR_USERNAME` and `ACR_PASSWORD` variables for registry authentication.

    ```azurecli
    az container create \
      --resource-group learn-acr-rg \
      --name acr-tasks \
      --image $ACR_NAME.azurecr.io/helloacrtasks:v1 \
      --registry-login-server $ACR_NAME.azurecr.io \
      --ip-address Public \
      --location eastus \
      --registry-username $ACR_USERNAME \
      --registry-password $ACR_PASSWORD \
      --os-type Linux \
      --cpu 1 \
      --memory 1
    ```

1. Get the IP address of the Azure container instance using the `az container show` command.

    ```azurecli
    az container show \
      --resource-group learn-acr-rg \
      --name acr-tasks \
      --query ipAddress.ip \
      --output table
    ```

1. In a separate browser tab, navigate to the IP address of the container. If everything is configured correctly, you should see the following web page:

   ```output
   Hello World
   Version: 25.2.1
   ```

   Port 80 is used so the web page address is `http://<IP_ADDRESS>`.

## Disable the registry admin account

After you verify the container instance works as expected, disable the registry admin account to secure your registry.

```azurecli
az acr update --name $ACR_NAME --admin-enabled false
```
