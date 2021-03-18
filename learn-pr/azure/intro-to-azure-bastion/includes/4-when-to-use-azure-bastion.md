As we know, administrators must rely on remote management to be able to administer and maintain your organization's Azure resources. These resources include VMs and the apps installed on those VMs. But how can administrators connect securely to these resources and apps without exposing them to the internet?

Some administrators have addressed this requirement by using *jump servers*, which are sometimes also called *jump boxes*.  

> [!NOTE]
> A jump box is an Azure VM with a public IP address, which is accessible from the internet. 

In this unit, you'll determine whether Azure Bastion can replace jump boxes as a method for providing secure remote management access. 

## Decision criteria

Azure Bastion provides a method for you to remotely connect to and manage hosted VMs without exposing management ports to the internet. However, jump boxes also provide this capability. Let's compare the two and see which best addresses your needs. 

### Jump boxes

First, let's consider a typical jump box scenario:

- Your organization's VMs are configured only with private IP addresses, and are not directly accessible from the internet. 
- The jump box is deployed into the same virtual network as VMs that administrators want to remotely manage using RDP and SSH. 
- The network traffic flow between the internet, the jump box, and the target VMs is managed by a network security group. 

- Administrators connect to the jump box with RDP using the public IP. 

> [!IMPORTANT]
> Because you connect to your jump box with RDP on a public IP, the jump box security can be compromised.

Because the jump box is a VM running a server operating system, you will need to:

- Keep the VM up to date with patches and other updates
- Configure appropriate network security groups to secure the flow of traffic within the virtual network between the jump box and the target VMs

### Azure Bastion

However, you can use Azure Bastion to address the primary requirement of being able to securely access your Azure-hosted VMs. The advantages of using Azure Bastion over using jump boxes are described in the following table.

| Advantage                                                   | Description                                                  |
| ----------------------------------------------------------- | ------------------------------------------------------------ |
| Azure Bastion is a fully managed PaaS service               | You don't need to apply any network security groups to the Azure Bastion subnet. |
| Azure Bastion is not a VM                                   | You won't need to apply patches and updates to Azure Bastion. |
| No client or agent is required to use Azure Bastion         | You don't need to install and maintain any other software on management consoles. |
| Azure Bastion integrates with other Azure security services | You can integrate Azure Bastion with other native security appliances in Azure, such as Azure Firewall. |
| Azure Bastion doesn't expose RDP/SSH on its public IP | Unlike a jump box, Azure Bastion supports only TLS-protected connections from the Azure portal. |


> [!NOTE]
> You deploy Azure Bastion per virtual network (or peered virtual network) rather than per subscription, account, or VM. 

## Apply the criteria

Azure Bastion addresses the key goal of enabling secure remote management of hosted VMs. As a managed service, you don't need to concern yourself with keeping Azure Bastion updated. Nor must you manually configure network security groups and related settings. For these reasons, it represents the best solution to enabling secure remote management of Azure hosted VMs. 

Consider using Azure Bastion when:

- You have remote Azure hosted VMs to manage
- You must connect to those VMs using RDP/SSH
- You want avoid having to maintain the method by which you connect to these remote VMs
- You don't want to have to configure network security group settings to enable remote management
- You want tp avoid using jump boxes

When determining the number of Azure Bastions to deploy, consider that you require one per virtual network (or peered virtual network). It's not necessary to deploy Azure Bastion on a per VM or per subnet basis. 