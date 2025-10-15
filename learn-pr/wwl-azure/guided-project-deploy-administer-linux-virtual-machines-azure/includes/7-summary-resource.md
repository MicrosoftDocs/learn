In this module, you learned about Linux virtual machines in Azure. 
- In the first exercise, you created a virtual machine in the portal, connected using SSH, and installed the Nginx server. 
- In the second exercise, you enabled VM Insights, created action groups and alerts, and monitored the virtual machine metrics and logs. 
- In the third exercise, you added a data disk, and accessed blob and file storage. Additionally you assigned an Azure role, configured a managed identity, and used AzCopy. 
- In the fourth exercise, you used Azure Backup to create a virtual machine backup policy. 

## Key takeaways

Here are the main takeaways for the module.

+ Azure virtual machines are on-demand, scalable computing resources. Both Windows and Linux virtual machines are available. 
+ Configuring virtual machines includes choosing an operating system, image size, storage, and networking settings. 
+ There are several ways to securely connect to a Linux virtual machine. One of the most common connections is SSH with a credential file. 
+ Network Security Group rules let you allow or deny inbound and outbound port connections. For example, port 22 for SSH.
+ Azure Monitor provides alerts to help you detect and address issues before users notice.
+ You can configure alerts on any virtual machine metric or log data.
+ Data disks can be added to virtual machines. In Linux, the disk must be formatted and mounted. 
+ Virtual machines can access Azure file shares and blob storage. Managed identities and Azure roles provide secure access. 
+ AzCopy is a utility to transfer data from virtual machines to Azure storage accounts.
+ Azure Backup provides retention and backup policies for virtual machines. 

## Learn more with online training

+ [Monitor your Azure virtual machines with Azure Monitor](/training/modules/monitor-azure-vm-using-diagnostic-data/). Monitor your Azure VMs by using Azure Monitor to collect and analyze VM host and client metrics and logs.
+ [Provisioning a Linux virtual machine in Microsoft Azure](/training/modules/provision-linux-virtual-machine-in-azure/). Azure allows you to use several common provisioning tools to deploy Linux virtual machines (VMs), to include Terraform, Bicep, the Azure portal, and the Azure CLI. In this module, you learn how to deploy a Linux virtual machine using each of these methods.
+ [Add and size disks in Azure virtual machines](/training/modules/add-and-size-disks-in-azure-virtual-machines/). Understand and create the different types of disk storage available to Azure virtual machines (VMs). This task includes adding a data disk and resizing a data disk. 
+ [Protect your virtual machines by using Azure Backup](/training/modules/protect-virtual-machines-with-azure-backup/). Use Azure Backup to help protect on-premises servers, virtual machines, SQL Server, Azure file shares, and other workloads.
