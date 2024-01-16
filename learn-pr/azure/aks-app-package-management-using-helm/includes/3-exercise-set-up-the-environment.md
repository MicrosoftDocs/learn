>[!NOTE]
> You'll need access to an Azure subscription where you can create resources to complete this module.

You use an Azure Kubernetes Service (AKS) cluster to host the drone tracking solution. The DevOps team uses standard declarative YAML files to deploy various services in the solution. In the current deployment workflow, the development teams create the deployment files for each application. The team is reviewing Helm as an alternative to simplify the management of cloud-native application deployments.

In this exercise, you'll install an AKS cluster for the team test deployments using HELM. You'll use a script to create and configure your Azure Kubernetes Service (AKS) cluster.

The script does the following configuration steps:

> [!div class="checklist"]
>
> - Select the subscription to use with this module's exercises and set it as the default subscription for all deployed resources.
> - Create an Azure Kubernetes service cluster by using the Azure CLI.
> - Configures a default Kubernetes NGINX Ingress controller and LoadBalancer.
> - Clone the example web app and Helm chart from a GitHub repository.
> - Captures all configuration values in `/home/*user*/clouddrive/mslearn-aks/create-aks-exports.txt` for easy reference.
> - [Optional] Create a Azure Container registry by using the Azure CLI.
> - [Optional] Configure an AKS cluster to authenticate to an Azure Container.
> - [Optional] Installs version 3.1.302 of the .NET SDK, alongside the default SDK version of Cloud Shell.

*Some of the above items are optional installation steps that are disabled in this exercise using command arguments.*

## Run the deployment script

You'll use a `bash` deployment script that uses the following parameters to deploy a new cluster:

| Parameter | Description |
| --- | --- |
| `-s` | Identifies the subscription ID to use. |
| `-n` | Identifies the AKS cluster name and resource groupe used to create the cluster in the context of this module. |
| `--use-acr` | Allows the script to configure a default ACR with the name `mslearn-kubernetes-acr`. Default value is `false`.
| `--install-dot-net` | Allows the script to install the .NET SDK. Default value is set to `false`. |

1. Sign in to your subscription in the Azure portal, then select the **Cloud Shell** button at the top of the screen.

1. Run the following command in the Azure Cloud Shell:

    ```bash
    SubscriptionId=$(az account list --query '[0].id' -o tsv)
    . <(wget -q -O - https://raw.githubusercontent.com/MicrosoftDocs/mslearn-aks/main/infrastructure/setup/setup.sh ) -s $SubscriptionId -n learn-helm-deploy-aks --use-acr false --install-dot-net false
    ```

    [!include[](../../../includes/azure-cloudshell-copy-paste-tip.md)]

    Creating the AKS cluster takes a few minutes to complete.

## How to manage an unexpected failure

Non-blocking warnings are expected in the deployment process. If an unexpected exception occurs, you can reset any changes made by the script by running the following command:

```azurecli
cd ~ && \
   rm -rf ~/clouddrive/mslearn-aks && \
   az group delete --name learn-helm-deploy-aks-rg --yes
```
