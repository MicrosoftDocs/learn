Azure Container Registry enables you to store Docker images in the cloud, in an Azure storage account.

In the example scenario, the team has decided to use Container Registry to host their Docker images. They can use Container Registry to create a Docker image registry in Azure, alongside their other Azure resources, and store their Docker images securely.

In this unit, you'll learn more about Container Registry and the advantages it provides for storing Docker images.

## What is Container Registry?

Container Registry is an Azure service that you can use to create your own private Docker registries. Like Docker Hub, Container Registry is organized around repositories that contain one or more images. Container Registry also lets you automate tasks such as redeploying an app when an image is rebuilt.

Security is an important reason to choose Container Registry instead of Docker Hub because:

- You have much more control over who can see and use your images.
- You can sign images to increase trust and reduce the chances of an image becoming accidentally (or intentionally) corrupted or otherwise infected.
- All images stored in a container registry are encrypted at rest.

Working with images in Container Registry is like working with Docker Hub, but offers a few unique benefits:

- Container Registry runs in Azure. The registry can be replicated to store images near where they're likely to be deployed.
- Container Registry is highly scalable, providing enhanced throughput for Docker pulls that can span many nodes concurrently. The Premium SKU of Container Registry includes 500 GiB of storage.

## Use Container Registry

You can create a registry by using either the Azure portal or the Azure CLI **acr create** command. In the following code example, the name of the new registry is *myregistry*:

```bash
az acr create --name myregistry --resource-group mygroup --sku standard --admin-enabled true
```

In addition to storing and hosting images, you can also use Container Registry to build images. Instead of building an image yourself and pushing it to Container Registry, use the CLI to upload the Docker file and other files that make up your image. Container Registry will then build the image for you. Use the **acr build** command to run a build.

```bash
az acr build --file Dockerfile --registry myregistry --image myimage .
```

Additional information about Azure Container Registry and a link to the supported CLI commands to manage private registries are available in the *Learn more* section of this module.
