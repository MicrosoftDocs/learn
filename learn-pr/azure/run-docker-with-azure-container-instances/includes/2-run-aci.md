Create a container in Azure and expose it to the Internet with a fully qualified domain name (FQDN).

[!include[](../../../includes/azure-exercise-subscription-prerequisite.md)]

## Why use Azure Container Instances?

Azure Container Instances is useful for scenarios that can operate in isolated containers, including simple applications, task automation, and build jobs. Here are some of the benefits:

- **Fast startup**: Launch containers in seconds.
- **Per second billing**: Incur costs only while the container is running.
- **Hypervisor-level security**: Isolate your application as completely as it would be in a VM.
- **Custom sizes**: Specify exact values for CPU cores and memory.
- **Persistent storage**: Mount Azure Files shares directly to a container to retrieve and persist state.
- **Linux and Windows**: Schedule both Windows and Linux containers using the same API.

For scenarios where you need full container orchestration, including service discovery across multiple containers, automatic scaling, and coordinated application upgrades, we recommend Azure Kubernetes Service (AKS).

## Create a container

1. Sign in to the [Azure portal](https://portal.azure.com/?azure-portal=true) with your Azure subscription.

1. Open Azure Cloud Shell from the Azure portal by selecting the Cloud Shell icon. Make sure to select **Bash** as the interactive Cloud Shell environment.

    :::image type="icon" source="../media/2-portal-cloudshell-access.png":::

1. Create a new resource group with the name **learn-deploy-aci-rg** so that it's easier to clean up these resources when you're finished with the module. If you choose a different resource group name, remember it for the rest of the exercises in this module. You also need to choose a region in which you want to create the resource group; for example, **East US**.

    ```azurecli
    az group create --name learn-deploy-aci-rg --location eastus
    ```

    Create a container by providing a name, a Docker image, and an Azure resource group to the `az container create` command. You can optionally expose the container to the Internet by specifying a DNS name label. In this example, deploy a container that hosts a small web app. You can also select the location to place the image; we use the **East US** region, but you can change it to a location close to you.

1. Provide a DNS name to expose your container to the Internet. Your DNS name must be unique. For learning purposes, run this command from Cloud Shell to create a Bash variable that holds a unique name:

    ```azurecli
    DNS_NAME_LABEL=aci-demo-$RANDOM
    ```

1. Run the following `az container create` command to start a container instance:

    ```azurecli
    az container create \
      --resource-group learn-deploy-aci-rg \
      --name mycontainer \
      --image mcr.microsoft.com/azuredocs/aci-helloworld \
      --ports 80 \
      --dns-name-label $DNS_NAME_LABEL \
      --location eastus
    ```

    `$DNS_NAME_LABEL` specifies your DNS name. The image name, **azuredocs/aci-helloworld**, refers to a container image hosted on Microsoft Container Registry that runs a basic Node.js web application.

1. When the `az container create` command completes, run `az container show` to check its status:

    ```azurecli
    az container show \
      --resource-group learn-deploy-aci-rg \
      --name mycontainer \
      --query "{FQDN:ipAddress.fqdn,ProvisioningState:provisioningState}" \
      --output table
    ```

    You get your container's fully qualified domain name (FQDN) and its provisioning state. Here's an example:

    ```output
    FQDN                                    ProvisioningState
    --------------------------------------  -------------------
    aci-demo-0000.eastus.azurecontainer.io  Succeeded
    ````

    If your container is in the **Creating** state, wait a few moments, and run the command again until you see the **Succeeded** state.

1. From a browser, go to your container's FQDN to see it running. Ensure you enter the *http://* prefix in front of the *aci-demo...* string. You should get this welcome page:

    :::image type="content" source="../media/2-browser.png" alt-text="Screenshot of the sample Node.js container app running in a browser." loc-scope="other"::: <!-- no-loc -->

## Summary

Here, you created an Azure container instance to run a web server and application. You also accessed this application using the FQDN of the container instance.
