Azure has a managed Kubernetes service, Azure Kubernetes Service (AKS). You'll use the service to easily deploy a Kubernetes cluster.

[!include[](../../../includes/azure-exercise-subscription-prerequisite.md)]
[!include[](../../../includes/azure-cloudshell-copy-paste-tip.md)]

## Create a new resource group

1. Sign in to [Azure Cloud Shell](https://shell.azure.com/?azure-portal=true) with your Azure account.

1. Create a new resource group with the name **aksworkshop**. All resources created in these exercises are deployed in this resource group, which makes it easier to clean up the resources after you finish the module. You also need to choose a region where you want to create the resource group, for example, **East US**. If you select a different resource group name, remember it for the rest of the exercises in this module.

    ```azurecli
    az group create \
        --name aksworkshop \
        --location eastus
    ```

## Configure networking

In AKS, you can deploy a cluster that uses one of the following two network models:

* **Kubenet networking**: This network model is the default. With kubenet networking, nodes get an IP address from the Azure virtual network subnet. Pods receive an IP address from a logically different address space to the Azure virtual network subnet of the nodes. Network address translation (NAT) is then configured so that the pods can reach resources on the Azure virtual network. The source IP address of the traffic is translated to the node's primary IP address and then configured on the nodes. The pods receive an IP address that's "hidden" behind the node IP.

* **Azure Container Networking Interface (CNI) networking**: The AKS cluster is connected to existing virtual network resources and configurations. With Azure CNI, every pod gets an IP address from the subnet and can be accessed directly. These IP addresses must be unique across your network space and calculated in advance.

Some of the features you'll use require you to deploy the AKS cluster by using the *Azure Container Networking Interface networking* configuration.

For a more detailed comparison, see [Network concepts for applications in AKS](https://docs.microsoft.com/azure/aks/concepts-network#azure-virtual-networks).

1. Create a virtual network and subnet. Pods deployed in the cluster are assigned an IP from this subnet.

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

## Create the AKS cluster

1. Get the latest, non-preview, Kubernetes version in your selected region. Store it in a Bash variable named `VERSION`.

    ```azurecli
    VERSION=$(az aks get-versions \
        --location eastus \
        --query 'orchestrators[?!isPreview] | [-1].orchestratorVersion' \
        --output tsv)
    ```

1. Your AKS cluster name must be unique. Run the following command from Azure Cloud Shell to create a Bash variable that holds a unique name.

    ```azurecli
    AKS_CLUSTER_NAME=aksworkshop-$RANDOM
    ```

    > [!NOTE]
    > Make a note of the value stored in $AKS_CLUSTER_NAME by running `echo $AKS_CLUSTER_NAME`. You'll need it to reconfigure the variable in the future, if necessary.

1. Run the following `az aks create` command to create the AKS cluster by using the latest version. This command can take a few minutes to complete.

    ```azurecli
    az aks create \
    --resource-group aksworkshop \
    --name $AKS_CLUSTER_NAME \
    --vm-set-type VirtualMachineScaleSets \
    --load-balancer-sku standard \
    --location eastus \
    --kubernetes-version $VERSION \
    --network-plugin azure \
    --vnet-subnet-id $SUBNET_ID \
    --service-cidr 10.2.0.0/24 \
    --dns-service-ip 10.2.0.10 \
    --docker-bridge-address 172.17.0.1/16 \
    --generate-ssh-keys
    ```

    Let's review the variables in the previous command:

    - `$AKS_CLUSTER_NAME` specifies the name of the AKS cluster.
    - `$VERSION` is the latest Kubernetes version you retrieved earlier.
    - `$SUBNET_ID` is the ID of the subnet created on the virtual network to be configured with AKS.

    Note the following deployment configuration:

    - **VM set type**

        You're specifying that the cluster is created by using Virtual Machine Scale Sets. The Virtual Machine Scale Sets enable you to switch on the cluster autoscaler when needed.

    - **Network plug-in**

        You're specifying the creation of the AKS cluster by using the CNI plug-in.

    - **Kubernetes service address range**

        This address range is the set of virtual IPs that Kubernetes assigns to internal services in your cluster. The range must not be within the virtual network IP address range of your cluster. It should be different from the subnet created for the pods.

    - **Kubernetes DNS service IP address**

        The IP address is for the cluster's DNS service. This address must be within the *Kubernetes service address range*. Don't use the first IP address in the address range, such as 0.1. The first address in the subnet range is used for the *kubernetes.default.svc.cluster.local* address.

    - **Docker bridge address**

        The Docker bridge network address represents the default *docker0* bridge network address present in all Docker installations. AKS clusters or the pods themselves don't use *docker0* bridge. But you have to set this address to continue supporting scenarios such as *docker build* within the AKS cluster. It's required to select a classless inter-domain routing (CIDR) for the Docker bridge network address. If you don't set a CIDR, Docker chooses a subnet automatically. This subnet could conflict with other CIDRs. Choose an address space that doesn't collide with the rest of the CIDRs on your networks, which includes the cluster's service CIDR and pod CIDR.

## Test cluster connectivity by using `kubectl`

1. Retrieve the cluster credentials by running the `az aks create` command.

    ```azurecli
    az aks get-credentials \
        --resource-group aksworkshop \
        --name $AKS_CLUSTER_NAME
    ```

1. Let's take a look at what was deployed by listing all the nodes in your cluster. Use the `kubectl` command to list all the nodes. This command is the main command-line tool you use to work with Kubernetes. It's already installed in the cloud shell.

    ```bash
    kubectl get nodes
    ```

    You'll see a list of your cluster's nodes. Here's an example.

    ```output
    NAME                                STATUS   ROLES   AGE  VERSION
    aks-nodepool1-24503160-vmss000000   Ready    agent   1m   v1.15.7
    aks-nodepool1-24503160-vmss000001   Ready    agent   1m   v1.15.7
    aks-nodepool1-24503160-vmss000002   Ready    agent   1m   v1.15.7
    ````

## Create a Kubernetes namespace for the application

Kubernetes provides features that let you logically isolate teams and workloads in the same cluster. The goal is to provide the least number of privileges scoped to the resources each team needs. A namespace in Kubernetes creates a logical isolation boundary. Names of resources must be unique within a namespace but not across namespaces.

If you don't specify the namespace when you work with Kubernetes resources, the default namespace is implied. Let's create a namespace for your application.

1. List the current namespaces in the cluster.

    ```bash
    kubectl get namespace
    ```

    You get a list of namespaces similar to the following output:

    ```output
    NAME              STATUS   AGE
    default           Active   1h
    kube-node-lease   Active   1h
    kube-public       Active   1h
    kube-system       Active   1h
    ```

1. Use the `kubectl create namespace` command to create a namespace for the application called **ratingsapp**.

    ```bash
    kubectl create namespace ratingsapp
    ```

    You get a confirmation that the namespace was created.

    ```output
    namespace/ratingsapp created
    ```

Next, you create and configure an Azure Container Registry to use with your AKS cluster.
