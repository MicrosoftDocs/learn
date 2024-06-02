[!INCLUDE [azure-optional-exercise-subscription-note](../../../includes/azure-optional-exercise-subscription-note.md)]

In this exercise, you deploy virtual networks, subnets, and identities, and then deploy an Azure Kubernetes Service (AKS) cluster using the Azure Container Networking Interface (CNI) plugin.

You approached your company's IT department and provided the information you gathered about the application requirements, virtual machine (VM) sizing, and network sizing. The IT department provided some network address ranges that you can use for the cluster.

The following table lists the requirements and IP addresses provided by the IT department:

Item | Description | IP addresses
--- | --- | ---
AKS subnet | IP addresses for the nodes and pods in the cluster. 248 usable IP addresses required. | 10.150.20.0/24
Kubernetes service subnet | IP addresses used inside the cluster for Kubernetes services. Must not conflict with other virtual networks or on-premises networks. | 10.240.0.0/24
Domain Name System (DNS) service IP address | Must be in the Kubernetes service subnet, but can't be the first IP address from the available range. | 10.240.0.10

- For the **AKS subnet**, you determined that you need 248 usable IP addresses. Your IT department gave the network 10.150.20.0/24, which provides 251 usable IP addresses after accounting for the five addresses that Azure reserves in every subnet.
- The **Kubernetes service subnet** is a group of IP addresses that aren't used in any other Azure virtual networks and don't conflict with any on-premises network ranges. This address range is only ever used inside the cluster. Your IT department indicated you should use 10.240.0.0/24.
- The **DNS service IP address** is a single IP address within the **Kubernetes service subnet** range of addresses, but can't be the first IP address in that range. You decided to use 10.240.0.10 as the DNS IP address.

## Create the virtual network and subnet

For this exercise, you create a virtual network and subnet. In a real-world environment, you might have a team in your IT department responsible for managing networks and they might create these resources for you.

1. Launch [Azure Cloud Shell](https://shell.azure.com/bash).
1. If you aren't already signed in to Azure, then sign in to your Azure account using the `az login` command.

    ```bash
    az login
    ```

1. Choose an Azure region that is close to you, for example *eastus*. Store the value in an environment variable so you can use it in the rest of the exercise.

    ```bash
    AKSLocation=eastus
    ```

1. Create a resource group, *AKSLearn*, to hold the resources in this exercise using the `az group create` command.

    ```bash
    az group create --location $AKSLocation --name AKSLearn
    ```

1. Create a virtual network, *AKSVirtualNetwork*, using the `az network vnet create` command.

    ```bash
    az network vnet create \
        --name AKSVirtualNetwork \
        --resource-group AKSLearn \
        --address-prefixes 10.150.0.0/16  \
        --location $AKSLocation
    ```

1. Create a subnet, *AKSSubnet*, using the `az network vnet subnet create` command and specify the address range provided by the IT department.

    ```bash
    az network vnet subnet create \
        --resource-group AKSLearn \
        --vnet-name AKSVirtualNetwork \
        --name AKSSubnet \
        --address-prefixes 10.150.20.0/24
    ```

## Create an Azure managed identity

You need to create an Azure managed identity for AKS to use to access resources within your Azure subscription. The following two commands create an Azure Managed Identity, then store its unique ID value in an environment variable for later use.

1. Create an Azure managed identity, *AKSIdentity*, using the `az identity create` command.

    ```bash
    az identity create \
        --name AKSIdentity \
        --resource-group AKSLearn
    ```

1. Get the ID of the managed identity using the `az identity show` command and store it in an environment variable, *identityId*, to use in later commands.

    ```bash
    identityId=$(az identity show \
        --name AKSIdentity \
        --resource-group AKSLearn \
        --query id \
        --output tsv)
    ```

## Create an AKS cluster

1. Get the resource ID value of the subnet using the `az network vnet subnet list` command and store it in an environment variable, *subnetId*, to use in later commands.

    ```bash
    subnetId=$(az network vnet subnet list \
        --vnet-name AKSVirtualNetwork \
        --resource-group AKSLearn \
        --query "[?name=='AKSSubnet'].id" \
        --output tsv)
    ```

1. Create an AKS cluster, *AKSCluster*, using the `az aks create` command.

    ```bash
    az aks create \
        --name AKSCluster \
        --resource-group AKSLearn \
        --location $AKSLocation \
        --network-plugin azure \
        --vnet-subnet-id $subnetId \
        --service-cidr 10.240.0.0/24 \
        --dns-service-ip 10.240.0.10 \
        --generate-ssh-keys \
        --enable-managed-identity \
        --assign-identity $identityId \
        --node-vm-size  Standard_F8s_v2 \
        --node-count 3
    ```

    The following table describes the parameters used in the `az aks create` command:

    Parameter | Description
    --- | ---
    `--name` | The name of the cluster being created.
    `--resource-group` | The resource group where the cluster should be created.
    `--location` | The Azure region where the cluster should be created.
    `--network-plugin` | Specifies which network plugin to use.
    `--vnet-subnet-id` | Specifies the resource ID of the subnet to use.
    `--service-cidr` | Specifies the Kubernetes service address range to use.
    `--dns-service-ip` | Specifies the DNS IP address to use.
    `--generate-ssh-keys` | Creates a set of SSH keys that are used to secure the nodes.
    `--enable-managed-identity` | Enables use of Azure managed identity for access to resources in the Azure subscription.
    `--assign-identity` | Specifies the ID value of the Azure managed identity to use.
    `--node-vm-size` | Specifies the VM size to use.
    `--node-count` | Specifies the number of nodes to create.

1. Once the cluster successfully deploys, check the details of the node pool using the `az aks nodepool list` command.

    ```bash
    az aks nodepool list \
        --cluster-name AKSCluster \
        --resource-group AKSLearn \
        --output table
    ```

    Your output should look similar to the following example output:

    ```output
    Name       OsType    VmSize           Count    MaxPods    ProvisioningState    Mode
    ---------  --------  ---------------  -------  ---------  -------------------  ------
    nodepool1  Linux     Standard_F8s_v2  3        30         Succeeded            System
    ```

    From the output, you can see there are three Standard_F8s_v2 type nodes, a MaxPods value of 30, and a node pool mode of `System`.

## Confirm IP address usage for the cluster

- Check how many IP addresses are in use by the cluster using the `az network vnet subnet list` command.

    ```bash
    az network vnet subnet list \
        --vnet-name AKSVirtualNetwork \
        --resource-group AKSLearn \
        --query "[].ipConfigurations.length(@)" \
        --output table
    ```

    This command uses a JMESPath query string to determine how many `ipConfigurations` are defined in the subnet. the maximum output should be **93**. You deployed three nodes to start with, so each node has one IP address. You used the default value of 30 for the maximum pods, so each node has 30 IP addresses preallocated for pods to use. The total number of IP addresses allocated so far is `3 x nodes + (30 pods * 3 nodes) = 93`. However, some addresses are reserved so your output could be less.

## Add an extra node to the cluster

Let's see how the IP address usage is affected by stealing up the cluster and adding one more node.

1. Scale up the cluster and add one more node using the `az aks scale` command.

    ```bash
    az aks scale \
        --name AKSCluster \
        --resource-group AKSLearn \
        --node-count=4
    ```

1. Once the command successfully completes, confirm the new details of the node pool using the `az aks nodepool list` command.

    ```bash
    az aks nodepool list \
        --cluster-name AKSCluster \
        --resource-group AKSLearn \
        --output table
    ```

    Your output should look similar to the following example output, showing you now have four nodes.

    ```output
    Name       OsType    VmSize           Count    MaxPods    ProvisioningState    Mode
    ---------  --------  ---------------  -------  ---------  -------------------  ------
    nodepool1  Linux     Standard_F8s_v2  4        30         Succeeded            System
    ```

1. Check how many IP addresses are now in use by the cluster using the `az network vnet subnet list` command.

    ```bash
    az network vnet subnet list \
        --vnet-name AKSVirtualNetwork \
        --resource-group AKSLearn \
        --query "[].ipConfigurations.length(@)" \
        --output table
    ```

    This time, the maximum output should be **124**, which is 31 more than last time. That's one more IP address for the new node, plus another 30 IP addresses preallocated for the pods that run on that node. However, some addresses are reserved so your output could be less.
