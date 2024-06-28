[!INCLUDE [](../../../includes/wwl/ai-contribution-notes.md)]

This Guided Project focuses on deploying and administering Azure virtual machines. 

Azure virtual machines (vms) are one of several types of on-demand, scalable computing resources that Azure offers. Typically, you choose a virtual machine when you need more control over the computing environment than the other choices offer. 

## Scenario

Your company is an online retailer providing products and services. The company plans to migrate on-premises operations to Azure virtual machines. A three-tier architecture is proposed.

The Web tier includes web servers running on Linux virtual machines. The App tier processes user requests such as purchases. The Data tier stores the app data such as inventory levels. 

:::image type="content" source="../media/overarch.png" alt-text="Diagram of the overarching architecture." border="false":::

The project proceeds in phases. In the first phase, you as the Cloud Administrator you learn how to deploy and administer the virtual machines in the web tier. You need to prototype a solution that includes configure, monitor, storage, and back up. 

- Exercise 1 - Configure a virtual machine
- Exercise 2 - Monitor a virtual machine
- Exercise 3 - Storage for virtual machines
- Exercise 4 - Back up a virtual machine

By the end of this module, you gained hands-on experience with virtual machines. You're able to apply this knowledge to the on-premises migration. 

> [!NOTE]
> This is a guided project module where you complete an end-to-end project by following step-by-step instructions. 

## Skilling areas

You used the Azure documentation to [review virtual machine options](/azure/virtual-machines/). In each area, you identified skills that you need to practice.

| Skilling area | Skilling task |
| --- | --- | 
| **Configure a virtual machine** | <ul><li> Create a Linux virtual machine. </li><li> Connect to a Linux virtual machine using SSH.</li><li> Update Linux virtual machine operating systems. </li><li> Install and run a workload dependency, like Nginx. </li></ul> |
| **Monitor a virtual machine** |<ul><li> Configure VM Insights. </li><li>  Create an alert.</li><li> Identify performance issues. </li><li> Resize a virtual machine. </li></ul> |
| **Provide access to data storage for a virtual machine** | <ul><li>  Add data disks and configure partitions. </li><li> Assign a managed identity to a virtual machine. </li><li> Mount a file share on a virtual machine. </li><li> Assign Azure roles. </li><li> Use AzCopy to transfer data to and from a virtual machine.  </li></ul>  |
| **Back up a virtual machine** | <ul><li> Configure Azure Backup. </li></ul> |

