Now we need to create our cluster so we can deploy Contoso's website. To do that, let's recall what we learned from the previous unit about cluster architectures. To make this deployment work we're going to need several nodes, because we need to meet the demand of customers, so let's use the "Single Control Plane and Multiple Nodes" architecture, since it provides the best way to create and manage the resources and meet the scaling demand

## Create a new cluster

The first action you need to take in order to create your cluster is to provision it within Azure. Provisioning an AKS cluster in Azure can be done in the Azure portal or through the Azure CLI.

[!INCLUDE [azure-exercise-subscription-prerequisite](../../../includes/azure-exercise-subscription-prerequisite.md)]

1. Log in to the Azure Cloud Shell with the account you wish to deploy resources into.

    > [!div class="nextstepaction"]
    > [Azure Cloud Shell](https://shell.azure.com/?azure-portal=true)

1. Run the following command to create a resource group that you'll use to deploy your resources into.

    ```azurecli
    az group create \
        --name contoso-aks \
        --location eastus
    ```

1. Run the following command to create an AKS cluster.

    ```azurecli
    az aks create \
        --resource-group contoso-aks \
        --name contoso-kubernetes-cluster \
        --node-count 3 \
        --enable-addons http_application_routing \
        --generate-ssh-keys \
        --dns-name-prefix contoso-kubernetes \
        --node-vm-size Standard_B2s
    ```

    In this command, we're telling Azure that we want to create a new AKS cluster named `contoso-kubernetes-cluster` within the `contoso-aks` resource group. This cluster will have 3 nodes defined in the `--node-count` parameter and we'll enable the HTTP application routing addon via the `--enable-addons` flag.

    We'll also tell it to generate local public and private SSH files to allow our access to the cluster if they're missing via the `--generate-ssh-keys` and we'll set the DNS name for our cluster to `contoso-kubernetes` using the `--dns-name-prefix` parameter.

    We're also specifying a small VM size of `Standard_B2s` using the `--node-vm-size` parameter.

## Link with kubectl

1. Link your Kubernetes cluster with `kubectl` by using the following command in Cloud Shell.

    ```azurecli
    az aks get-credentials \
        --name contoso-kubernetes-cluster \
        --resource-group contoso-aks
    ```

    This command will add an entry to your `~/.kube/config` file, which holds all the information to access the clusters you've registered. This allows you to manage multiple clusters from a single command line interface.

1. Run the following command to confirm your cluster was created successfully and that kubectl can connect to it.

    ```bash
    kubectl get nodes
    ```

    You should receive a list of three available nodes.
