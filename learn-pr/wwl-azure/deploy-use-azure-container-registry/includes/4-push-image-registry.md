Use this Try-This exercise to gain some hands-on experience with Azure Container Registry.

For this exercise, Docker commands are used to push a container image into the registry, and finally pull and run the image from your registry.

> [!IMPORTANT]
> Run this Docker-based workflow in a local terminal with the Azure CLI, Docker CLI, and Docker daemon running. Azure Cloud Shell isn't suitable because it doesn't run the Docker daemon.

You must also have Docker installed locally with the Docker daemon running. Docker provides packages that easily configure Docker on any [Mac](https://docs.docker.com/desktop/setup/install/mac-install/), [Windows](https://docs.docker.com/desktop/setup/install/windows-install/), or [Linux](https://docs.docker.com/engine/install) system.

> [!NOTE]
> To complete this procedure, you need an [Azure subscription](https://azure.microsoft.com/pricing/purchase-options/azure-account?cid=msft_learn).

To push an image to an Azure Container registry, you must first have an image. If you don't yet have any local container images, run the following [docker pull](https://docs.docker.com/engine/reference/commandline/pull/) command to pull an existing public image.

Pull the `hello-world` image from Microsoft Container Registry.

```console
docker pull mcr.microsoft.com/hello-world
```

The command downloads the `hello-world` image to your local Docker environment. If the image already exists locally, Docker reports that it's up to date.

Before you can push an image to your registry, tag it with the fully qualified **Login server** value shown for your registry in the Azure portal. Use the exact portal value for the Docker tag, push, and run commands. The default Tenant Reuse/DNL registry created in this module uses a login server in the `<registry-name>-<hash>.azurecr.io` format. A registry created with the Unsecure/non-DNL option uses `<registry-name>.azurecr.io` instead.

Tag the image using the [docker tag](https://docs.docker.com/engine/reference/commandline/tag/) command. Replace `<login-server>` with the exact **Login server** value of your ACR instance.

```console
docker tag mcr.microsoft.com/hello-world <login-server>/hello-world:v1
```

Default Tenant Reuse/DNL example format (substitute your actual **Login server** value from the portal):

```console
docker tag mcr.microsoft.com/hello-world <registry-name>-<hash>.azurecr.io/hello-world:v1
```

Unsecure/non-DNL only: if you intentionally used that option, the equivalent target uses `<registry-name>.azurecr.io/hello-world:v1`. Don't use this format for the default Tenant Reuse/DNL path.

```console
docker tag mcr.microsoft.com/hello-world <registry-name>.azurecr.io/hello-world:v1
```

A successful `docker tag` command typically returns no output.

Before pushing, make sure your Azure Container Registry authentication is still valid. `az acr login` caches credentials for Docker, and the ACR token is valid for 3 hours. Rerun `az acr login --name <registry-name>` if the token expired, Docker authentication fails, or you're unsure you're authenticated. Use the registry resource name, not the login server.

After repository roles are assigned, Azure role assignment changes can take up to 10 minutes to take effect. If `az acr login` or `docker push` fails with a 401 or 403 error shortly after assignment, wait and retry. If needed, sign out and in again or rerun `az acr login` to refresh credentials.

```azurecli
az acr login --name <registry-name>
```

Use [docker push](https://docs.docker.com/engine/reference/commandline/push/) to push the image to the registry instance. Replace `<login-server>` with the exact **Login server** value of your registry instance. This example creates the **hello-world** repository, containing the `hello-world:v1` image.

```console
docker push <login-server>/hello-world:v1
```

Default Tenant Reuse/DNL example format (substitute your actual **Login server** value from the portal):

```console
docker push <registry-name>-<hash>.azurecr.io/hello-world:v1
```

Unsecure/non-DNL only: if you intentionally used that option, the equivalent target uses `<registry-name>.azurecr.io/hello-world:v1`. Don't use this format for the default Tenant Reuse/DNL path.

```console
docker push <registry-name>.azurecr.io/hello-world:v1
```

The push output lists image layers and confirms that the `v1` tag was pushed to your registry.


After pushing the image to your container registry, remove the registry-tagged local image reference from your local Docker environment. The [docker rmi](https://docs.docker.com/engine/reference/commandline/rmi/) command removes the `<login-server>/hello-world:v1` local image reference. It doesn't remove the image from the **hello-world** repository in your Azure container registry, and the underlying local image might remain if another tag still points to it.

```console
docker rmi <login-server>/hello-world:v1
```
