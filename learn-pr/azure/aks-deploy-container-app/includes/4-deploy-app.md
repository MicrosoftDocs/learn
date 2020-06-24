Next, we'll use a static web application built using Hugo, a static website generator written in Golang. This application is available [in this repository](https://github.com/MicrosoftDocs/mslearn-aks-deploy-container-app).

Here, we'll run through all the engineering aspects of a containerized application and discuss how you can create one, and what makes them different from other applications.

## Images

The first thing you'll notice is that there's a Dockerfile in the root of the repository. That's because you'll be using a Docker image to spin up your application.

Kubernetes is a __container__ orchestrator. Which means that we'll be using Docker containers to build and run the application within an image and deploy this image to the AKS cluster.

### Create a container registry

Kubernetes can only spin up an image if that image is hosted in a container registry. Container registries allow you to store your images safely in the cloud and download them later on.

For this exercise, we'll use Azure Container Registry. So, let's create an Azure Container Registry to store our image and deploy the image to our Kubernetes cluster.

1. Run the following command to create a new container registry. Replace `<resource-group-name>` with the name of your resource group.

    ```azurecli
    az acr create \
        --resource-group <resource-group-name> \
        --name ContosoContainerRegistry$RANDOM \
        --sku Basic
    ```

### Connect the AKS cluster to the ACR

Since we are working with a private container registry, we'll need to tell our AKS cluster to authenticate with that registry so it can download the stored images. Luckily, using both ACR and AKS this integration can be easily done.

1. Check if you have the `aks-preview` extension enabled in your CLI

    ```azurecli
    az extension list
    ```

1. If the list is empty, Run the following command on your terminal to update your AKS cluster

    ```azurecli
    az aks update -n contoso-kubernetes-cluster -g contoso-aks --attach-acr ContosoContainerRegistry$RANDOM
    ```

1. If not, run the preview command:

    ```azurecli
    az aks update -n contoso-kubernetes-cluster -g contoso-aks --acr ContosoContainerRegistry$RANDOM --enable-acr
    ```

The result will be the attachment of your ACR to your AKS cluster.

### Log in to your container registry

Once the CR is created, you need to connect your local Docker runtime to the :::no-loc text="registry"::: so it can push your image to the remote destination. To do so, follow these steps:

1. Open your terminal and type the following Azure CLI command:

    ```azurecli
    az acr login -n ContosoContainerRegistry$RANDOM
    ```

    There's no need to include the `.azurecr.io` in the name of the CR when logging in.

    If you ever need to see your sign-in credentials, just access the ACR resource in the [Azure portal](https://portal.azure.com) and go to the "Access keys" tab on the left-hand side:

    :::image type="content" source="../media/4-acr-login.png" alt-text="Check your credentials on the 'Access Keys' tab":::

1. After the sign-in, your local Docker runtime should be already connected to the ACR resource.

### Push an image to the ACR

Now it's time to put everything together and push the image to the ACR you created.

1. Run the following commands in Cloud Shell to clone the GitHub repository that contains the files for the application, and change to that directory.

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-aks-deploy-container-app.git
    cd mslearn-aks-deploy-container-app
    ```

1. Next, run the the `acr build` command to start building the image.

    ```azurecli
    az acr build --image contoso-website --registry ContosoContainerRegistry$RANDOM --file Dockerfile .
    ```

    Using the `-t` option will add the `contoso-website` tag to the image. After the image is built, it'll be pushed directly to the registry.
