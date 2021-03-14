Administrators have to rely on remote management to be able to administer and maintain your organization's Azure resources, including VMs and the resources and apps installed on those VMs. But how can administrators connect securely to these resources and apps without exposing them to the internet?

Some administrators have addressed this requirement by using *jump servers*, which are sometimes also called *jumpboxes*.  A jumpbox is an Azure VM with a public IP address which is accessible from the internet. 

## Replace a jumpbox

Let's consider a typical jumpbox scenario:

- Your organization's VMs are configured only with private IP addresses, and are not directly accessible from the internet. 
- The jumpbox is deployed into the same virtual network as VMs that administrators want to remotely manage using RDP and SSH. 
- The network traffic flow between the internet, the jumpbox, and the target VMs is managed by a network security group. 

- Administrators connect to the jumpbox with RDP using the public IP. 

Because the jumpbox is a VM running a server operating system, you'll need to keep the VM up-to-date with patches and other other updates. You'll also need to configure appropriate network security groups to secure the flow of traffic within the virtual network between the jumpbox and the target VMs.

However, you can use Azure Bastion to address the primary requirement of being able to securely access your Azure-hosted VMs. The advantage of using Azure Bastion over using jumpboxes are described in the following table.

| Advantage                                                   | Description                                                  |
| ----------------------------------------------------------- | ------------------------------------------------------------ |
| Azure Bastion is a fully managed PaaS service               | You don't need to apply any network security groups to the Azure Bastion subnet |
| Azure Bastion is not a VM                                   | You won't need to apply patches and updates to Azure Bastion |
| No client or agent is required to use Azure Bastion         | You don't need to install and maintain any additional software on management consoles |
| Azure Bastion integrates with other Azure security services | You can integrate Azure Bastion with other native security appliances in Azure, such as Azure Firewall |


