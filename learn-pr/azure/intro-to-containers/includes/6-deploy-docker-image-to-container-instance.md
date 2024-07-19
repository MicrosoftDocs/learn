Azure Container Instance is a service that loads and runs Docker images on demand. The Azure Container Instance service can retrieve an image from a registry, such as Docker Hub or Azure Container Registry.

Your organization wants to use Azure to run its web apps. For this reason, it makes sense to store the images in Azure Container Registry and run them using the Azure Container Instance service.  

In this unit, you'll learn how to upload a Docker image to Azure Container Registry. Then, you'll run the image using the Azure Container Instance service.

## Use Azure Container Registry to store a container

Azure Container Registry is a registry-hosting service provided by Azure. Each Azure Container Registry resource you create is a separate registry with a unique URL. These registries are *private*, meaning they require authentication to push or pull images. Azure Container Registry runs in the cloud and provides similar levels of scalability and availability to other Azure services.

You can create a registry using the Azure portal or the Azure Command Line Interface (CLI). You can use the Cloud Shell in the Azure portal or a local install of the Azure CLI. Keep in mind that you need to create a resource group before you can create the registry. When creating a resource group, we recommend choosing the nearest region. In this example, our resource group's name is `mygroup`, and the location is US West.

You don't need to run any of the following commands. We'll do that in the next exercise.

> [!NOTE]
> You need a unique name for your container. You can check to see if a name is already in use [here](/rest/api/containerregistry/registries/checknameavailability).

```azurecli
az group create --name mygroup --location westus
```

```azurecli
az acr create --name <unique name> --resource-group mygroup --sku standard --admin-enabled true
```

Different SKUs provide varying levels of scalability and storage.

Azure Container Registry repositories are private, meaning they don't support unauthenticated access. To pull images from an Azure Container Registry repository, use the `docker login` command and specify the URL of the login server for the registry. The login server URL for a registry in Azure Container Registry has the form \<*registry_name*\>.azurecr.io.

```bash
docker login myregistry.azurecr.io
```

Docker login will prompt you for a username and password. To find this information, go to the Azure portal and look up the access keys for the registry or run the following command.

```azurecli
az acr credential show --name myregistry --resource-group mygroup
```

You *push* an image from your local computer to a Docker registry by using the `docker push` command. Before you push an image, you must create an alias for the image that specifies the repository and tag that the Docker registry creates. The repository name must be of the form \*<login_server\>/<*image_name*\>:<*tag*/>. Use the `docker tag` command to perform this operation. The following example creates an alias for the *reservationsystem* image.

```bash
docker tag reservationsystem myregistry.azurecr.io/reservationsystem:v2
```

If you run `docker image ls`, you'll see two entries for the image: one with the original name and the second with the new alias.

After you run the tag command, you can upload the image to the registry in Azure Container Registry using the following command.

```bash
docker push myregistry.azurecr.io/reservationsystem:v2
```

Verify that the image has been uploaded correctly by listing the repositories in the registry with the following command.

```azurecli
az acr repository list --name myregistry --resource-group mygroup
```

You can also list the images in the registry with the `acr repository show` command.

```azurecli
az acr repository show --repository reservationsystem --name myregistry --resource-group mygroup
```

> [!NOTE]
> You'll have at least two tags for each image in a repository. One tag will be the value you specified in the *acr build* command (*v1* in the previous example). The other will be *latest*. Every time you rebuild an image, Azure Container Registry automatically creates the *latest* tag as an alias for the most recent version of the image.

## Use Azure Container Instance to run an image

The Azure Container Instance service can load an image from Azure Container Registry and run it in Azure.

You create a container instance and start the image running by using the `az container create` command. Provide the username and password for the registry in the `registry-username` and `registry-password` parameters. The instance will be allocated an IP address. You access the instance with this IP address. You can optionally specify a DNS name if you prefer to reference the instance through a more user-friendly label. Notice that you specify the image as a URL that references your registry (*myregistry*) in the Azure Container Registry service (*azurecr.io*). If you're using Docker Hub or some other registry, replace this URL with the URL of your image in that registry.

```azurecli
az container create --resource-group mygroup --name myinstance --image myregistry.azurecr.io/myapp:latest --dns-name-label mydnsname --registry-username <username> --registry-password <password>
```

Azure hosts the instance with a domain name based on the DNS label you specified. You can find the fully qualified domain name of the instance by querying the IP address of the instance.

```azurecli
az container show --resource-group mygroup --name myinstance --query ipAddress.fqdn
```

You can access the application using a web browser. You can navigate to the URL this command returns; we'll learn how in the next unit.
