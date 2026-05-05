Use this Try-This exercise to gain some hands-on experience with Azure Container Registry.

Now you can pull and run the `hello-world:v1` container image from your container registry by using [docker run](https://docs.docker.com/engine/reference/commandline/run/):

> [!IMPORTANT]
> Run these Docker commands in a local terminal with the Azure CLI, Docker CLI, and Docker daemon running. Azure Cloud Shell isn't suitable because it doesn't run the Docker daemon.

The `az acr login` command caches credentials for Docker, and the ACR token is valid for 3 hours. Rerun `az acr login --name <registry-name>` if the token expired, Docker authentication fails, or you're unsure you're authenticated. Use the registry resource name, not the login server.

After repository roles are assigned, Azure role assignment changes can take up to 10 minutes to take effect. If `az acr login`, `docker run`, or `docker pull` fails with a 401 or 403 error shortly after assignment, wait and retry. If needed, sign out and in again or rerun `az acr login` to refresh credentials.

```azurecli
az acr login --name <registry-name>
```

Replace `<login-server>` with the exact **Login server** value shown for your registry in the Azure portal.The default Tenant Reuse/DNL registry created in this module uses `<registry-name>-<hash>.azurecr.io`. A registry created with the Unsecure/non-DNL option uses `<registry-name>.azurecr.io` instead.

```console
docker run --rm <login-server>/hello-world:v1
```

Default Tenant Reuse/DNL example format (substitute your actual **Login server** value from the portal):

```console
docker run --rm <registry-name>-<hash>.azurecr.io/hello-world:v1
```

Unsecure/non-DNL only: if you intentionally used that option, the equivalent target uses `<registry-name>.azurecr.io/hello-world:v1`. Don't use this format for the default Tenant Reuse/DNL path.

```console
docker run --rm <registry-name>.azurecr.io/hello-world:v1
```

The `hello-world` image prints output and then exits. It doesn't start a long-running service or expose a public endpoint.
