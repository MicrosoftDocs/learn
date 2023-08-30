There are several ways to access your Azure virtual machines. The Azure portal supports options for connecting your Windows and Linux machines, and making connections by using Azure Bastion. The following diagram shows how you can connect Azure virtual machines with the SSH and RDP protocols, Cloud Shell, and Azure Bastion.

:::image type="content" source="../media/bastion-connections-29c60c68.png" alt-text="Diagram that shows virtual machine access with the SSH and RDP protocols, Cloud Shell, and Azure Bastion." border="false":::

### Things to know about connecting Windows-based virtual machines

To connect to a Windows-based virtual machine hosted on Azure, use the Microsoft Remote Desktop application with the remote desktop protocol (RDP). The Remote Desktop app provides a graphical user interface (GUI) session to an Azure virtual machine that runs any supported version of Windows. The following image shows how to use the RDP protocol to connect to a Windows-based virtual machine in the Azure portal.

:::image type="content" source="../media/rdp-connect.png" alt-text="Screenshot that shows how to use the RDP protocol to connect to a Windows-based virtual machine in the Azure portal.":::

To create an RDP connection, you specify the IP address for the virtual machine. As an option, you can select the port to use for the connection. The system provides you with a downloadable RDP file to use for the connection.

### Things to know about connecting Linux-based virtual machines

To connect to a Linux-based virtual machine, you can use a secure shell protocol (SSH) client. SSH is an encrypted connection protocol that allows secure sign-ins over unsecured connections. Depending on your organization's security policies, you can reuse a single public-private key pair to access multiple Azure virtual machines and services. You don't need a separate pair of keys for each virtual machine or service you wish to access. The following image shows how to use the SSH protocol to connect to a Linux-based virtual machine in the Azure portal.

:::image type="content" source="../media/connect-ssh.png" alt-text="Screenshot that shows how to use the SSH protocol to connect to a Linux-based virtual machine in the Azure portal.":::

- The **public key** is placed on your Linux virtual machine, or any other service that you wish to use with public-key cryptography.
- The **private key** remains on your local system. 

> [!Important]
> **Protect your private key**. Don't share your private key.
> Your public key can be shared with anyone, but only you (or your local security infrastructure) should possess your private key.

### Things to know about connecting with Azure Bastion

The Azure Bastion service is a fully platform-managed PaaS service. Azure Bastion provides secure and seamless RDP/SSH connectivity to your virtual machines directly over SSL. When you connect via Azure Bastion, your virtual machines don't need a public IP address. The following example shows a virtual machine connection with Azure Bastion in the Azure portal.

> [!VIDEO https://www.youtube.com/embed/epWKTGGa_wY]


Azure Bastion provides secure RDP and SSH connectivity to all virtual machines in the virtual network in which it's provisioned. Azure Bastion protects your virtual machines from exposing RDP/SSH ports to the outside world while still providing secure access with RDP/SSH. Azure Bastion lets you connect to the virtual machine directly from the Azure portal. You aren't a client, agent, or another piece of software.