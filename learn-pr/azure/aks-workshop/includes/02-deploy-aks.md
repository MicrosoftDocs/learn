Azure has a managed Kubernetes service, Azure Kubernetes Service (AKS). You'll use this to easily deploy a Kubernetes cluster.

[!include[](../../../includes/azure-exercise-subscription-prerequisite.md)]
[!include[](../../../includes/azure-cloudshell-copy-paste-tip.md)]

## Create a new resource group

1. Sign into the [Azure Cloud Shell](https://shell.azure.com/?azure-portal=true) with your Azure account.

1. Create a new resource group with the name **aksworkshop** so that it will be easier to clean up these resources when you are finished with the module. If you choose a different resource group name, remember it for the rest of the exercises in this module. You also need to choose a region in which you want to create the resource group, for example **East US**.

    ```azurecli
    az group create \
        --name aksworkshop \
        --location eastus
    ```

## Configure networking

In Azure Kubernetes Service (AKS), you can deploy a cluster that uses one of the following two network models:

* **Kubenet networking** - This is the default model. With kubenet, nodes get an IP address from the Azure virtual network subnet. Pods receive an IP address from a logically different address space to the Azure virtual network subnet of the nodes. Network address translation (NAT) is then configured so that the pods can reach resources on the Azure virtual network. The source IP address of the traffic is NAT'd to the node's primary IP address, then configured on the nodes, and pods receive an IP address "hidden" behind the node IP.

* **Azure Container Networking Interface (CNI) networking** - The AKS cluster is connected to existing virtual network resources and configurations. With Azure Container Networking Interface (CNI), every pod gets an IP address from the subnet and can be accessed directly. These IP addresses must be unique across your network space, and must be planned in advance.

Some of the features you're going to be using requires you to deploy the Azure Kubernetes Service (AKS) cluster using the *Azure Container Networking Interface (CNI) networking* configuration.

See [Network concepts for applications in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/azure/aks/concepts-network#azure-virtual-networks) for a more detailed comparison.

1. Create a virtual network and subnet. Pods deployed in the cluster will be assigned an IP from this subnet.

    ```azurecli
    az network vnet create \
        --resource-group aksworkshop \
        --name aks-vnet \
        --address-prefixes 10.0.0.0/8 \
        --subnet-name aks-subnet \
        --subnet-prefix 10.240.0.0/16
    ```

1. Retrieve and store the subnet ID in a Bash variable.

    ```azurecli
    SUBNET_ID=$(az network vnet subnet show \
        --resource-group aksworkshop \
        --vnet-name aks-vnet \
        --name aks-subnet \
        --query id -o tsv)
    ```

## Create the Azure Kubernetes Service (AKS) cluster

1. Get the latest, non-preview, Kubernetes version in your selected region, and store it in a Bash variable named `VERSION`.

    ```azurecli
    VERSION=$(az aks get-versions \
        --location eastus \
        --query 'orchestrators[?!isPreview] | [-1].orchestratorVersion' \
        --output tsv)
    ```

1. Your AKS cluster name must be unique. For learning purposes, run this command from Cloud Shell to create a Bash variable that holds a unique name.

    ```azurecli
    AKS_CLUSTER_NAME=aksworkshop-$RANDOM
    ```

1. Run the following `az aks create` command to create the Azure Kubernetes Service (AKS) cluster using the latest version. This should take a few minutes.

    ```azurecli
    az aks create \
    --resource-group aksworkshop \
    --name $AKS_CLUSTER_NAME \
    --location eastus \
    --kubernetes-version $VERSION \
    --network-plugin azure \
    --vnet-subnet-id $SUBNET_ID \
    --service-cidr 10.2.0.0/24 \
    --dns-service-ip 10.2.0.10 \
    --docker-bridge-address 172.17.0.1/16 \
    --generate-ssh-keys
    ```

    `$AKS_CLUSTER_NAME` specifies your AKS cluster name, `$VERSION` is the latest Kubernetes version retrieved before, `$SUBNET_ID` is the ID of the subnet created on the virtual network to be configured with AKS.

    Note the following deployment configuration:

    - **Network plugin**

        You're specifying the creation of the AKS cluster using the Azure Container Networking Interface (CNI) plugin.

    - **Kubernetes service address range**

        This is the set of virtual IPs that Kubernetes assigns to internal services in your cluster. The range must not be within the virtual network IP address range of your cluster. It should be different from the subnet created for the pods.

    - **Kubernetes DNS service IP address**

        The IP address for the cluster's DNS service. This address must be within the *Kubernetes service address range*. Don't use the first IP address in your address range, such as .1. The first address in your subnet range is used for the *kubernetes.default.svc.cluster.local* address.

    - **Docker Bridge address**

        The Docker bridge network address represents the default *docker0* bridge network address present in all Docker installations. While *docker0* bridge is not used by AKS clusters or the pods themselves, you must set this address to continue to support scenarios such as *docker build* within the AKS cluster. It is required to select a CIDR for the Docker bridge network address because otherwise Docker will pick a subnet automatically which could conflict with other CIDRs. You must pick an address space that does not collide with the rest of the CIDRs on your networks, including the cluster's service CIDR and pod CIDR.

## Ensure you can connect to the cluster using `kubectl`

1. When the `az aks create` command completes, retrieve the cluster credentials.

    ```azurecli
    az aks get-credentials \
        --resource-group aksworkshop \
        --name $AKS_CLUSTER_NAME
    ```

1. Let's take a look at what has been deployed by listing all the nodes in your cluster. To do this, you'll use the `kubectl` command. This is the main command-line tool you will use for working with Kubernetes. It is already installed in the Cloud Shell.

    ```bash
    kubectl get nodes
    ```

    You should see a list of your cluster's nodes. Here's an example.

    ```output
    NAME                       STATUS   ROLES   AGE  VERSION
    aks-nodepool1-24503160-0   Ready    agent   1m   v1.15.5
    aks-nodepool1-24503160-1   Ready    agent   1m   v1.15.5
    aks-nodepool1-24503160-2   Ready    agent   1m   v1.15.5
    ````

## Create a Kubernetes namespace for the application

Kubernetes provides features that let you logically isolate teams and workloads in the same cluster. The goal should be to provide the least number of privileges, scoped to the resources each team needs. A namespace in Kubernetes creates a logical isolation boundary. Names of resources need to be unique within a namespace, but not across namespaces.

If you don't specify the namespace when working with Kubernetes resources, the **default** namespace is implied. Let's create a namespace for the application we will deploy to our cluster.

1. List the current namespaces in the cluster.

    ```bash
    kubectl get namespace
    ```

    You should get a list of namespaces, similar to the following:

    ```output
    NAME              STATUS   AGE
    default           Active   1h
    kube-node-lease   Active   1h
    kube-public       Active   1h
    kube-system       Active   1h
    ```

1. You'll be using `kubectl create namespace` command to create a namespace for the application called **ratingsapp**.

    ```bash
    kubectl create namespace ratingsapp
    ```

    You will get a confirmation that the namespace was created.

    ```output
    namespace/ratingsapp created
    ```

Next, we'll create and configure Azure Container Registry to use with our AKS cluster.
