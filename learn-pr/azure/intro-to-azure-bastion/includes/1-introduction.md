Azure Bastion enables you to securely connect to your Azure virtual machines (VMs) remotely, without needing to expose them to the internet. 

Server administrators understand that it's efficient to remotely administer and maintain servers in an on-premises datacenter. With Windows IaaS VMs being deployed in Azure, admins must rely solely on remote management to be able to administer and maintain cloud-based resources. But how can admins connect securely to remote cloud-based VMs without exposing the management interfaces of those VMs to the internet? 

:::image type="content" source="../media/remote-admin.png" alt-text="A graphic depicting a remote administrator connecting with RDP or SSH through the internet to Azure VMs. The VMs are accessible through a public IP address using port 3389 or port 22.":::


In this module, you'll learn about how Azure Bastion can help protect your hosted VMs. Azure Bastion can help because it avoids the need to expose RDP and SSH ports to the internet. However, it still provides the convenience of securely using both RDP and SSH.

By the end of this module, you'll be able to determine how you can use Azure Bastion to help secure remote management sessions to your Azure hosted VMs.

