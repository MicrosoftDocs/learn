Azure Container Instance enables you to run a Docker image in Azure.

You previously packaged and tested your web app as a local Docker image. You now want to make the web application available globally. So, you decide to run the image as an Azure Container Instance.

In this exercise, you'll rebuild the image for the web app and upload it to Azure Container Registry. You'll use the Azure Container Instance service to run the image.

[!include[](../../../includes/azure-exercise-subscription-prerequisite.md)]

## Create a container registry

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) with your Azure subscription.

1. On the Azure portal menu or from the **Home** page, under **Azure services**, select **Create a resource**. The **Create a resource** pane appears.

1. In the left menu pane, select **Containers**, and then select **Container Registry** from *Popular services*.

    :::image type="content" source="../media/7-search-container-registry.png" alt-text="Screenshot that shows the New pane in Azure portal showing the Container options available in Azure Marketplace.":::

    The **Create container registry** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting  | Value  |
    |---|---|
    | **Project details** |
    | Subscription | Select your default Azure subscription in which you are allowed to create and manage resources. |
    | Resource group | Create a new resource group with the name **learn-deploy-container-aci-rg** so that it will be easier to clean up these resources when you're finished with the module. If you choose a different resource group name, remember it for the rest of the exercises in this module. |
    | **Instance details** |
    | Registry name | Select a name of your choice. The registry name must be unique within Azure, and contain 5-50 alphanumeric characters. |
    | Location | Select a location that is close to you. |
    | SKU | **Standard** |

1. Select **Review + create**. When the *Validation passed* notification appears, select **Create**. Wait until the container registry has been deployed before continuing.

1. Select **Go to resource**. Your *container registry* pane appears.

1. In the left menu bar, under **Settings**, select **Access keys**.

1. Make a note of the **Registry name**, **Login server**, **Username**, and **passwords** for your registry. For **Admin user**, select **Enabled**.

    > [!NOTE]
    > In this exercise, we enable the admin account for uploading images and testing the registry. In a production environment, you should disable the admin account, and switch to Azure Active Directory Identities after you're satisfied that the registry is operating as expected.

    :::image type="content" source="../media/7-access-keys.png" alt-text="Screenshot that shows the Access Key information for the registry.":::

## Upload the image for the hotel reservation system app to Azure Container Registry

1. In your local command line, run the following command to tag the `reservationsystem` image with the name of your registry. Replace `<registry-name>` with the name of your registry in Azure Container Registry.

    ```bash
    docker tag reservationsystem:latest <registry-name>.azurecr.io/reservationsystem:latest
    ```

2. Run the `docker image ls` command to verify that the image has been tagged correctly.

    ```bash
    docker image ls
    ```

    The output of the command should look similar to this.

    ```console
    REPOSITORY                                    TAG                 IMAGE ID            CREATED             SIZE
    reservationsystem                             latest              a56281e7038f        4 minutes ago       1.76GB
    <registry-name>.azurecr.io/reservationsystem  latest              a56281e7038f        4 minutes ago       1.76GB
    microsoft/dotnet                              2.1-sdk             ff665cc04279        14 hours ago        1.73GB
    ```

3. Sign in to your registry in Azure Container Registry. Use the `docker login` command and specify the login server for the registry that you noted earlier. Enter the username and password for the registry when prompted.

    ```bash
    docker login <login-server>
    ```

4. Upload the image to the registry in Azure Container Registry with the `docker push` command.

    ```bash
    docker push <registry-name>.azurecr.io/reservationsystem:latest
    ```

    Wait while this command completes. It will take a couple of minutes.

## Verify the contents of the registry

For the rest of the exercise, you'll return to the Azure portal.

1. In the Azure portal, return to your container registry.

1. In the left menu pane, under **Services**, select **Repositories**. The **Repositories** pane for your container registry appears.

1. Verify that the **reservationsystem** repository appears. Select the **reservationsystem** repository, and verify that the repository contains an image with the tag **latest**.

    :::image type="content" source="../media/7-repository.png" alt-text="Screenshot showing the repository and tagged reservation system container image in the registry.":::

## Load and run an image using Azure Container Instance

1. In the Azure portal Home page, select **Create a resource**. The **Create a resource** pane appears.

1. In the left menu pane, select **Containers**, and under *Popular services*, select **Container Instances**.

    :::image type="content" source="../media/7-search-container-instance.png" alt-text="Screenshot that shows the New pane again in Azure portal showing the Container options available in Azure Marketplace.":::

    The **Create container instance** pane appears.

    There are several pieces of information that need configuration for our Container Instance. We'll start by setting the resource group information and container details. Next, we'll configure the container's network options and restart the policy.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting  | Value  |
    |---|---|
    | **Project details** |
    | Subscription | Select your default Azure subscription in which you are allowed to create and manage resources |
    | Resource group | Reuse the existing resource group **learn-deploy-container-aci-rg** |
    | **Container details** |
    | Container name | hotelsysteminstance |
    | Region | Use the default location |
    | Image source | Docker Hub or other registry |
    | Image type | Private |
    | Image | \<*registry-name*\>.azurecr.io/reservationsystem:latest |
    | Image registry login server | Enter the login server name for your registry |
    | Image registry username | Enter the username for your registry |
    | Image registry password | Enter the password for your registry |
    | OS Type | Linux |
    | Size | Leave the default *Size* set to **1 vcpu, 1.5 Gib memory, 0 gpus** |

1. Select **Next: Networking**.

1. On the **Networking** tab, enter the following values for each setting.

    | Setting  | Value  |
    |---|---|
    | Networking type | Public |
    | DNS name label | Choose a unique name. This will be used as part of the container's URL. |
    | **Ports** |
    | Ports | 80 |
    | Ports protocol | TCP |

1. Select **Next: Advanced**.

1. On the **Advanced** tab, enter the following values for each setting.

    | Setting  | Value  |
    |---|---|
    | Restart policy | Always |
    | Environment variables| *leave all settings blank* |
    | Command override | *leave blank* |

1. Select **Review + create**. Wait for validation to complete, and correct any errors, if necessary.

1. Select **Create**.

1. When the container instance has been created, select **Go to resource**. Your container instance pane appears.

1. On the **Overview** pane, find the fully qualified domain name of the container instance.

    :::image type="content" source="../media/7-container-fqdn.png" alt-text="Screenshot that shows the New pane in Azure portal showing the Container properties with the FQDN highlighted.":::

1. Using a web browser, navigate to the URL `http://\<*fqdn*\>/api/reservations/1`, where *\<fqdn\>*  is the fully qualified domain name of the container instance. The web app should respond with a JSON document containing the details for reservation 1, as in the previous exercise.

You uploaded the Docker image to Azure Container Registry, and you ran the image using the Azure Container Instance service.
