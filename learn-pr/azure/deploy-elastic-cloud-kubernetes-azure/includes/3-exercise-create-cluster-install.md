An AKS cluster with Kubernetes operator lets you deploy complex applications on Kubernetes with increased control over the infrastructure and greater efficiency. Recall that in the Tailwind Traders example, you need to set up an AKS cluster to deploy Elastic Cloud on Kubernetes on AKS. Here, we'll walk through the steps for creating an AKS cluster and installing Elastic Cloud on Kubernetes operator.

## Begin in the Azure portal

1. Start by creating an AKS cluster through the Azure portal
    1. Choose your subscription
    1. Create a new resource group named *elastic-on-azure-rg*
    1. Provide a name for the AKS cluster, such as *elastic-on-aks-cluster*
    1. Choose the region closest to you
    1. Select the default Kubernetes version
    1. Use the standard node size and set the node count to 3

    :::image type="content" source="../media/3-create-kubernetes-cluster-dialog.png" alt-text="A screenshot of the Create a Kubernetes cluster window in the Azure portal.":::

1. After configuring your AKS cluster, proceed to **Review + create** from this screen.

1. Once your AKS cluster deployment is complete, select **Overview** from the side menu to view the details of your newly created cluster.

    :::image type="content" source="../media/cluster-overview.png" alt-text="A screenshot of the Kubernetes services Overview menu in Azure":::

1. Select **Connect** at the top to open a commands screen.

1. Copy the two commands provided on the connect screen.

1. Open Azure Cloud Shell and paste the commands to connect Elastic Cloud on Kubernetes to your AKS cluster.

    :::image type="content" source="../media/cluster-connection.png" alt-text="A screenshot of components provided to connect Elastic Cloud on Kubernetes to the AKS cluster.":::

1. Next, run the kubectl apply -f command with the following yaml file in Azure Cloud Shell to install the Kubernetes operator, Elastic Cloud on Kubernetes, and apply custom resource definitions and RBAC rules to the cluster.

    ```bash
    kubectl create -f https://download.elastic.co/downloads/eck/2.1.0/crds.yaml
    kubectl apply -f https://download.elastic.co/downloads/eck/2.1.0/operator.yaml
    ```

    :::image type="content" source="../media/kubectl-apply-output.png" alt-text="An image of the CLI after installing Elastic Cloud on Kubernetes with custom resources definitions and RBAC rules.":::
