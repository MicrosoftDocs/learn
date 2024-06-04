> [!NOTE]
> You need access to an Azure subscription where you can create resources to complete this module.

You use an Azure Kubernetes Service (AKS) cluster to host the pet store front solution. The DevOps team uses standard declarative YAML files to deploy various services in the solution. In the current deployment workflow, the development teams create the deployment files for each application. The team is reviewing Helm as an alternative to simplify the management of cloud-native application deployments.

In this exercise, you'll configure the environment for use throughout this module. You'll install and configure the following resources:

- Clone the GitHub repository that contains the sample application
- Create an Azure resource group to hold the resources for the solution
- Create an Azure Container Registry (ACR) to store the container images
- Create an Azure Kubernetes Service (AKS) cluster to host the application
- Connect to the AKS cluster using the Azure CLI

## Set up the environment

### Clone the sample application

1. Navigate to the [Azure Cloud Shell](https://shell.azure.com) and make sure you're using the Bash environment.
2. Set the subscription you want to use for this module using the `az account set` command.

    ```azurecli-interactive
    az account set --subscription <subscription-name>
    ```

3. Clone the [sample application](https://github.com/Azure-Samples/aks-store-demo) to your development environment using the `git clone` command.

    ```bash
    git clone https://github.com/Azure-Samples/aks-store-demo.git
    ```

4. Change into the cloned directory using `cd`.

    ```bash
    cd aks-store-demo
    ```

### Create Azure resources

1. Create a resource group using the `az group create` command.

    ```azurecli-interactive
    az group create --name <resource-group-name> --location <location>
    ```

2. Create an Azure container registry using the `az acr create` command and provide your own unique registry name. The registry name must be unique within Azure and contain 5-50 alphanumeric characters.

    ```azurecli-interactive
    az acr create --resource-group <resource-group-name> --name <acr-name> --sku Basic
    ```

3. Create an AKS cluster using the `az aks create` command and attach the ACR to the AKS cluster using the `--attach-acr` parameter.

    ```azurecli-interactive
    az aks create --resource-group <resource-group-name> --name <aks-cluster-name> --node-count 2 --attach-acr <acr-name> --generate-ssh-keys
    ```

4. Connect to the AKS cluster using the `az aks get-credentials` command.

    ```azurecli-interactive
    az aks get-credentials --resource-group <resource-group-name> --name <aks-cluster-name>
    ```

5. Verify the connection to the AKS cluster using the `kubectl get nodes` command.

    ```bash
    kubectl get nodes
    ```
