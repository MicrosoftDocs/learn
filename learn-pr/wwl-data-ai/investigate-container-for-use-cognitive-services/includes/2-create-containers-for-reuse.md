Containers allow you to host Azure Cognitive Services either on-premises or on Azure. If using data in an on-premises SQL Server you can deploy Cognitive Services in containers on the same network. Now your data can stay on your local network and not move to the cloud. Deploying Cognitive Services in a container on-premises will also decrease the latency between the service and your local data. This can dramatically improve performance because internet bandwidth is not involved.

The ability to run Cognitive Services in a container enables different deployment scenarios that can meet a variety of organizational security policies.

## Set up services (Azure CLI)

Before you can complete the exercises in this module, you will need to have some core services in place.  Run the following commands from the Azure CLI to create the services necessary. It is recommended that you do this in the Azure portal but you can download the [Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest) locally and run it from your computer as well.

>[!Note]
>You may have to change the names of these resources to avoid naming conflicts in Azure.

### Azure Resource Group

```azurecli
az group create --name cogContainerRG --location westus2
```

### Text Analytics service

```azurecli
az cognitiveservices account create --kind TextAnalytics --resource-group cogContainerRG --name textAnalyticsContainerGer --location westus2 --sku F0
```

### Azure Container registry

```azurecli
az acr create --resource-group cogContainerRG --name textAnalyticsConReg --sku Basic
```

### Azure Kubernetes service

```azurecli
az aks create \
    --resource-group cogContainerRG \
    --name textAnalyticsAKS \
    --node-count 2 \
    --generate-ssh-keys \
    --attach-acr textAnalyticsConReg
```

## Use Docker with Cognitive Services containers

There are Docker containers ready for you to use in the Microsoft Container Registry. Each container provides a subset of Cognitive Services functionality. For example, not all features of the Text Analytics service are in a single container. Language detection, translation, and sentiment analysis are each separate container images. However, the setup steps are similar for each container.

For the Text Analytics service, each of the three core features maps to a separate image:

| Feature | Image |
|---|---|
|Key Phrase Extraction | mcr.microsoft.com/azure-cognitive-services/keyphrase |
| Language Detection | mcr.microsoft.com/azure-cognitive-services/language |
| Sentiment Analysis v3 (English) |	mcr.microsoft.com/azure-cognitive-services/sentiment:3.0-en |

>[!Note]
>Sentiment Analysis supports other languages by replacing the en in the image with the correct language code

You can use the docker pull command to download the containers to work with them directly from your machine. Some of the containers are in a “Gated” public preview state. Those in a gated preview require an application to access. Otherwise the containers are available for anyone to use with their Azure Cognitive Services deployment.

## Build Cognitive Services container images

You may choose to customize the Cognitive Services container images. This involves building a container image from a Dockerfile that you define. The first line in this file will be a FROM command that points to the parent image. The other lines are adding on our configurations. The configurations vary depending on the service.

All Cognitive Services image requires three settings: billing endpoint, subscription key, and EULA agreement. If using the custom speech container, you would also pass a Model ID and configure a volume mount. You will want to consult the documentation for whichever container you choose. 

Required configuration settings for all Cognitive Services containers:

| Setting | Description |
|---|---|
| ApiKey | Key from your deployed Azure Cognitive Service; used for billing. |
| Billing | Endpoint URI from your deployed Azure Cognitive Service; used for billing. |
| Eula | Value of accept to state you accept the license for the container. |

## Gather required parameter values

You will need to retrieve two required values: **subscription key** and **endpoint**. The Azure Cognitive Service, in this scenario Text Analytics, should have been created in Azure. The Azure endpoint needs to exist even though the model is included in the container. The endpoint is used for billing and metering only, not for processing data.

Your specific Cognitive Services subscription key and service endpoint (for billing purposes) need to be provided. These can be retrieved by browsing to the Cognitive Services instance in Azure portal and copying the values from the Keys and Endpoint section. You will need these values for building the custom image in the next exercise.

:::image type="content" source="../media/03-container-reuse-key-and-endpoint-ssm.png" alt-text="Screenshot showing where to find KEY 1 and ENDPOINT on the Cognitive Services Keys and Endpoint screen.":::

## Create Containers for Reuse

When configuring containers for Cognitive Services, you start with the images that are available in Microsoft Container Registry. You can use these images without modifying the definition. However, the default image requires passing in certain configurations. To make running the container easier you will create a container image that includes our custom settings. This image can be reused without passing the configuration values each time. 

### Create a container image

You create a Dockerfile to define a custom container image with your settings built in. This file references the parent image in the FROM statement, and then applies additional settings based on environment variables. The path you'll use points to the language detection image in the Microsoft Container Registry. The ARG statements will let you pass in values during the build step. The steps would be similar for other Cognitive Services images.

Let’s build a docker image for language detection.

1. Copy and paste the following text into a file named Dockerfile.

    ```
    FROM mcr.microsoft.com/azure-cognitive-services/language
    ARG key
    ARG billing_endpoint
    ENV apikey=$key
    ENV billing=$billing_endpoint
    ENV eula=accept
    ```

1. Set two environment variables, replacing '<subscription_key>' and '<service\-name>' with your own values. You'll use these each time you build your image.

    ```
    export COGNITIVE_SERVICE_KEY=<subscription_key>
    export COGNITIVE_SERVICE_ENDPOINT=https://<service-name>.cognitiveservices.azure.com/
    ```

1. Build the image from the Dockerfile, using the image name cog-svc-language which is used in the next section.

    ```bash
    docker build --build-arg key=$COGNITIVE_SERVICE_KEY --build-arg billing_endpoint=$COGNITIVE_SERVICE_ENDPOINT -t cog-svc-language .
    ```

    The output from the build statement will show the steps completed and end with success messages.

    ```dos
    Successfully built 49379c513da1
    Successfully tagged cog-svc-language:latest
    ```

### Run your container

Now you can run a container using this image on your local machine. The docker run command will take the image name and start a Docker container. This is typical for application development and testing. Then you can test from the browser to confirm the service works. You access the swagger UI to test the API.

1. From the console, run the following command to run a container.

    ```bash
    docker run --rm -it -p 5000:5000 cog-svc-language
    ```

1. Open your browser and navigate to http://0.0.0.0:5000/swagger.

1. Select **Post** on one of the V3 endpoints, and then select **Try it out**.

    :::image type="content" source="../media/03-container-reuse-swagger.png" alt-text="Screenshot of swagger UI with Post button and Try it Out highlighted.":::

1. Select **Execute**, which posts the request to your container.

    :::image type="content" source="../media/03-container-reuse-swagger-execute.png" alt-text="Screenshot of Swagger UI in Try it Out mode. The Execute button is highlighted.":::

1. View the response.

    :::image type="content" source="../media/03-container-reuse-swagger-response.png" alt-text="Screenshot of Response body section of Swagger UI showing the detected language Response body JSON.":::

You have successfully built a Docker image, run it as a local container, and tested the containerized Cognitive Services endpoint using Swagger. Next you will decide how to deploy this container to Azure where other applications can use it.
