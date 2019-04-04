Azure Container Registry enables you to store Docker images in the cloud, in an Azure account.

In the example scenario, the team have decided to use Azure Container Registry to host their Docker images. They can use it to create a Docker image registry in Azure alongside their other Azure resources and securely store their images.

In this unit, you will learn more about Azure Container Registry and the advantages it provides for storing Docker images.

## What is Azure Container Registry?

Azure Container Registry is an Azure service that allows you to create your own private Docker registries. Like Docker Hub, Azure Container Registry is organized around repositories that contain one or more images. Azure Container Registry also enables you to automate tasks such as redeploying an app when an image is rebuilt.

An important reason for selecting Azure Container Registry rather than DockerHub is security:
- You have much more control over who can see and use your images.
- You can sign images to increase trust and reduce the chances of an image becoming accidentally (or intentionally) corrupted or otherwise infected.
- All images stored in Azure Container Registry are encrypted at rest.

Working with images in Azure Container Registry is similar to working with Docker Hub, but offers a few unique benefits:
- Azure Container Registry runs in Azure. The registry can be replicated to store images close to where they're likely to be deployed.
- Azure Container Registry is highly scalable, providing enhanced throughput for Docker pulls that can span many nodes concurrently. The Premium edition of Azure Container Registry includes 500 GiB of storage.

## Using Azure Container Registry

You create a registry using the Azure portal, or with the *acr create* command. The following code shows an example. The new registry is named *myregistry*.

```bash
az acr create --name myregistry --resource-group mygroup --sku standard --admin-enabled true
```

In addition to storing and hosting images, Azure Container Registry can also be used to build images. Instead of building an image yourself and pushing it to ACR, you can use the Azure CLI to upload the Dockerfile and other files that make up your image, and ACR will build the image for you. Use the *acr build* command to run a build.

```bash
az acr build --file Dockerfile --registry myregistry --image myimage .
```