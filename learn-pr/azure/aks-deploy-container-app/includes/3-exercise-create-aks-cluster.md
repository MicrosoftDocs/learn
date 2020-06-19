[//]: # (4. Use the "azurecli" script tag when using CLI commands.)

[//]: # (5. General thoughts about using headers. In this unit, the user has two tasks. One, create a new AKS cluster and two, configure the user environment Kubernetes context. Create a header for these two main tasks you want the user to perform. Underneath each add H3 headers to describe the subtasks the user will perform. For example, create a resource group. Avoid titles with "-ing" words. Rewrite the titles that start with an -ing word. For example,  "Creating a network" -> "Create a network" )

[//]: # (5. Do not use the "Finish" heading.)

[//]:# (Make sure the red box has the proper size border, i.e., brush width 3px. https://review.docs.microsoft.com/en-us/help/contribute/contribute-how-to-create-screenshot?branch=master)

Now we need to create our cluster so we can deploy Contoso's website. To do that, let's recall what we learned from the previous unit about cluster architectures. To make this deployment work we're going to need several nodes, because we need to meet the demand of customers, so let's use the "Single Control Plane and Multiple Nodes" architecture, since it provides the best way to create and manage the resources and meet the scaling demand

## Create a new resource

[//]:# (Consider the create a resource steps as used in this module - https://docs.microsoft.com/en-us/learn/modules/intro-to-azure-virtual-machines/3-create-a-vm)

The first action you need to take in order to create your cluster is to provision it within Azure. Provisioning an AKS cluster in Azure can be done in the Azure portal or through the Azure CLI.

[!INCLUDE [azure-exercise-subscription-prerequisite](../../../includes/azure-exercise-subscription-prerequisite.md)]

1. Before creating an AKS cluster, it's necessary to create an Azure Resource Group, this group will hold all of the created resources:

    ```azcli
    az group create --name contoso-aks --location eastus
    ```

    If the group has been created successfully, you will receive the following response:

    ```json
    {
      "id": "/subscriptions/<guid>/resourceGroups/contoso-aks",
      "location": "eastus",
      "managedBy": null,
      "name": "contoso-aks",
      "properties": {
        "provisioningState": "Succeeded"
      },
      "tags": null
    }
    ```

    Then it's time to create the cluster.

2. Creating an AKS using bash resumes in issuing a single command using Azure CLI. Open your preferred terminal (or use CloudShell) and issue the following command:

    ```azcli
    az aks create --resource-group contoso-aks --name contoso-kubernetes-cluster --node-count 3 --enable-addons http_application_routing --generate-ssh-keys --dns-name-prefix contoso-kubernetes --node-vm-size Standard_B2s
    ```

## Linking with Kubectl

1. Link your Kubernetes cluster with `kubectl` with the following command in the CloudShell

    ```azcli
    az aks get-credentials --name contoso-kubernetes-cluster --resource-group contoso-aks
    ```

    This command will add an entry to your `~/.kube/config` file, which holds all the information to access the clusters you've registered. This way you can manage multiple clusters in multiple places with one single command line interface.

## Testing the installation

1. Let's check if the cluster has been installed correctly by issuing the command:

    ```bash
    kubectl get nodes
    ```

    If the cluster is correct you should receive a list of three available nodes.
