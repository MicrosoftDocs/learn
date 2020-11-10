You use an Azure Kubernetes Service (AKS) cluster to host the drone tracking solution. The DevOps team uses standard declarative YAML files to deploy various services in the solution. In the current deployment workflow, the development teams create the deployment files for each application. The team is reviewing Helm as an alternative to simply the management of cloud-native application deployments.

In this exercise, you'll install an AKS cluster for the team test deployments using HELM. You'll use a script to create and configure your Azure Kubernetes Service (AKS) cluster.

The script performs the following configuration steps:

> [!div class="checklist"]
>
> - Select an Azure subscription to use with this modules exercises and set it as the default subscription.
> - Create an Azure Kubernetes service cluster by using the Azure CLI.
> - Configures a default Kubernetes NGINX Ingress controller and LoadBalancer.
> - Clone the example web app and Helm chart from a GitHub repository.
> - Captures all configuration values in `/home/*user*/clouddrive/mslearn-aks/create-aks-exports.txt` for easy reference.
> - [Optional] Create a Azure Container registry by using the Azure CLI.
> - [Optional] Configure an AKS cluster to authenticate to an Azure Container.
> - [Optional] Installs a newer version of the .NET Core SDK, alongside the default SDK version of Cloud Shell.

*Some of the above items are optional installation steps that are disabled in this exercise using command arguments.*

> [!IMPORTANT]
>
>This module doesn't make use of the MS Learn Sandbox. The summary unit includes instructions to clean up these resources created here. Please make sure to cleanup any resources created in this module to prevent unnessacery cost.
>
> Optional steps in the script install the required version of the .NET Core SDK alongside the version pre-installed in Azure Cloud Shell. To revert to the default configuration in Cloud Shell, see the instructions in the **Summary** unit.

## Run the deployment script

1. Open the Azure Cloud Shell in your browser.

1. Select a folder with access to the Azure subscription in which you want to create resources.

1. Select *Bash* from the environment drop-down in the upper left.

    You'll use the `setup.sh` script to deploy a new cluster. The deployment script uses the following parameters:

    | Parameter | Description |
    | --- | --- |
    | `-s` | Identifies the subscription ID to use. |
    | `-n` | Identifies the AKS cluster name and resource groupe used to create the cluster in the context of this module. |
    | `--use-acr` | Allows the script to configure a default ACR with the name `mslearn-kubernetes-acr`. Default value is `false`.
    | `--install-dot-net` | Allows the script to install the .NET Core SDK. Default value is set to `false`. |

    Replace the `<your-subscription-id>` placeholder with your selected subscription ID in the code below. If you don't know the subscription ID to use, run the command without the subscription parameter. The output will list all available subscriptions you have access to in your account. Choose an appropriate subscription ID and rerun the script using this ID.

    Run the command below in the command shell.

    ```bash
    . <(wget -q -O - https://raw.githubusercontent.com/MicrosoftDocs/mslearn-aks/main/infrastructure/setup/setup.sh ) -s <your-subscription-id> -n learn-helm-deploy-aks --use-acr false --install-dot-net false
    ```

    [!include[](../../../includes/azure-cloudshell-copy-paste-tip.md)]

    Creating the AKS cluster takes a few minutes to complete. While the script is running, continue to the next unit.

## How to manage an unexpected failure

Non-blocking warnings are expected in the deployment process. If an unexpected exception occurs, you can reset any changes made by the script by running the following command:

```azurecli
cd ~ && \
   rm -rf ~/clouddrive/mslearn-aks && \
   az group delete --name learn-helm-deploy-aks-rg --yes
```
