In this unit, you'll use a script to deploy the existing *:::no-loc text="eShopOnContainers":::* app to Azure Kubernetes Service (AKS).

## Open the development environment and create the Azure resources

> [!NOTE]
> If you wish to use GitHub Codespaces, navigate to [your codespaces for the MicrosoftDocs/mslearn-aspnet-core repository](https://github.com/MicrosoftDocs/mslearn-aspnet-core/codespaces). Create a new codespace using the `main` branch, and then skip to step 3.

1. From a new Visual Studio Code window, press **Ctrl+Shift+P** to open the command palette, and then search for and select **Dev Containers: Clone Repository in Container Volume**.

1. Provide the following repository URL: `https://github.com/MicrosoftDocs/mslearn-aspnet-core`

    Visual Studio Code creates your development container.

1. After the project loads in the container, expand the *modules* directory, then *microservices-resiliency-aspnet-core*, and then finally *deploy*. Right-click on the *k8s* directory and select **Open in Integrated Terminal**. This location contains the scripts you're going to use in this module. By default, Code displays *k8s* on the same line as *deploy* because *deploy* only contains the *k8s* subdirectory.

    :::image type="content" source="../media/2-environment-setup/k8s-path.png" alt-text="Screenshot of the explorer pane in Visual Studio Code, with the context menu for the k8s folder displayed." border="true":::

1. In the new terminal pane, sign in to the Azure CLI. If you're using GitHub Codespaces, include the `--use-device-code` flag. If you're using Visual Studio Code, you can optionally omit the flag.

    ```azurecli
    az login --use-device-code
    ```

1. View your selected Azure subscription.

    ```azurecli
    az account show -o table
    ```

    If the wrong subscription is selected, use the [az account set](/cli/azure/account#az-account-set) command to select the correct one.

1. Run the quickstart script:

    [!INCLUDE[Quickstart note](../../includes/microservices/quickstart.md)]

    ```bash
    ./quickstart.sh
    ```

    The preceding command runs a script that completes the following steps:

    * Deploys the containers to a fully managed Kubernetes service in Azure, known as AKS.
    * Provisions AKS and Azure Container Registry resources.
    * Displays connection information upon completion.

    > [!TIP]
    > This unit uses scripts to keep focus on the learning objectives. The script outputs colored text to indicate the commands being executed. You can inspect the script and the output to better understand the commands used.

The script deploys a modified version of the *:::no-loc text="eShopOnContainers":::* [reference app](https://github.com/dotnet-architecture/eshoponcontainers). The following diagram shows the solution architecture of the app:

:::image type="content" source="../../media/microservices/eshop-architecture.png" alt-text="Diagram of the eShopOnContainers solution architecture." border="true" lightbox="../../media/microservices/eshop-architecture.png":::

This module focuses on adding resiliency to the coupon service depicted in the preceding diagram.

The script takes several minutes to complete. While the script runs, continue to the next unit to review resiliency concepts.
