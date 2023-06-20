In this unit, you use a script to deploy the existing *:::no-loc text="eShopOnContainers":::* app to Azure Kubernetes Service (AKS). Using a script keeps the focus on the learning objectives. The script outputs colored text to indicate the commands being executed. You can inspect the script and the output to better understand the commands used.

The following diagram shows the app's solution architecture. This module focuses on adding continuous integration and continuous deployment (CI/CD) for the coupon microservice.

:::image type="content" source="../media/2-setup-environment/eshop-architecture.png" alt-text="Diagram that shows the eShopOnContainers solution architecture."  border="false" lightbox="../media/2-setup-environment/eshop-architecture.png":::

The quickstart script completes the following steps to deploy an updated version of the [*:::no-loc text="eShopOnContainers":::*](https://github.com/dotnet-architecture/eshoponcontainers) app.

- Provisions AKS and Azure Container Registry resources.
- Deploys the containers to the fully managed AKS service.
- Displays connection information upon completion.

## Create the Azure resources in the dev environment

1. In a new browser window, fork the [MicrosoftDocs/mslearn-microservices-devops-aspnet-core](https://github.com/MicrosoftDocs/mslearn-microservices-devops-aspnet-core) repository to your own GitHub account. For instructions, see [Fork a repo](https://docs.github.com/get-started/quickstart/fork-a-repo).

1. Set up the dev environment.

   - To use GitHub Codespaces, create a new codespace using the `main` branch of your forked repository.

   - To use Visual Studio Code:
     1. Make sure Docker is running. In a new Visual Studio Code window, press <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd> to open the command palette.
     1. Search for and select **Dev Containers: Clone Repository in Container Volume**.
     1. Select your forked repository and branch. Visual Studio Code creates your development container.

1. After the project loads in the container, expand the *deploy/k8s* directory in the Visual Studio Code **Explorer** pane. This directory contains the scripts to use in this module.

   > [!NOTE]
   > By default, Visual Studio Code **Explorer** displays *k8s* on the same line as *deploy* because *deploy*  contains only the *k8s* subdirectory.
   
1. Right-click the *k8s* directory and select **Open in Integrated Terminal**.

   ![Screenshot of the Explorer pane in Visual Studio Code, showing the context menu for the k8s folder with Open in Integrated Terminal selected.](../media/2-setup-environment/k8s-path.png)

1. In the new terminal pane, sign in to the Azure CLI. If you use GitHub Codespaces, include the `--use-device-code` flag and follow the prompts. If you use Visual Studio Code, the flag is optional.

   ```azurecli
   az login --use-device-code
   ```

1. View the selected Azure subscription.

   ```azurecli
   az account show -o table
   ```

   If the wrong subscription is selected, use the [az account set](/cli/azure/account#az-account-set) command to select the correct one.

1. Run the quickstart script:

   ```bash
   ./quickstart.sh
   ```

   [!INCLUDE[Quickstart note](../../includes/microservices/quickstart.md)]

