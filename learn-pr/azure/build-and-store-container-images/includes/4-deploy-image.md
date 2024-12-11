You can pull container images from Azure Container Registry using various container management platforms, such as Azure Container Instances, Azure Kubernetes Service, or Docker for Windows or Mac. In this module, you deploy the image to an Azure Container Instance.

## Registry authentication

Azure Container Registry doesn't support unauthenticated access and requires authentication for all operations. Registries support two types of identities:

- **Microsoft Entra identities**, including both user and service principals. Access to a registry with a Microsoft Entra identity is role-based and you can assign identities one of three roles: **reader** (pull access only), **contributor** (push and pull access), or **owner** (pull, push, and assign roles to other users).
- The **admin account** included with each registry. The admin account is disabled by default.

> [!IMPORTANT]
> The admin account provides a quick option to try a new registry. You can enable the account and use the username and password in workflows and apps that need access. After you've confirmed the registry works as expected, you should disable the admin account and use Microsoft Entra identities to ensure the security of your registry. Do not share the admin account credentials with others.

## Enable the registry admin account

1. Enable the admin account on your registry using the `az acr update` command.

    ```azurecli-interactive
    az acr update -n $ACR_NAME --admin-enabled true
    ```

2. Retrieve the username and password for the admin account using the `az acr credential show` command.

    ```azurecli
    az acr credential show --name $ACR_NAME
    ```

3. Take note of the `username` and `password` values in the output for use in future commands.

## Deploy a container with Azure CLI

1. Deploy a container instance using the `az container create` command. Make sure you replace `<admin-username>` and `<admin-password>` with your admin username and password from the previous command.

    ```azurecli-interactive
    az container create --resource-group learn-acr-rg --name acr-tasks --image $ACR_NAME.azurecr.io/helloacrtasks:v1 --registry-login-server $ACR_NAME.azurecr.io --ip-address Public --location eastus --registry-username <admin-username> --registry-password <admin-password>
    ```

2. Get the IP address of the Azure container instance using the `az container show` command.

    ```azurecli-interactive
    az container show --resource-group learn-acr-rg --name acr-tasks --query ipAddress.ip --output table
    ```

3. In a separate browser tab, navigate to the IP address of the container. If everything is configured correctly, you should see the following web page:

    :::image type="content" source="../media/hello.png" alt-text="Screenshot of a browser window that shows a web page with text that reads: Hello World. Version: 9.11.2." loc-scope="other"::: <!-- no-loc -->
