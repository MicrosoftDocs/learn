Azure Container Registry provides storage for Docker images in the cloud. In the example scenario, the team needs to create a container registry. This registry stores the container images to process messages from smart fridges.

The exercises in this module are designed to give you an overview of how to set up a scalable Cloud Native App using AKS. For more in-depth knowledge and tutorials on containers, Kubernetes, and AKS, you can visit:

* [Introduction to Kubernetes on Azure](/training/paths/intro-to-kubernetes-on-azure)
* [Kubernetes Learning Path](https://azure.microsoft.com/resources/kubernetes-learning-path/)
* [Azure DevOps Labs - Deploying a multi-container application to Azure Kubernetes Services](https://azuredevopslabs.com/labs/vstsextend/kubernetes/)

In this exercise, you will:

* Create a new registry in Azure Container Registry using the Azure portal.
* Build an express.js Docker image and upload it to your container registry.
* Create a Kubernetes cluster using AKS and connect it to your container registry.
* Build a Next.js Docker image and upload it to your container registry.

[!include[](../../../includes/azure-exercise-subscription-prerequisite.md)]

## Create a registry in Azure Container Registry

1. Sign in to the [Azure portal](https://portal.azure.com/) with your Azure subscription.

1. Select **Create a resource**, then select **Containers**, and then select **Container Registry**.

    :::image type="content" source="../media/3-search-container-registry-annotated.png" alt-text="Screenshot that shows the New pane in Azure portal showing the Container options available in Azure Marketplace":::

1. Specify the values in the following table for each of the properties:

   | Property | Value |
   |---|---|
   | Subscription | Select your default Azure subscription in which you're allowed to create and manage resources. |
   | Resource Group | Create a new resource group with the name **learn-cna-rg** so that it will be easier to clean up these resources when you're finished with the module. If you choose a different resource group name, remember it for the rest of the exercises in this module. |
   | Registry name | Enter a unique name and make a note of it for later. |
   | Location | Leave as default, or select a location that is close to you. |
   | SKU | **Standard** |

    * Remember to take a note of your `Registry name` and the name of your `Resource Group`; you'll need them soon.

1. Select **Review + create** and wait for validation to process.

1. Select **Create**. Wait until the container registry has been created before you continue. It should only take a few seconds, and the webpage will display `Your deployment is complete`.

### Build a Docker image and upload it to Azure Container Registry

1. Go to Azure Cloud Shell.
    > [!div class="nextstepaction"]
    > [Azure Cloud Shell](https://shell.azure.com)

    1. If no storage is mounted, select `Bash`, and then select the same subscription you used to create the Container Registry.

1. In the Azure Cloud Shell in the portal, copy and paste the following command, but replace `{registry_name}` with the Registry name you chose in step 3.

    ```bash
    REGISTRYNAME={registry_name}
    ```

1. Select <kbd>Enter</kbd> to run the code and set your registry name.

1. In the Azure Cloud Shell, copy and paste the following command, but replace `{resource-group-name}` with the Resource Group you chose in step 3. Then, select <kbd>Enter</kbd> to run the code and set your Resource Group name.

    ```bash
    RESOURCEGROUP={resource-group-name}
    ```

1. In the Azure Cloud Shell, run the following command to download the source code for the Node.js app. This app is simple; it accepts a POST request from smart fridges.

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-cloud-native-apps-express.git
    ```

1. Move to the source folder for express:

    ```bash
    cd mslearn-cloud-native-apps-express/src
    ```

1. Run the following command. This command sends the folder's contents to Azure Container Registry, which uses the instructions in the Docker file to build the image and store it. Take care not to remove the `.` character at the end of the command.

    ```bash
    az acr build --registry $REGISTRYNAME --image expressimage .
    ```

    > [!TIP]
    > If an error is returned, remember to set your `REGISTRYNAME` and `RESOURCEGROUP` in the Cloud Shell.

1. Return to the main directory of the source code.

    ```bash
    cd ..
    ```

1. Leave the Cloud Shell open, and return to this exercise unit.

The Docker file contains the step-by-step instructions for building a Docker image from the source code for the Node.js application. Azure Container Registry runs these steps to build the image, and as each step completes, a message is generated. The build process should finish after a couple of minutes.

Congratulations, you've built a container from a GitHub repository, and saved it to Azure Container Registry. Next, let's setup AKS.

## Create an AKS cluster

We want to host a Node.js container in the cloud to receive messages from smart fridges, process them, and send the data to a management web app. To do so, we'll create an Azure Kubernetes Service instance and connect it to the container registry.

In this section, we'll create an Azure Kubernetes Service instance in the Azure portal.

1. Return back to the Azure portal.

    > [!div class="nextstepaction"]
    > [Azure portal](https://portal.azure.com/)

    To create an AKS cluster, complete the following steps:

1. On the Azure portal menu or from the **Home** page, select **Create a resource**.

1. Select **Containers** >  **Azure Kubernetes Service (AKS)**.
    :::image type="content" source="../media/3-d-select-aks.png" alt-text="Select AKS in Azure portal.":::

1. On the **Basics** tab, enter the following information:  

    |Parameter | Value |
    |--- | --- |
    |**Subscription** |  Select the same subscription as you used to set up the container registry |
    |**Resource group** | Select the same resource group as you used to set up the container registry |
    |**Cluster preset configuration** | Select **Dev/Test** |
    |**Kubernetes cluster name** |  Choose a unique name, such as *cna-demo-aks* |
    |**Region** | Leave the default, or use a region that's close to you |
    |**Availability zones** | Leave as default |
    |**AKS pricing tier** | Leave as default |
    |**Kubernetes version** |  Leave as default |
    |**Automatic upgrade** | Leave as default |
    |**Node size** | Leave as default |
    |**Scale method** | Select **Manual** |
    |**Node count range** |  Leave as default |

    :::image type="content" source="../media/3-create-cluster.png" alt-text="Configuration form.":::

    * Remember to make note of your `Kubernetes cluster name`.

1. Select the **Integrations** tab.
1. Select the container registry you just created.

1. Select the **Review + create** button at the bottom of the page. This will take a few seconds.
1. Select the **Create** button. It takes a few minutes to create the AKS cluster.

1. Return to the Azure Cloud Shell, copy and paste the following command, but replace `{cluster-name}` with the Kubernetes cluster name you chose in step 3. Then, select <kbd>Enter</kbd> to run the command and set your Kubernetes cluster name.

    ```bash
    CLUSTERNAME={cluster-name}
    ```

## Build the management app Docker Image

While AKS gets set up, you can upload the management web app to the Container Registry.

1. Return to your Cloud Shell session.
1. Move to the source folder:

    ```bash
    cd react/
    ```

1. Run the following command to build the image and store it. Take care not to remove the `.` character at the end of the command.

    ```bash
    az acr build --registry $REGISTRYNAME --image webimage .
    ```

1. Return to the main directory

    ```bash
    cd ..
    ```

Congratulations! You just created a container registry, built express.js and Next.js container images, and stored the images in the registry. You also created a Kubernetes cluster in AKS that's connected to your container registry.

Leave your Cloud Shell open. You'll use it again in the next exercise.
