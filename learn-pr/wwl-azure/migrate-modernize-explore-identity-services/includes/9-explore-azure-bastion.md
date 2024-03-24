Azure Bastion is a service you deploy that lets you connect to a virtual machine using your browser and the Azure portal. The Azure Bastion service is a fully platform-managed PaaS service that you provision inside your virtual network. It provides secure and seamless RDP/SSH connectivity to your virtual machines directly from the Azure portal over TLS. When you connect via Azure Bastion, your virtual machines don't need a public IP address, agent, or special client software.

:::image type="content" source="../media/azure-bastion-architecture-fb78cf0c.png" alt-text="Diagram illustrating Azure Bastion architecture.":::

The typical connection process in Azure Bastion is as follows:

1. An administrator connects to the Azure portal using any HTML5 browser by using a connection secured with TLS. The administrator selects the VM they want to connect to.
2. The portal connects over a secured connection to Azure Bastion through an NSG that's protecting the virtual network that hosts the targeted VM.
3. Azure Bastion initiates a connection to the target VM.
4. The RDP or SSH session opens in the browser on the administrator console. Azure Bastion streams the session information through custom packages. These packages are protected by TLS.

## Optional demo

- [Demonstration: Create an SSH connection to a Linux VM using Azure Bastion](https://github.com/MicrosoftLearning/AZ-120-Planning-and-Administering-Microsoft-Azure-for-SAP-Workloads/blob/master/Demos/demo-create-ssh-connection-linux-vm-azure-bastion.md)
