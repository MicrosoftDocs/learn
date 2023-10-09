In this unit, you explore the uses of Azure Bastion and determine whether it's a suitable choice for securely connecting to a remote VM. You evaluate Azure Bastion based on the following criteria:

- Security
- Ease of management
- Integration with other apps

Administrators must rely on remote management for the administration and maintenance of an organization's Azure resources, which include VMs, and the apps installed on those VMs. It's important to consider the ability to connect securely to these resources and apps without exposing them to the internet. You can use Azure Bastion to remotely connect to and manage hosted VMs without exposing management ports to the internet. However, some administrators have addressed this requirement by using *jump servers*, which are sometimes called *jump boxes*. In this unit, you determine whether Azure Bastion can replace jump boxes as a method for providing secure remote management access.

> [!NOTE]
> A *jump box* is an Azure VM with a public IP address, which is accessible from the internet.

In a typical jump box scenario:

- Your organization's VMs are configured only with private IP addresses, and aren't directly accessible from the internet.
- The jump box is deployed into the same virtual network as VMs that administrators want to remotely manage by using RDP and SSH.
- An NSG manages the network traffic flow between the internet, the jump box, and the target VMs.
- Administrators connect to the jump box with RDP by using the public IP.

> [!IMPORTANT]
> Because you connect to your jump box with RDP on a public IP, the jump box security can be compromised.

The jump box is a VM running a server operating system, so you need to:

- Keep the VM up to date with patches and other updates.
- Configure appropriate NSGs to help secure the flow of traffic within the virtual network between the jump box and the target VMs.

## Decision criteria

To determine whether a jump box or Azure Bastion is the better option to remotely manage your organization's Azure resources, consider criteria such as security, ease of management, and integration. Here's an analysis of these criteria.

|**Criteria**|**Analysis**|
| --- | --- |
| **Security** |Azure Bastion doesn't expose RDP/SSH on its public IP. Unlike a jump box, Azure Bastion supports only TLS-protected connections from the Azure portal. With Azure Bastion, you don't need to configure NSGs to help secure traffic flow.|
| **Ease of management** | Azure Bastion is a fully managed PaaS service. It's not a VM like a jump box, which requires regular updates. You don't need a client or agent to use Azure Bastion, nor do you need to apply patches and updates to it. You also don't need to install or maintain any other software on management consoles.|
| **Integration** | You can integrate Azure Bastion with other native security services in Azure, such as Azure Firewall. Jump servers don't have this option. |


> [!NOTE]
> You deploy Azure Bastion per virtual network (or peered virtual network) rather than per subscription, account, or VM.

## Apply the criteria

Azure Bastion addresses the key goal of enabling secure remote management of hosted VMs. As a managed service, you don't need to update Azure Bastion, or manually configure NSGs and related settings. Azure Bastion represents the best solution to enabling secure remote management of Azure hosted VMs.

Consider using Azure Bastion when you have remote Azure-hosted VMs to manage and:

- You must connect to those VMs by using RDP/SSH.
- You don't want to maintain the method by which you connect to these remote VMs.
- You don't want to configure NSG settings to enable remote management.
- You want to avoid using jump boxes.

When determining the number of Azure Bastion hosts to deploy, consider that you require one per virtual network (or peered virtual network). You don't have to deploy Azure Bastion on a per-VM or per-subnet basis.
