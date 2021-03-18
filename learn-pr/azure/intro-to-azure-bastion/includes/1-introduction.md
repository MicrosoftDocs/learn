Azure Bastion enables you to securely connect to your Azure virtual machines (VMs) remotely, without needing to expose remote administrative ports to the internet. 

:::image type="content" source="../media/bastion-remote-admin.png" alt-text="A graphic depicting a remote administrator connecting the Azure portal with TLS through Azure Bastion to a hosted VM.":::

## Example scenario

Server administrators understand that it's efficient to remotely administer and maintain servers in an on-premises datacenter. With Windows IaaS VMs being deployed in Azure, administrators must rely solely on remote management to be able to administer and maintain cloud-based resources. But how can administrators connect securely to remote cloud-based VMs without exposing the management interfaces of those VMs to the internet? 

For example, let's suppose that you have a line of business app that supports your organization's research department. In the past, this app ran on a couple of Windows Server computers in your head office datacenter. 

Whenever you needed to administer the app, you connected using the Remote Desktop Protocol (RDP), over TCP port 3389. You also used Secure Shell (SSH), over port 22, to administer the VMs. Since the app was hosted on computing resource in a private datacenter, you had few concerns over access from malicious persons over the internet. However, the app now runs on VMs hosted in Azure. 

To connect to the VMs, you must now expose a public IP address on each VM for your RDP/SSH connections. This is undesirable due to potential protocol vulnerabilities. A possible solution is to use a jump box VM to act as an intermediary between your management console and the target VMs. Alternatively, you could consider implementing Azure Bastion. 

:::image type="content" source="../media/remote-admin.png" alt-text="A graphic depicting a remote administrator connecting with RDP or SSH through the internet to Azure VMs. The VMs are accessible through a public IP address using port 3389 or port 22.":::

## What will we be doing?

In this module, you'll learn about how Azure Bastion can help protect your hosted VMs. Azure Bastion can help because it avoids the need to expose RDP and SSH ports to the internet. However, it still provides the convenience of securely using both RDP and SSH.

## What is the main goal?

By the end of this module, you'll be able to determine how you can use Azure Bastion to help secure remote management sessions to your Azure hosted VMs.

