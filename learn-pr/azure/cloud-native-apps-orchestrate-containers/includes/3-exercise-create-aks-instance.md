In this exercise, you will:

* Create a new registry in Azure Container Registry using the Azure portal.
* Build an express.js Docker image and upload it to your container registry.
* Create a Kubernetes cluster using AKS and connect it to your container registry.
* Build a Next.js Docker image and upload it to your container registry.

[!include[](../../../includes/azure-exercise-subscription-prerequisite.md)]

## Create a registry in Azure Container Registry

1. Sign in to the [Azure portal](https://portal.azure.com/) with your Azure subscription.

2. Select **Create a resource** > **Containers** > **Container Registry**.

    :::image type="content" source="../media/3-search-container-registry-annotated.png" alt-text="Screenshot that shows the New pane in Azure portal showing the Container options available in Azure Marketplace.":::

3. Specify the values in the following table for each of the properties:

   | Property | Value |
   |---|---|
   | Subscription | Select your default Azure subscription in which you're allowed to create and manage resources. |
   | Resource group | Create a new resource group with the name **learn-cna-rg**. If you choose a different resource group name, remember it for the rest of the exercises in this module. |
   | Registry name | Enter a unique name and make a note of it for later. |
   | Location | Leave as default, or select a location close to you. |
   | Pricing plan | **Standard** |

4. Select **Review + create** > **Create**.

    The container registry takes a few minutes to create.

### Build a Docker image and upload it to Azure Container Registry

1. Navigate to [Azure Cloud Shell](https://shell.azure.com). If you're prompted to choose a shell, select **Bash**.

2. Create environment variables for your registry name and resource group using the following commands. Make sure you replace `{registry_name}` with your unique registry name.

    ```azurecli-interactive
    # Set the registry name
    REGISTRYNAME={registry_name}
    
    # Set the resource group name
    RESOURCEGROUP=learn-cna-rg
    ```

3. Download the source code for the Node.js app from GitHub using the `git clone` command.

    ```azurecli-interactive
    git clone https://github.com/MicrosoftDocs/mslearn-cloud-native-apps-express.git
    ```

4. Change directories to the source code folder using `cd`.

    ```azurecli-interactive
    cd mslearn-cloud-native-apps-express/src
    ```

5. Build and store the Docker image in your container registry using the `az acr build` command. Make sure to include the `.` at the end of the command.

    ```azurecli-interactive
    az acr build --registry $REGISTRYNAME --image expressimage .
    ```

6. Return to the main directory of the source code using `cd ..`.

    ```azurecli-interactive
    cd ..
    ```

The Docker file contains the step-by-step instructions for building a Docker image from the source code for the Node.js application. Azure Container Registry runs these steps to build the image, and as each step completes, a message is generated. The build process should finish after a couple of minutes.

## Create an AKS cluster

1. On the Azure portal **Home** page, select **Create a resource**.

2. Select **Containers** >  **Azure Kubernetes Service (AKS)**.
    :::image type="content" source="../media/3-d-select-aks.png" alt-text="Select AKS in Azure portal.":::

3. On the **Basics** tab, enter the following information:  

    |Parameter | Value |
    |--- | --- |
    |**Subscription** |  Select the same subscription as you used to set up the container registry. |
    |**Resource group** | Select the same resource group as you used to set up the container registry. |
    |**Cluster preset configuration** | Select **Dev/Test**. |
    |**Kubernetes cluster name** |  Choose a unique name, such as *cna-demo-aks*. |
    |**Region** | Leave as default, or select a region close to you. |

    :::image type="content" source="../media/3-create-cluster.png" alt-text="Screenshot of the Configuration form.":::

4. Select **Next** > **Next** > **Next**.
5. On the **Integrations** tab, select the container registry you created earlier.
6. Select **Review + create** > **Create**.

    The cluster takes a few minutes to create.

7. Return to the Azure Cloud Shell, and create an environment variable for your cluster using the following command. Make sure you replace `{cluster-name}` with your Kubernetes cluster name.

    ```azurecli-interactive
    CLUSTERNAME={cluster-name}
    ```

## Build the management app Docker image

1. In Azure Cloud Shell, change directories into the source code folder for the management app using `cd`.

    ```azurecli-interactive
    cd react/
    ```

2. Build and store the Docker image in your container registry using the `az acr build` command. Make sure to include the `.` at the end of the command.

    ```azurecli-interactive
    az acr build --registry $REGISTRYNAME --image webimage .
    ```

3. Return to the main directory of the source code using `cd ..`.

    ```azurecli-interactive
    cd ..
    ```

Congratulations! You just created a container registry, built express.js and Next.js container images, and stored the images in the registry. You also created a Kubernetes cluster in AKS that's connected to your container registry.

Leave your Cloud Shell open. You'll use it again in the next exercise.
