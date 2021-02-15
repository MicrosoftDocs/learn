Azure Container Instance loads and runs Docker images on demand. The Azure Container Instance service can retrieve the image from a registry such as Docker Hub or Azure Container Registry.

Your organization wants to use Azure to run its web apps. For this reason, it makes sense to store the images in Azure Container Registry, and run them using the Azure Container Instance service.  

In this unit, you'll learn how to upload a Docker image to Azure Container Registry, and run an image using the Azure Container Instance service.

## Use Azure Container Registry to store a container

Azure Container Registry is a registry hosting service provided by Azure. Each Azure Container Registry resource you create is a separate registry with a unique URL. These registries are *private*: they require authentication to push or pull images. Azure Container Registry runs in the cloud, and provides similar levels of scalability and availability to many other Azure services.

You create a registry either using the Azure portal, or using the *acr create* command in the Azure Command Line Interface, as shown in the following example. Keep in mind that you'll have to create a resource group before you create the registry. In this example, our resource group's name is `mygroup`.

```bash
az acr create --name myregistry --resource-group mygroup --sku standard --admin-enabled true
```

Different SKUs provide varying levels of scalability and storage.

Azure Container Registry repositories are private &mdash; they do not support unauthenticated access. To pull images from an Azure Container Registry repository, use the `docker login` command and specify the URL of the login server for the registry. The login server URL for a registry in Azure Container Registry has the form \<*registry_name*\>.azurecr.io.

```bash
docker login myregistry.azurecr.io
```

You will be prompted for a username and password. To find this information, you can either go to the Azure portal and look up the access keys for the registry, or you can run the following command.

```bash
az acr credential show --name myregistry
```

You *push* an image from your local computer to a Docker registry with the `docker push` command. Before you do this though, you must create an alias for the image that specifies the repository and tag to be created in the Docker registry. The repository name must be of the form \*<login_server\>/<*image_name*\>:<*tag*/>. Use the `docker tag` command to perform this operation. The following example creates an alias for the *myapp:v1* image described in unit 4.

```bash
docker tag myapp:v1 myregistry.azurecr.io/myapp:v1
```

If you run `docker image ls`, you will see two entries for the image: one with the original name, and the second with the new alias.

Upload the image to the registry in Azure Container Registry.

```bash
docker push myregistry.azurecr.io/myapp:v1
```

Verify that the image has been uploaded correctly by querying the repositories in the registry with the `acr repository list` command.

```bash
az acr repository list --name myregistry
```

You can list the images in the registry with the `acr repository show` command.

```bash
az acr repository show --repository myapp --name myregistry
```

> [!NOTE]
> You will see at least two tags for each image in a repository. One tag will be value you specified in the *acr build* command (*v1* in the example above). The other will be *latest*. Every time you rebuild an image, Azure Container Registry automatically creates the *latest* tag as an alias for the most recent version of the image.

## Use Azure Container Instance to run an image

The Azure Container Instance service can load an image from Azure Container Registry and run it in Azure.

You create a container instance and start the image running with the `az container create` command. Provide the username and password for the registry in the `registry-username` and `registry-password` parameters. The instance will be allocated an IP address. You access the instance with this IP address. You can optionally specify a DNS name if you prefer to reference the instance through a more user-friendly label. Notice that you specify the image as a URL that references your registry (*myregistry*) in the Azure Container Registry service (*azurecr.io*). If you're using Docker Hub or some other registry, replace this URL with that of your image in that registry.

```bash
az container create --resource-group mygroup --name myinstance --image myregistry.azurecr.io/myapp:latest --dns-name-label mydnsname --registry-username <username> --registry-password <password>
```

The instance will be hosted by Azure with a domain name based on the DNS label you specified. You find the fully qualified domain name of the instance by querying the IP address of the instance.

```bash
az container show --resource-group mygroup --name myinstance --query ipAddress.fqdn
```

You can access the application using a web browser. Navigate to the URL returned by this command.
