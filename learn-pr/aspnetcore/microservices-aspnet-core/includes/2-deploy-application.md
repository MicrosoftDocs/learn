In this unit, you'll use a script to deploy the existing *:::no-loc text="eShopOnContainers":::* app to Azure Kubernetes Service (AKS).

## Open the development environment and create the Azure resources

> [!NOTE]
> If you wish to use GitHub Codespaces, navigate to [your codespaces for the MicrosoftDocs/mslearn-aspnet-core repository](https://github.com/MicrosoftDocs/mslearn-aspnet-core/codespaces). Create a new codespace using the `main` branch, and then skip to step 4.

1. In a terminal, run the following command to clone the repo for this module:

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-aspnet-core
    ```

1. Switch to the source code directory and launch Visual Studio Code:

    ```bash
    cd mslearn-aspnet-core
    code .
    ```

1. Visual Studio Code opens. When prompted, select **Reopen in Container** to open the repo in a development container.

    > [!TIP]
    > If you miss the prompt to reopen in container, press <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd> to open the command palette, and then search for and select **Remote-Containers: Reopen in Container**.

1. After the project loads in the container, right-click the **TO-DO: this step to open terminal (and screenshot)**

1. Sign in to the Azure CLI.

    ```az-cli
    az login
    ```

1. View your selcted Azure subscription. 

    ```az-cli
    az account show -o table
    ```

    If the wrong subscription is selected, select the correct one using the [az account set](/cli/azure/account?view=azure-cli-latest#az-account-set) command.

1. Run the quickstart script:

    ```bash
    ./modules/microservices-aspnet-core/deploy/k8s/quickstart.sh
    ```

    The preceding command retrieves and runs a setup script from a GitHub repository. The script completes the following steps:

    * Provisions AKS and Azure Container Registry resources.
    * Deploys the containers to a fully managed Kubernetes service in Azure, known as AKS.
    * Displays connection information upon completion.

    The script deploys a modified version of the *:::no-loc text="eShopOnContainers":::* [reference app](https://github.com/dotnet-architecture/eshoponcontainers). While the script is running, continue to the next unit to review the *:::no-loc text="eShopOnContainers":::* architecture.

