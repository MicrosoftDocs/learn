# Build container images with ACR Build

With Azure Container Registry Build, container images can be built in the cloud, without the need for local tools such as Docker for Windows or Docker for Mac. Azure Container Registry Build also allows for inner-loop development in the cloud with on-demand container image builds, and automated builds on source code commit and base image update.

In this unit, you automate the creation of a container image using Azure Container Registry Build.

## Create a container image with Build

When using Azure Container Registry Build, a standard Dockerfile is used to provide build instructions. Any Dockerfile currently used in your environment, including multi-staged builds, works with Azure Container Registry Build.

```console
FROM    node:9-alpine
RUN     mkdir /src
ADD     https://raw.githubusercontent.com/Azure-Samples/acr-build-helloworld-node/master/package.json /src
ADD     https://raw.githubusercontent.com/Azure-Samples/acr-build-helloworld-node/master/server.js /src
RUN     cd /src && npm install
EXPOSE  80
CMD     ["node", "/src/server.js"]
```

Run the following command to build the container image from the Dockerfile.

```azurecli
az acr build --registry <acrName> --image helloacrbuild:v1 .
```

When done, run the following command to verify that the image has been created and stored in the registry.

```azurecli
az acr repository list --name <acrName> --output table
```

The output should look similar to the following.

```console
Result
-------------
helloacrbuild
```