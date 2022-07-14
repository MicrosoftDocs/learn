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
    > If you miss the prompt to reopen in container, press **Ctrl+Shift+P** to open the command palette, and then search for and select **Remote-Containers: Reopen in Container**.

1. After the project loads in the container, expand the *modules* directory, then *microservices-aspnet-core*, and then finally *deploy*. Right-click on the *k8s* directory and select **Open in Integrated Terminal**. This location contains the scripts you're going to use in this module. (Note: By default, Code will display *k8s* on the same line as *deploy* because *deploy* only contains subdirectories.) 

    ![Screenshot of the explorer pane in Visual Studio Code. The context menu for the k8s folder is displayed, and Open in Integrated Terminal is selected.](../media/2-deploy-application/k8s-path.png)

1. In the new terminal pane, sign in to the Azure CLI. If using GitHub Codespaces, include the `--use-device-code` flag. If you are using Visual Studio Code, you may optionally omit the flag.

    ```az-cli
    az login --use-device-code
    ```

1. View your selected Azure subscription. 

    ```az-cli
    az account show -o table
    ```

    If the wrong subscription is selected, select the correct one using the [az account set](/cli/azure/account#az-account-set) command.

1. Run the quickstart script:

    ```bash
    ./quickstart.sh
    ```

    The preceding command runs a script that completes the following steps:

    * Provisions AKS and Azure Container Registry resources.
    * Deploys the containers to a fully managed Kubernetes service in Azure, known as AKS.
    * Displays connection information upon completion.

    > [!TIP]
    > This unit uses scripts to keep focus on the learning objectives. The script outputs colored text to indicate the commands being executed. You can inspect the script and the output to better understand the commands used.

    The script deploys a modified version of the *:::no-loc text="eShopOnContainers":::* [reference app](https://github.com/dotnet-architecture/eshoponcontainers). While the script is running, continue to the next unit to review the *:::no-loc text="eShopOnContainers":::* architecture.


