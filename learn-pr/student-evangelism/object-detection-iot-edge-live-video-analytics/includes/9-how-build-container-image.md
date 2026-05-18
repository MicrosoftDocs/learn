This module builds a Docker container with a pre-trained YOLO model and deploys that container as an IoT Edge module. The original exercise used sample assets from a Live Video Analytics repository that's no longer available from the stated URL. For a current lab, use maintained model assets or your own checked-in Dockerfile, model files, and label file.

## Create a container image

You can push and pull container images with Azure Container Registry using Azure CLI and, when your environment has it, the Docker CLI. Azure portal integration allows you to inspect the container images in your container registry visually.

A Dockerfile is a text file that provides the build instructions used to build and run a Docker image. Choose the path that matches your environment:

- **Azure Cloud Shell or another Azure CLI-only environment:** Use Azure Container Registry Tasks with `az acr build` to build and push the image in Azure without a local Docker installation or normal `az acr login`.
- **Docker-enabled local, WSL, macOS, or Linux environment:** Use `docker buildx build --platform <target-platform> --load`, `docker tag`, `docker push`, and normal `az acr login`. These commands require the Docker CLI and Docker daemon to be installed and running. Normal `az acr login` uses the Docker client to cache a registry token, so it isn't the Cloud Shell path for a Docker push.

## Create an Azure container registry

Use Azure Container Registry to store and manage a container image. Create a registry with the **az acr create** command. The registry name must be globally unique and contain 5-50 lowercase alphanumeric characters. Azure CLI-only commands such as creating the registry can run in Azure Cloud Shell.

```azurecli
az acr create --resource-group <resource-group> --name <registry-name> --sku Basic
```

After creating the registry, capture the actual login server from Azure instead of assuming a fixed value:

```azurecli
az acr show --name <registry-name> --query loginServer --output tsv
```

The login server is the fully qualified registry name, such as `<registry-name>.azurecr.io` or a Domain Name Label-protected value that includes a generated hash.

## Push image to container registry

Use this image URI format when you build or tag an image for the registry:

```text
<login-server>/<repository>:<tag>
```

### Cloud Shell-compatible build and push with ACR Tasks

From the directory that contains your Dockerfile and model assets, use `az acr build` to build in Azure and push directly to your registry. Set the platform to match the IoT Edge host that'll run the module. The examples use `linux/amd64`, which matches the common Ubuntu VM path in this module. Use `linux/arm64` instead for an ARM64 edge device.

```azurecli
az acr build --platform linux/amd64 --registry <registry-name> --image <repository>:<tag> --file Dockerfile .
```

For a registry that uses **RBAC Registry + ABAC Repository Permissions**, specify source-registry authentication explicitly when the quick build should use the caller's repository permissions for source registry access:

```azurecli
az acr build --platform linux/amd64 --registry <registry-name> --image <repository>:<tag> --file Dockerfile --source-acr-auth-id [caller] .
```

Use `--source-acr-auth-id none` only when the quick build intentionally needs no source-registry access. The caller must also have the appropriate repository role for any source repository it reads.

This command doesn't require a local Docker daemon, `docker buildx build`, `docker tag`, `docker push`, or normal `az acr login`. To queue and run the quick build, the Azure identity needs `Container Registry Tasks Contributor` or a broader role that includes ACR Tasks actions. That role doesn't grant image push or pull permissions. For ABAC quick builds or runs, also assign `Container Registry Repository Catalog Lister` with the needed repository role: `Container Registry Repository Writer` or `Container Registry Repository Contributor` for the target repository, and `Container Registry Repository Reader` for any source repository that the task reads. If the registry uses **RBAC Registry Permissions** instead, use `AcrPush` or `AcrPull` as appropriate. For more information, see [Microsoft Entra-based repository permissions](/azure/container-registry/container-registry-rbac-abac-repository-permissions).

### Docker-enabled build and push

For interactive development pushes from a Docker-enabled environment, sign in with your Azure identity and use `az acr login`. Normal `az acr login` requires the Docker CLI and Docker daemon to be installed and running. The identity that pushes images should have `Container Registry Repository Writer` if the registry uses **RBAC Registry + ABAC Repository Permissions**, or `AcrPush` if it uses **RBAC Registry Permissions**. Docker CLI pushes don't require `Container Registry Tasks Contributor`.

```azurecli
az login
az acr login --name <registry-name>
```

Then build, tag, and push the image with Docker:

```bash
docker buildx build --platform <target-platform> --load -t <repository>:<tag> .
docker tag <repository>:<tag> <login-server>/<repository>:<tag>
docker push <login-server>/<repository>:<tag>
```

Use `linux/amd64` when the target IoT Edge VM is AMD64, which is the common Ubuntu VM path in this module. Use `linux/arm64` when the target IoT Edge host is ARM64.

### Create least-privilege pull credentials

Before you add the module in the IoT Edge portal, create pull-only credentials for the registry. The **Container Registry Credentials** fields use these values:

- **Address:** `<login-server>`
- **Username:** The returned service principal `appId` or the token name.
- **Password:** The returned service principal `password` or the generated token password.

Store the password securely, such as in Azure Key Vault, because you can't retrieve the same generated value later.

Choose one option:

- **Service principal (AcrPull role):** If your registry uses **RBAC Registry Permissions**, create a service principal with `AcrPull`.

  ```azurecli
  ACR_ID=$(az acr show --name <registry-name> --query id --output tsv)
  az ad sp create-for-rbac --name <sp-name> --scopes $ACR_ID --role acrpull
  ```

  Use the returned `appId` as **Username** and `password` as **Password**.

- **ACR token with a repository scope map:** If you want pull-only access to a specific repository, create a scope map and token.

  ```azurecli
  az acr scope-map create --name <scope-map-name> --registry <registry-name> --repository <repository> content/read metadata/read
  ACR_TOKEN_PASSWORD=$(az acr token create --name <token-name> --registry <registry-name> --scope-map <scope-map-name> --query "credentials.passwords[0].value" --output tsv)
  ```

  Use `<token-name>` as **Username** and `$ACR_TOKEN_PASSWORD` as **Password**.

Managed identity authentication to ACR is for supported Azure hosts that sign in directly to ACR, not for the username/password registry credentials used in this IoT Edge flow. The Azure Container Registry admin account is disabled by default, has broad push and pull access, and should only be enabled for short testing scenarios if no better option is available. For more information, see [Azure Container Registry authentication with service principals](/azure/container-registry/container-registry-auth-service-principal) and [Non-Microsoft Entra token-based repository permissions in Azure Container Registry](/azure/container-registry/container-registry-token-based-repository-permissions).

## Deploy to IoT Edge as edge module

After pushing the image to your container registry, provide the image URI in the form `<login-server>/<repository>:<tag>` when you add the IoT Edge module.

If your module implements the same interface as the historical Tiny YOLO sample, the prediction endpoint can be accessed from within the IoT Edge deployment through:

```text
http://<module-name>:80/score
```

This endpoint is internal to the edge device's module network. Don't expose it directly to the internet.

## Steps to follow

The overall steps are:

1. Choose maintained model assets and a Dockerfile.
2. Create an Azure container registry with a valid lowercase alphanumeric name.
3. Build and push the image with `az acr build` from Cloud Shell or another Azure CLI-only environment, or use Docker commands from a Docker-enabled local, WSL, macOS, or Linux environment.
4. Configure least-privilege registry pull access for IoT Edge.
5. Deploy the containerized model as an IoT Edge module.
