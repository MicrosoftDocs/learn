Azure Container Registry is a managed Docker registry service based on the open-source Docker Registry 2.0. Container Registry is private, hosted in Azure, and allows you to build, store, and manage images for all types of container deployments.

Container images can be pushed and pulled with Container Registry using the Docker CLI or the Azure CLI. Azure portal integration allows you to visually inspect the container images in your container registry. In distributed environments, the Container Registry geo-replication feature can be used to distribute container images to multiple Azure datacenters for localized distribution.

Azure Container Registry Tasks can also build container images in Azure. Tasks use a standard Dockerfile to create and store a container image in Azure Container Registry without the need for local Docker tooling. With Azure Container Registry Tasks, you can build on-demand or fully automate container image builds using DevOps processes and tooling.

In this unit, you'll create an Azure Container Registry using the Azure CLI.

## Create an Azure Container Registry

1. The container registry name must be unique within Azure and contain between 5 and 50 **alphanumeric** characters. For learning purposes, run this command from Cloud Shell to create a Bash variable that holds a unique name.

    ```azurecli
    ACR_NAME=acr$RANDOM
    ```

1. Use the `az acr create` command to create the registry in the same resource group and region as your Azure Kubernetes Service (AKS) cluster, for example, **aksworkshop** in **East US**.

    ```azurecli
    az acr create \
        --resource-group aksworkshop \
        --location eastus \
        --name $ACR_NAME \
        --sku Standard
    ```

    You'll see a response similar to the below JSON example.

    ```json
    {
      "adminUserEnabled": false,
      "creationDate": "2019-12-28T01:33:23.906677+00:00",
      "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/aksworkshop/providers/Microsoft.ContainerRegistry/registries/acr4229",
      "location": "eastus",
      "loginServer": "acr4229.azurecr.io",
      "name": "acr4229",
      "networkRuleSet": null,
      "policies": {
        "quarantinePolicy": {
          "status": "disabled"
        },
        "retentionPolicy": {
          "days": 7,
          "lastUpdatedTime": "2019-12-28T01:33:25.070450+00:00",
          "status": "disabled"
        },
        "trustPolicy": {
          "status": "disabled",
          "type": "Notary"
        }
      },
      "provisioningState": "Succeeded",
      "resourceGroup": "aksworkshop",
      "sku": {
        "name": "Standard",
        "tier": "Standard"
      },
      "status": null,
      "storageAccount": null,
      "tags": {},
      "type": "Microsoft.ContainerRegistry/registries"
    }
    ```

## Build the container images using Azure Container Registry Tasks

Let's suppose your company makes use of container images to manage compute workloads. Your development teams use the local Docker tooling to build your container images.

You can also use Azure Container Registry to build these containers. A standard Dockerfile provides build instructions. Azure Container Registry allows you to reuse any Dockerfile currently in your environment, including multi-staged builds.

### Build the *ratings-api* image

The ratings API is a Node.js application, built using Express. The [source code](https://github.com/MicrosoftDocs/mslearn-aks-workshop-ratings-api?azure-portal=true) is on GitHub, and already includes a [Dockerfile](https://github.com/MicrosoftDocs/mslearn-aks-workshop-ratings-api/blob/master/Dockerfile?azure-portal=true), which builds images based on the Node.js Alpine image.

1. Clone the repository onto the Cloud Shell.

    ```azurecli
    git clone https://github.com/MicrosoftDocs/mslearn-aks-workshop-ratings-api.git
    ```

1. Change into the newly cloned directory.

    ```azurecli
    cd mslearn-aks-workshop-ratings-api
    ```

1. Run `az acr build`. This command builds a container image using the Dockerfile, then pushes the resulting image to the container registry.

    ```azurecli
    az acr build \
        --registry $ACR_NAME \
        --image ratings-api:v1 .
    ```

    > [!NOTE]
    > Don't forget the period `.` at the end of the preceding command. It represents the source directory containing the docker file, which in this case, is the current directory. Since you didn't specify the name of a file with the --file parameter, the command looks for a file called **Dockerfile** in the current directory.

    In a few minutes, you'll see a response similar to the example below.

    ```output
    2019/12/28 02:04:11 Successfully pushed image: acr4229.azurecr.io/ratings-api:v1
    2019/12/28 02:04:11 Step ID: build marked as successful (elapsed time in seconds: 240.205952)
    2019/12/28 02:04:11 Populating digests for step ID: build...
    2019/12/28 02:04:13 Successfully populated digests for step ID: build
    2019/12/28 02:04:13 Step ID: push marked as successful (elapsed time in seconds: 33.293102)
    2019/12/28 02:04:13 The following dependencies were found:
    2019/12/28 02:04:13
    - image:
        registry: acr4229.azurecr.io
        repository: ratings-api
        tag: v1
        digest: sha256:b35cc14b16e3a4f51b86d0ed61f74dcfabb00f63e015ed33ec1fe7f48c55abda
      runtime-dependency:
        registry: registry.hub.docker.com
        repository: library/node
        tag: 13.5-alpine
        digest: sha256:a5a7ff4267a810a019c7c3732b3c463a892a61937d84ee952c34af2fb486058d
      git: {}

    Run ID: ca2 was successful after 4m41s
    ```

    Make a note of the pushed image registry and name, for example, `acr4229.azurecr.io/ratings-api:v1`. You'll need this information when configuring the Kubernetes deployment.

### Build the *ratings-web* image

The ratings frontend is a Node.js application that was built using Vue and WebPack. The [source code](https://github.com/MicrosoftDocs/mslearn-aks-workshop-ratings-web?azure-portal=true) is on GitHub, and already includes a [Dockerfile](https://github.com/MicrosoftDocs/mslearn-aks-workshop-ratings-web/blob/master/Dockerfile?azure-portal=true), which builds images based on the Node.js Alpine image.

1. Change back to the home directory.

    ```azurecli
    cd ~
    ```

1. Clone the *ratings-web* repo.

    ```azurecli
    git clone https://github.com/MicrosoftDocs/mslearn-aks-workshop-ratings-web.git
    ```

1. Change into the newly cloned directory

    ```azurecli
    cd mslearn-aks-workshop-ratings-web
    ```

1. Run `az acr build`. This command builds a container image using the Dockerfile, then pushes the resulting image to the container registry.

    ```azurecli
    az acr build \
        --registry $ACR_NAME \
        --image ratings-web:v1 .
    ```

    In a few minutes, you'll see a response similar to the example below.

    ```output
    2019/12/28 02:09:51 Successfully pushed image: acr4229.azurecr.io/ratings-web:v1
    2019/12/28 02:09:51 Step ID: build marked as successful (elapsed time in seconds: 26.612936)
    2019/12/28 02:09:51 Populating digests for step ID: build...
    2019/12/28 02:09:53 Successfully populated digests for step ID: build
    2019/12/28 02:09:53 Step ID: push marked as successful (elapsed time in seconds: 35.571607)
    2019/12/28 02:09:53 The following dependencies were found:
    2019/12/28 02:09:53
    - image:
        registry: acr4229.azurecr.io
        repository: ratings-web
        tag: v1
        digest: sha256:ae4bab55e74d057e48b05b45761eef8d1c71874d9cfeeef6e0c3c1178f01f0f2
      runtime-dependency:
        registry: registry.hub.docker.com
        repository: library/node
        tag: 13.5-alpine
        digest: sha256:a5a7ff4267a810a019c7c3732b3c463a892a61937d84ee952c34af2fb486058d
      git: {}

    Run ID: ca3 was successful after 1m9s
    ```

    Make a note of the pushed image registry and name, for example, `acr4229.azurecr.io/ratings-web:v1`. You'll use this information when you configure the Kubernetes deployment.

## Verify the images

1. Run the following command in the Cloud Shell to verify that the images have been created and stored in the registry.

    ```azurecli
    az acr repository list \
        --name $ACR_NAME \
        --output table
    ```

    The output from this command will look similar to the following example.

    ```output
    Result
    -----------
    ratings-api
    ratings-web
    ```

The images are now ready for use.

## Configure the AKS cluster to authenticate to the container registry

Let's integrate the Azure Container Registry with the existing AKS cluster by supplying valid values for **AKS_CLUSTER_NAME** and **ACR_NAME**. You can automatically configure the required service principal authentication between the two resources.

1. Run the following command.

    ```azurecli
    az aks update \
        --name $AKS_CLUSTER_NAME \
        --resource-group aksworkshop \
        --attach-acr $ACR_NAME
    ```
