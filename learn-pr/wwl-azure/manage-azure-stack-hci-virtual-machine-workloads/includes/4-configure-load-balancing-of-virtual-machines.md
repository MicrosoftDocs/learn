While you're satisfied so far with the results of your evaluation of Azure Stack HCI for Contoso, you realize that modernizing the IT infrastructure by purchasing Azure Stack HCI hardware represents a capital expenditure. Your CIO wants to make sure that the extra cost will yield meaningful returns and the purchased hardware will be fully used. To make sure that this is the case, you decide to explore Azure Stack HCI VM load balancing.

## What is VM load balancing in Azure Stack HCI?

As you provision and manage the state of VMs on an Azure Stack HCI cluster, they might end up running on the same cluster nodes or different cluster nodes. You can control their respective placement to some extent by using affinity and anti-affinity rules. However, the use of rules will not guarantee equal use of the cluster nodes, which is the outcome your CIO is interested in. Fortunately, Azure Stack HCI offers a built-in load-balancing mechanism that helps you accomplish this goal.

The Azure Stack HCI load-balancing mechanism continually monitors the use of each cluster node, looking at metrics such as memory pressure and CPU utilization averaged over a five-minute window. By enabling this mechanism and customizing its configuration, you can influence the automatic distribution of VMs across the cluster nodes, resulting in optimum use of cluster resources. 

The load-balancing mechanism performs automatic redistribution of VMs across cluster nodes: 

- Whenever a new cluster node is added to the cluster
- Every 30 minutes

In the first case, the cluster automatically triggers live migration of VMs from the nodes with the highest memory pressure and CPU utilization to the newly added node. In the second case, the load-balancing mechanism automatically reevaluates these performance metrics across the entire cluster every 30 minutes, and depending on the configuration settings that you specify, decides whether to perform live migration to the least used nodes. 

Automatic load balancing always honors affinity and anti-affinity rules. It also does not apply across fault domains. For example, when using stretched clusters, each site represents a separate fault domain. Effectively, the load balancing would not automatically move VMs from one site to another, even if the cluster node utilization between the sites is different. 

## Configure VM load balancing in Azure Stack HCI

Windows Admin Center simplifies the process of configuring VM load balancing for Azure Stack HCI VMs. To review and modify the default load-balancing behavior, browse to the cluster's **Settings** pane, and then in the **Cluster** section, select the **Virtual machine load-balancing** menu item.

The **Balance virtual machine** property supports the following three values:

- **Never** effectively disables load balancing.
- **Server joins** results in load balancing happening only when a node is added to the cluster. 
- **Always** results in load balancing happening every 30 minutes and when a node is added to the cluster.

:::image type="content" source="../media/virtual-machine-load-balancing-1.png" alt-text="The screenshot depicts the **Balance virtual machine** property, which supports three values: Never, Server joins, and Always." border="false":::

The **Aggressiveness** property supports the following three values:

- **Low** results in VM live migration from cluster nodes when the utilization level exceeds 80%. 
(default).
- **Medium** results in VM live migration from cluster nodes when the utilization level exceeds 70%.
- **High** triggers evaluation of the average utilization across all cluster nodes and results in VM live migration from nodes with the utilization level at least five percent above the average.

:::image type="content" source="../media/virtual-machine-load-balancing-2.png" alt-text="The screenshot depicts the **Aggressiveness** property, which supports three values: Low, Medium, and High." border="false":::

> [!NOTE]
> To further customize or automate implementation of Azure Stack HCI VM load balancing, use Windows PowerShell.

---
## Check your knowledge
## Multiple Choice
While evaluating the use of Windows Admin Center in Contoso's Azure Stack HCI environment, you decide to test the VM load-balancing behavior. You want the load-balancing mechanism to take effect whenever the utilization levels on individual cluster nodes exceed 70%. To achieve this, what should you configure in Windows Admin Center?
(x) Set the Aggressiveness property of the Virtual Machine load-balancing setting to Medium. {{Correct. The Medium value results in VM live migration from cluster nodes when the utilization level exceeds 70%.}} 
( ) Set the Aggressiveness property of the Virtual Machine load-balancing setting to High. {{Incorrect. The High value triggers evaluation of the average utilization across all cluster nodes and results in VM live migration from nodes with the utilization level at least 5% above the average.}}
( ) Set the Aggressiveness property of the Virtual Machine load-balancing setting to Low. {{Incorrect. The Low value results in VM live migration from cluster nodes when the utilization level exceeds 80%.}} 