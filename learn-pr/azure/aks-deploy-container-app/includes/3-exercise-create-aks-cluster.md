
[//]: # (1. There are some things to consider with the structure of the exercise. It would help if you started with how what the learner is going to do here applies to the overall scenario instead of starting with the first H2 step. In this case, we want to deploy workloads, which means the creation of the cluster is one of those subtasks we need to complete to complete the main task. "How to deploy workloads declaratively?" Explore one of the architectural decisions you discussed in the previous unit.)

[//]: # (2. Create the cluster using the portal and drop the Azure CLI steps and the Powershell steps [You're repeating the Azure CLI info in the Powershell scripts instead of using New-AzAks]. In hindsight, we do not need the pivot.)

[//]: # (3. Keep the Linking with kubectl section as is, however, explain why we're doing this. Mention how this step configures the user's Kubernetes context. Make sure to call out the environment in which these steps execute. Avoid an instruction like this  one, "Open your preferred terminal [or use CloudShell]." Not all terminals are configured the same. Focus on cloud shell usage since all executables are already configured. Some students may prefer the macOS terminal, but may not have azure CLI install.)

[//]: # (4. Use the "azurecli" script tag when using CLI commands.)

[//]: # (5. General thoughts about using headers. In this unit, the user has two tasks. One, create a new AKS cluster and two, configure the user environment Kubernetes context. Create a header for these two main tasks you want the user to perform. Underneath each add H3 headers to describe the subtasks the user will perform. For example, create a resource group. Avoid titles with "-ing" words. Rewrite the titles that start with an -ing word. For example,  "Creating a network" -> "Create a network" )

[//]: # (5. Do not use the "Finish" heading.)

[//]:# (Make sure the red box has the proper size border, i.e., brush width 3px. https://review.docs.microsoft.com/en-us/help/contribute/contribute-how-to-create-screenshot?branch=master)

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

1. Link your Kubernetes cluster with `kubectl` with the following command

    ```azcli
    az aks get-credentials --name contoso-kubernetes-cluster --resource-group contoso-aks
    ```

## Testing the installation

1. Let's check if the cluster has been installed correctly by issuing the command:

    ```bash
    kubectl get nodes
    ```

    If the cluster is correct you should receive a list of three available nodes.
