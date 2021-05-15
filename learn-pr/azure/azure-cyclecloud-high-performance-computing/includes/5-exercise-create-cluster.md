You can create new clusters directly from the graphical interface of the CycleCloud web application. CycleCloud offers many predefined, scheduler-specific templates, which considerably simplify cluster provisioning for the corresponding schedulers. 

Now that you have provisioned an Azure VM hosting the CycleCloud web applications, you are ready to evaluate its use for deployment of a Swarm-based HPC cluster into Azure. You first need to ensure that your Azure subscription will accommodate the cluster's resource requirements. You also want to consider that your management team wants to keep the cluster's cost within the project's budget. So, you plan to set up CycleCloud budget alerts and deprovision the lab environment once your evaluation is completed. 

## Prepare for the deployment of an HPC cluster

Before you deploy an HPC cluster, you should first ensure that you have sufficient network and compute resources to accommodate its usage. 

    > [!NOTE]
    > To complete this exercise, you actually do not need to satisfy quota requirements to accommodate provisioning of the compute nodes, since you will not be running any jobs on the cluster you create.

1. On your computer, switch to the web browser window displaying the Azure portal.
1. In the Azure portal, use the **Search resources, services, and docs** text box at the top of the portal interface to search for the **cyclecloud-rg** resource group.
1. In the Azure portal, on the **cyclecloud-rg** blade, in the list of resources, select the **cyclecloud-rg-vnet** entry, representing the virtual network you provisioned in the previous exercise of this module.
1. On the **cyclecloud-rg-vnet** blade, in the vertical menu on the left side, select **Subnets**.
1. On the **cyclecloud-rg-vnet \| Subnets** blade, select **+ Subnet**.
1. On the **Add subnet** blade, in the **Name** text box, type **contoso-slurm-lab-cluster-subnet**, accept the default subnet range, and select **Save**.

    > [!NOTE]
    > We recommend separating the subnet hosting the CycleCloud Azure VM from the subnets hosting cluster compute resources. For larger clusters, you should allocate sufficiently sized IP address ranges.

1. In the Azure portal, use the **Search resources, services, and docs** text box at the top of the portal interface to search for **Subscriptions**.
1. On the **Subscriptions** blade, select the entry representing the Azure subscription you are using for exercises in this module.
1. On the blade displaying the Azure subscription, in the vertical menu on the left side, in the **Settings** section, select **Usage + quotas**.
1. On the **Usage + quotas** blade, configure the following filtering settings (leave others with their default values): 

    | Setting | Value |
    | --- | --- |
    | Select a Service | select **Standard Dv3 Family vCPUs** and **Standard FSv2 Family vCPUs**, and **Total Regional vCPUs** entries |
    | Select a Provider | select the **Microsoft.Compute** entry |
    | Select a Location | select the name of the Azure region where you intend to deploy the cluster in this exercise |

1. Review the output and identify the number of available vCPUs in each group.

    :::image type="content" source="../media/u5-subscription-vcpu-quotas.png" alt-text="The screenshot depicts the Usage + quotas blade in the Azure portal." border="false":::

## Create an HPC cluster by using Azure CycleCloud

Now you have the CycleCloud web application installed in an Azure VM, a sufficient number of vCPU cores available in your Azure subscription, and a designated network subnet capable of accommodating autoscaling of cluster nodes. You are ready to proceed with deployment of a Swarm-based cluster.

1. On your computer, in the web browser window displaying the **Subscriptions** page of the Azure CycleCloud web application, in the upper left corner, select the **Back to clusters** link.

1. On the **Create a New Cluster** page, review the available options and, in the **Schedulers** section, select **Slurm**.

    :::image type="content" source="../media/u5-cyclecloud-create-new-cluster.png" alt-text="The screenshot depicts the Create a New Cluster page of the Azure CycleCloud web application." border="false":::

1. On the **About** tab of the **New Slurm Cluster** page, in the **Cluster Name** text box, type **contoso-slurm-lab-cluster**.

    :::image type="content" source="../media/u5-cyclecloud-create-new-cluster-about.png" alt-text="The screenshot depicts the About tab of the New Slurm Cluster page of the Azure CycleCloud web application." border="false":::

1. On the **Required Settings** tab of the **New Slurm Cluster** page, in the **Cluster Name** text box, configure the following settings (leave others with their default values):

    | Setting | Value |
    | --- | --- |
    | Region | select the name of the Azure region  where you intend to deploy the cluster in this exercise |
    | Scheduler VM Type | select **Choose**, in the **Select a machine type** pop-up window, in the **SKU Search** text box, type **D4_v3**, in the list of results, select the checkbox next to the **D4_v3** entry, and select **Apply** |

    :::image type="content" source="../media/u5-cyclecloud-select-machine-type.png" alt-text="The screenshot depicts the Select a machine type pop-up window tab of the New Slurm Cluster page of the Azure CycleCloud web application." border="false":::

    | Setting | Value |
    | --- | --- |
    | Max HPC Cores | type **100** |
    | Max HTC Cores | type **100** |
    | Max VMs per Scaleset | type **40** |
    | Subnet ID | select **cyclecloud-rg: cyclecloud-rg-vnet-contoso-slurm-lab-cluster-subnet** |

    :::image type="content" source="../media/u5-cyclecloud-create-new-cluster-required-settings.png" alt-text="The screenshot depicts the Required Settings tab of the New Slurm Cluster page of the Azure CycleCloud web application." border="false":::

1. On the **Network Attached Storage** tab of the **New Slurm Cluster** page, verify that the **NFS Type** is set to **Builtin**, accept the default value of **Size (GB)** set to **100**, and select **Next**.

    :::image type="content" source="../media/u5-cyclecloud-create-new-cluster-network-attached-storage.png" alt-text="The screenshot depicts the Network Attached Storage tab of the New Slurm Cluster page of the Azure CycleCloud web application." border="false":::

1. On the **Advanced Settings** tab of the **New Slurm Cluster** page, review the available options without making any changes and select **Next**.

    :::image type="content" source="../media/u5-cyclecloud-create-new-cluster-advanced-settings.png" alt-text="The screenshot depicts the Advanced Settings tab of the New Slurm Cluster page of the Azure CycleCloud web application." border="false":::

1. On the **Cloud-init** tab of the **New Slurm Cluster** page, review the available options without making any changes and select **Save**.

    :::image type="content" source="../media/u5-cyclecloud-create-new-cluster-advanced-settings.png" alt-text="The screenshot depicts the Advanced Settings tab of the New Slurm Cluster page of the Azure CycleCloud web application." border="false":::

## Configure and start an HPC cluster by using Azure CycleCloud

To prepare for operationalizing your cluster, you will set alerts notifying you about cluster usage costs reaching the budget allocated towards the cost of Azure resources. You will also validate your deployment by starting the cluster via the graphical interface of the CycleCloud web application.

1. On your computer, in the web browser displaying the graphical interface of the Azure CycleCloud web application, review the properties of the newly deployed cluster. 

    :::image type="content" source="../media/u5-cyclecloud-cluster-state-off.png" alt-text="The screenshot depicts the page of contoso-slurm-lab-cluster in the off state in the Azure CycleCloud web application." border="false"::: <!-- AU: Can we delete "Contoso" from these screenshot and just make it a generic company? If not, then I can make just this subsection introduce the Contoso company name. --> 

1. On the **contoso-slurm-lab-cluster** page, select the **Create new alert** link.
1. In the **Cluster usage alert for contoso-slurm-lab-cluster** pop-up window, specify the following settings and select **Save**:

    | Setting | Value |
    | --- | --- |
    | Budget | **$100.00** |
    | Per | **Month** |
    | Send notification | **Enabled** |
    | Recipients | **cc-admin@contoso.com** |

    :::image type="content" source="../media/u5-cyclecloud-cluster-alert.png" alt-text="The screenshot depicts the Cluster usage alert for contoso-slurm-lab-cluster pop-up window in the Azure CycleCloud web application." border="false":::

1. Back on the **contoso-slurm-lab-cluster** page, select the **Start** link and, when prompted to confirm, select **OK**.
1. Monitor the startup process.

    > [!NOTE]
    > The process involves provisioning of the Azure VM serving the role of the cluster's head node, as well as installation and configuration of the Swarm scheduler. This might take about 5 minutes.

    :::image type="content" source="../media/u5-cyclecloud-cluster-started-nodes.png" alt-text="The screenshot depicts the Nodes tab page of contoso-slurm-lab-cluster in the started state in the Azure CycleCloud web application." border="false":::

## Clean up the lab environment

Your testing of the cluster deployment process by using the Azure CycleCloud application is completed. To avoid unnecessary costs associated with the use of Azure resources, you will now terminate the cluster and remove all of the resources you provisioned throughout the exercises of this course.

1. On your computer, in the web browser displaying the graphical interface of the Azure CycleCloud web application, on the **contoso-slurm-lab-cluster** page, select the **Terminate** link, and, when prompted to confirm, select **OK**.
1. Monitor the termination process.

    > [!NOTE]
    > The process involves deprovisioning of the Azure VM serving the role of the cluster's head node. This might take about 5 minutes.

    > [!NOTE]
    > To delete all other resources you provisioned in this lab, you will delete the **cyclecloud-rg** resource group. 

1. On your computer, switch to the browser window displaying the Azure portal.
1. In the Azure portal, navigate to the **cyclecloud-rg** blade, select the **Delete resource group** entry in the toolbar, in the **TYPE THE RESOURCE GROUP NAME** textbox, type **cyclecloud-rg**, and select **Delete**.

Congratulations! You successfully completed the second exercise of this module. In this exercise, you ensured availability of compute and network resources required to accommodate deployment of a new cluster. Then, you deployed the cluster by using Azure CycleCloud, configured its budget alerts, and started it to validate its functionality. Finally, you terminated the cluster and deleted all resources you provisioned in the course of this module to avoid any unnecessary costs.
