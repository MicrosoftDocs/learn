As you progress with your evaluation of Azure Stack HCI, the Contoso IT leadership is beginning to recognize its significance in implementing the datacenter modernization and consolidation initiatives. There are already plans to migrate some of the most business-critical workloads to the new platform. However, one of the concerns you need to address is the ability to control their placement within Azure Stack HCI clusters. For example, it is important to ensure that more resource-intensive SQL Server instances run on separate cluster nodes to prevent resource contention. To accomplish these tasks, you decide to explore the affinity and anti-affinity settings available in Windows Server Failover Cluster (WSFC), which serves as one of the foundational technologies of Azure Stack HCI.

## What is affinity and anti-affinity in Azure Stack HCI?

Highly available VMs represent some of the most common workloads of Azure Stack HCI clusters. Clustering facilitates online moves of VMs between cluster nodes. Such moves might happen, for example, as a result of a deliberate administrative action before a scheduled node shutdown or as a result of the built-in load-balancing mechanism, which automatically distributes workloads across Azure Stack HCI cluster nodes. However, there are scenarios in which you want to apply some additional constraints to node placement that apply when VMs move from one node to another. 

For example, you might have a couple of CPU- or memory-bound clustered VMs that should not reside on the same physical node for performance reasons. You might also have a VM with strict storage latency requirements, which you would like to satisfy by ensuring that its storage and compute reside on the same cluster node. To address the first of these challenges, you can create an anti-affinity rule referencing both VMs. To address the second of these challenges, you can create an affinity rule, referencing the VM and its storage. 

Affinity is a rule that establishes a relationship between two or more cluster roles and resources, such as VMs and storage to indicate that you prefer to host them on the same cluster node. The purpose of anti-affinity is to indicate preference of the opposite arrangement, with two or more cluster roles and resources distributed across different cluster nodes. 

> [!NOTE]
> Affinity rules do not enforce placement of VMs, but only indicate your preferences regarding their placement. In addition, they are considered by the built-in load balancing mechanism, but do not have any impact on administratively initiated VM moves.

## Configure affinity in Azure Stack HCI VMs

Windows Admin Center simplifies the process of implementing affinity and anti-affinity rules for Azure Stack HCI VMs. To review existing rules and create new rules, browse to the cluster's **Settings** pane, and then in the **Cluster** section, select the **Affinity rules** menu item."

- The anti-affinity rule is referred to as **Apart (different servers)**. 

:::image type="content" source="../media/virtual-machine-affinity-1.png" alt-text="The screenshot depicts the **Create affinity rule** dialog box in Windows Admin Center, where you can create an anti-affinity rule referencing two or more VMs. In Windows Admin Center, this rule type is referred to as **Apart (different servers)**." border="false"::: 

- The affinity rule type is referred to as **Together (same server)**.

:::image type="content" source="../media/virtual-machine-affinity-2.png" alt-text="The screenshot depicts the **Create affinity rule** dialog box in Windows Admin Center, where you can create an affinity rule referencing one or more VMs and their storage. In Windows Admin Center, this rule type is referred to as **Together (same server)**." border="false":::

> [!NOTE]
> To further customize or automate implementation of Azure Stack HCI affinity and anti-affinity rules, use Windows PowerShell.