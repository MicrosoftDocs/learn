Use this Try-This exercise to gain some hands-on experience with Azure Kubernetes Service.

For this exercise, Docker commands are used to push a container image into the registry, and finally pull and run the image from your registry.

You must also have Docker installed locally and running. Docker provides packages that easily configure Docker on any [Mac](https://docs.docker.com/docker-for-mac/), [Windows](https://docs.docker.com/docker-for-windows/), or [Linux](https://docs.docker.com/engine/installation/#supported-platforms) system.

> [!NOTE]
> To complete this procedure, you need an [Azure subscription](https://azure.microsoft.com/free/).

To push an image to an Azure Container registry, you must first have an image. If you don't yet have any local container images, run the following [docker pull](https://docs.docker.com/engine/reference/commandline/pull/) command to pull an existing public image.

Pull the `hello-world` image from Microsoft Container Registry.

```azurecli
docker pull mcr.microsoft.com/hello-world
```

:::image type="content" source="../media/image-pull-registry-acf65f40.png" alt-text="Displays a screenshot of the command-line for pulling an image.":::
Before you can push an image to your registry, you must tag it with the fully qualified name of your registry login server. The sign in server name is in the format *&lt;registry-name&gt;.azurecr.io* (must be all lowercase), for example, *newregistryapl.azurecr.io*.<br>

Tag the image using the [docker tag](https://docs.docker.com/engine/reference/commandline/tag/) command. Replace `<login-server>` with the login server name of your ACR instance.

```azurecli
docker tag mcr.microsoft.com/hello-world <login-server>/hello-world:v1
```

For example:

```azurecli
docker tag mcr.microsoft.com/hello-world newregistryapl.azurecr.io/hello-world:v1
```

:::image type="content" source="../media/tag-registry-command-line-39dcbb2b.png" alt-text="Displays a screenshot of the docker tag.":::


Use [docker push](https://docs.docker.com/engine/reference/commandline/push/) to push the image to the registry instance. Replace `<login-server>` with the sign-in server name of your registry instance. This example creates the **hello-world** repository, containing the `hello-world:v1 image`.<br>

```azurecli
docker push <login-server>/hello-world:v1
```

For example:

```azurecli
docker push newregistryapl.azurecr.io/hello-world:v1
```

:::image type="content" source="../media/image-push-registry-2ab96304.png" alt-text="Displays a screenshot of the docker push.":::


After pushing the image to your container registry, remove the `hello-world:v1 image` from your local Docker environment. The [docker rmi](https://docs.docker.com/engine/reference/commandline/rmi/) command doesn't remove the image from the **hello-world** repository in your Azure container registry.

```azurecli
docker rmi <login-server>/hello-world:v1
```
