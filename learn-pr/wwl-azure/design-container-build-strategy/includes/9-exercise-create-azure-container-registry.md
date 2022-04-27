The Azure Container Registry task in Azure DevOps can be used to build container images in Azure.

These tasks can be used to build images on-demand and fully automate build workflows with triggers such as source code commits and base image updates.

## Create an Azure Container Registry

The Azure portal offers a great experience for creating a new container registry. This section will go through the steps of creating a new registry via the Azure CLI.

### Create a resource group

Create a resource group with the az group create command. An Azure resource group is a logical container into which Azure resources are deployed and managed. The following example creates a resource group-named myResourceGroup in the eastus location.

```powershell
az group create --name myResourceGroup --location eastus

```

#### Create a container registry

The following example will create a basic registry called myaz400containerregistry in the resource group we created in the previous step.

```powershell
az acr create --resource-group myResourceGroup --name myaz400containerregistry --sku Basic

```

The response from this command returns the `loginserver,` which has the fully qualified URL of the registry.

```JSON
{
  "adminUserEnabled": false,
  "creationDate": "2021-Mar-08T22:32:13.175925+00:00",
  "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myResourceGroup/providers/Microsoft.ContainerRegistry/registries/myaz400containerregistry",
  "location": "eastus",
  "loginServer": "myaz400containerregistry.azurecr.io",
  "name": "myaz400containerregistry",
  "provisioningState": "Succeeded",
  "resourceGroup": "myResourceGroup",
  "sku": {
    "name": "Basic",
    "tier": "Basic"
  },
  "status": null,
  "storageAccount": null,
  "tags": {},
  "type": "Microsoft.ContainerRegistry/registries"
}

```

#### Sign in to the registry

Before pushing and pulling container images, you must sign in to the registry. To do so, use the az acr sign-in command.

```powershell
az acr login --name <acrName>

```

#### Push image to registry

To push an image to an Azure Container Registry, you must first have an image. If you don't yet have any local container images, run the following docker pull command to pull an existing image from Docker Hub. For this example, pull the `hello-world` image.

```powershell
docker pull hello-world

```

Before you can push an image to your registry, you must tag it with the fully qualified name of your ACR sign-in server. The sign-in server name is in the format 'registry-name'.azurecr.io (all lowercase), for example, `myaz400containerregistry.azurecr.io`.

```powershell
docker tag hello-world <acrLoginServer>/hello-world:v1

```

Finally, use docker push to push the image to the ACR instance. Replace acrLoginServer with the sign-in server name of your ACR instance. This example creates the hello-world repository containing the hello-world:v1 image.

```powershell
docker push <acrLoginServer>/hello-world:v1

```

After pushing the image to your container registry, remove the hello-world:v1 image from your local Docker environment.

```powershell
docker rmi <acrLoginServer>/hello-world:v1

```

#### List container images

The following example lists the repositories in your registry:

```powershell
az acr repository list --name <acrName> --output table

```

#### Run image from the registry

You can pull and run the hello-world:v1 container image from your container registry by using docker run:

```powershell
docker run <acrLoginServer>/hello-world:v1

```

#### Clean up resources

When no longer needed, you can use the az group delete command to remove the resource group, the container registry, and the container images stored there.

```powershell
az group delete --name myResourceGroup

```
