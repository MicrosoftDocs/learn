
Azure Kubernetes Service (AKS) simplifies deploying a managed Kubernetes cluster in Azure by offloading the operational overhead to Azure. As a hosted Kubernetes service, Azure handles critical tasks, like health monitoring and maintenance. When you create an AKS cluster, a control plane is automatically created and configured. This control plane is provided at no cost as a managed Azure resource abstracted from the user.<br>

AKS nodes run on Azure virtual machines (VMs). With AKS nodes, you can connect storage to nodes and pods, upgrade cluster components, and use GPUs. AKS supports Kubernetes clusters that run multiple node pools to support mixed operating systems and Windows Server containers.

When you deploy an AKS cluster, you specify the number and size of the nodes, and AKS deploys and configures the Kubernetes control plane and nodes. [Advanced networking](/azure/aks/concepts-network), [Azure Active Directory (Azure AD) integration](/azure/aks/managed-azure-ad), [monitoring](/azure/aks/monitor-aks), and other features can be configured during the deployment process.

1.  Sign in to the Azure portal at [https://portal.azure.com](https://portal.azure.com/).
2.  On the Azure portal menu or from the **Home** page, select **Create a resource.**
3.  In the **Categories** section, select **Containers** &gt; **Azure Kubernetes Service (AKS).**:::image type="content" source="../media/create-new-azure-kubernetes-service-957cc050.png" alt-text="Displays a screenshot for how to create a resource.":::
    

4.  On the **Basics** page, configure the following options:
     -  **Project details**:
         -  Select an Azure **Subscription**.
         -  Create an Azure **Resource group**, such as *myResourceGroup*. While you can select an existing resource group, for testing or evaluation purposes, we recommend creating a resource group to temporarily host these resources and avoid impacting your production or development workloads.
     -  **Cluster details**:
         -  Ensure that the **Preset configuration** is *Standard ($$)*.
         -  Enter a **Kubernetes cluster name**, such as *NewCluster*.
         -  Select a **Region** for the AKS cluster, and leave the default value selected for **Kubernetes version**.
     -  **Primary node pool details**:
         -  Ensure that the node size is **Standard B2ms**.
         -  Ensure that **Scale method** is set to **Manual**.
         -  Set the **node count** to **1**.

Select **Next: Node pools**.

5.  On the **Node pools** page, select **Enable virtual nodes.**
    
    :::image type="content" source="../media/node-pool-enable-virtual-nodes-e88b6029.png" alt-text="Displays a screenshot of the existing node pool.":::
    
    
    Select **Next: Access.**

6.  On the **Access** page, leave the default options and then select **Next: Networking.**
    
    :::image type="content" source="../media/access-config-kubernetes-service-e6884808.png" alt-text="Displays a screenshot of the Networking configuration settings.":::
    

7.  On the **Networking** page, select or create a new virtual network.
    
    :::image type="content" source="../media/virtual-network-subnets-defaults-c026625e.png" alt-text="Displays a screenshot of the default network settings.":::
    
    
    Select **Next: Integrations.**

8.  In the **Integrations** page, select the Azure container registry you created in the previous module.
    
    :::image type="content" source="../media/integrations-existing-container-registry-99632253.png" alt-text="Displays a screenshot of the integration settings with an existing container registry.":::
    

Select **Next: Advanced**

9.  On the **Advanced** page, accept the default options and select **Tags**.
10. On the **Tags** page, accept the default options and select **Tags** **Review + create**.
11. Accept the defaults then select **Review + create**.
12. If validation passes, you can proceed to create the AKS cluster by selecting **Create**. If validation fails, then it indicates which settings need to be modified.:::image type="content" source="../media/summary-review-create-cd9baf32.png" alt-text="Displays a screenshot of the overall configuration settings prior to creation.":::
    

13. It takes a few minutes to create the AKS cluster. When your deployment is complete, navigate to your resource by either:
    
    
     -  Selecting **Go to resource**, or
     -  Browsing to the AKS cluster resource group and selecting the AKS resource. For this demonstration, browse for *RG\_AKS* and select the resource *newcluster1*.

14. To connect to the cluster, select **Connect**.
    
    :::image type="content" source="../media/connect-to-cluster-43923774.png" alt-text="Displays a screenshot of the how to connect to the cluster.":::
    

15. From the **Cloud Shell** tab, select **Open Cloud Shell**.:::image type="content" source="../media/connect-to-cluster-cloud-shell-ff48198c.png" alt-text="Displays a screenshot for how to connect to the cluster using Cloud Shell.":::
    
16. Copy the commands to the Cloud Shell terminal to set the cluster subscription and download the cluster credentials.:::image type="content" source="../media/connect-to-cluster-cloud-shell-success-cf2fbb87.png" alt-text="Displays a screenshot of the authentication process.":::
    

17. Experiment with the sample **kubectl** commands. You can use the `kubectl get deployments --all-namespaces=true`to list all deployments in all of namespaces. :::image type="content" source="../media/connect-to-cluster-cloud-shell-list-9c13868a.png" alt-text="Displays a screenshot for the list of deployments.":::
    
