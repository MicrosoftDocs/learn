Use this Try-This exercise to gain some hands-on experience with Azure Kubernetes Service.

Before pushing and pulling container images, you must log in to the registry instance. [Sign into the Azure CLI](/cli/azure/get-started-with-azure-cli) on your local machine, then run the [az acr login](/cli/azure/acr#az-acr-login) command. Specify only the registry resource name when login in with the Azure CLI.

> [!NOTE]
> Don't use the fully qualified sign-in server name.

> [!NOTE]
> To complete this procedure, you need an [Azure subscription](https://azure.microsoft.com/free/).

Sign into the Azure CLI on your local machine, then run the `az acr login` command.

```azurecli
az login
```

The output should resemble the image seen here.

:::image type="content" source="../media/login-azure-command-line-ba5fb6b3.png" alt-text="Screenshot of the command-line output for connecting to Azure.":::


Log in to the registry using the resource name.

```azurecli
az acr login --name <acrName>
```

Example:

```azurecli
az acr login --name newregistryapl
```

The command returns **Login Succeeded** once completed. The output should resemble the image seen here.

:::image type="content" source="../media/registry-login-success-command-line-b645c8b8.png" alt-text="Screenshot of the connection to Azure being a success.":::
