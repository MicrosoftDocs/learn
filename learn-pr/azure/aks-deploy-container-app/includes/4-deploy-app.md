## Understand Containerized Applications

For this module, we'll use a static web application built using Hugo, a static website generator written in Golang. This application is available [in this repository](https://github.com/MicrosoftDocs/mslearn-aks-deploy-container-app).

In this section, we'll run through all the engineering aspects of a containerized application and understand how you can create one, and what makes them different from other applications.

## Images

The first thing you'll notice is that there's a Dockerfile in the root of the repository. That's because you'll be using a Docker image to spin up your application.

Kubernetes is a __container__ orchestrator. Which means that we'll be using Docker containers to build and run the application within an image and deploy this image to the AKS cluster.

### Build your image

First of all, it's required for you to have Docker [installed](https://docs.docker.com/get-docker/) in your computer.

1. The first thing you need to do is clone the repository by clicking the green **"Clone"** button on the top of the page, or by issuing the following command in your terminal

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-aks-deploy-container-app.git
    ```

    This command will clone the entire repository to a directory called `mslearn-aks-deploy-container-app` where you can start building the image.

1. In the terminal, step into the directory you just created

1. Make sure there's a [Dockerfile](https://github.com/MicrosoftDocs/mslearn-aks-deploy-container-app/blob/668cf1fc893790d827e7ddf58d84b28189b423f3/Dockerfile) in the current directory. Then run the build command to start building the image

    ```bash
    docker build -t contoso-website .
    ```

    Using the `-t` option will make the image tagged with the name you choose

1. Run the image by typing the following command:

    ```bash
    docker run -p 9096:80 --rm --name contoso-website contoso-website
    ```

    > [!IMPORTANT]
    > If you receive a "Port already allocated error", change `9096` to another open port in your computer

    Open your browser at `http://localhost:9096` (replace `9096` by the port number you chose) and see the website running.

1. Press `CTRL + C` to stop the execution and delete the container

### Create a container registry

Kubernetes can only spin up an image if that image is hosted in a :::no-loc text="Container Registry":::, also called CR. :::no-loc text="Registries"::: are places where you can store your images safely in the cloud and download them later on.

There are a few free-to-use CRs, but the company required that you use Azure Container Registry, or ACR. So, let's create an ACR to put our image and spin that up in our recently created Kubernetes cluster.

1. Access the [Azure portal](https://portal.azure.com) and search for `Container Registries` in the search bar.

    :::image type="content" source="../media/4-acr-search.png" alt-text="Search for Container Registries":::

    Click on the :::no-loc text="Container Registries"::: search result

1. There shouldn't be any CRs created, so click the __"Create Container Registry"__ blue button

1. In the following screen, choose the same subscription you're using to host your AKS cluster, and also the same Resource Group. Give your CR a name and set the region to the same region as the AKS cluster. Also, choose the __basic__ SKU option

    :::image type="content" source="../media/4-create-acr.png" alt-text="Create the ACR":::

    Click the "Review + Create" button at the bottom of the page

1. Wait for the creation to finish and click the "Go to Resource" button when it appears

### Connect the AKS cluster to the ACR

Since we are working with a private container registry, we'll need to tell our AKS cluster to authenticate with that registry so it can download the stored images. Luckily, using both ACR and AKS this integration can be easily done.

1. Check if you have the `aks-preview` extension enabled in your CLI

    ```bash
    az extension list
    ```

1. If the list is empty, Run the following command on your terminal to update your AKS cluster

    ```bash
    az aks update -n contoso-kubernetes-cluster -g contoso-aks --attach-acr <your-registry-name>
    ```

1. If not, run the preview command:

    ```bash
    az aks update -n contoso-kubernetes-cluster -g contoso-aks --acr <your registry name> --enable-acr
    ```

The result will be the attachment of your ACR to your AKS cluster.

### Log in to your container registry

Once the CR is created, you need to connect your local Docker runtime to the :::no-loc text="registry"::: so it can push your image to the remote destination. To do so, follow these steps:

1. Open your terminal and type the following Azure CLI command:

    ```bash
    az acr login -n <your-registry-name>
    ```

    There's no need to include the `.azurecr.io` in the name of the CR when logging in.

    If you ever need to see your sign-in credentials, just access the ACR resource in the [Azure portal](https://portal.azurel.com) and go to the "Access keys" tab on the left-hand side:

    :::image type="content" source="../media/4-acr-login.png" alt-text="Check your credentials on the 'Access Keys' tab":::

1. After the sign-in, your local Docker runtime should be already connected to the ACR resource.

### Push an image to the ACR

Now it's time to put everything together and push the image to the ACR you created.

1. Build the image again using the following command

    ```bash
    docker build -t <your-registry-name>.azurecr.io/contoso-website .
    ```

1. Push the image to the registry using the following command

    ```bash
    docker push <your-registry-name>.azurecr.io/contoso-website .
    ```

1. To test if your image is pushed and running, execute it from the remote source with the following command:

    ```bash
    docker run --rm --name contoso-website-remote -p 9096:80 <your-registry-name>.azurecr.io/contoso-website
    ```

    After the download, open your browser at `http://localhost:9096` to see the results.

1. Press `CTRL + C` to stop and remove the running container
