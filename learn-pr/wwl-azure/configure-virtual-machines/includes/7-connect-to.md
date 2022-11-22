There are several ways to access your Azure virtual machines.

:::image type="content" source="../media/bastion-connections-29c60c68.png" alt-text="Diagram of virtual machine access with S S H, R D P, Cloud Shell, and Bastion.":::

## Windows-based virtual machines

You'll use the remote desktop client (RDP) to connect to the Windows-based VM hosted on Azure. RDP provides a graphical user interface (GUI) session to an Azure VM that runs any supported version of Windows. 

:::image type="content" source="../media/rdp-connect.png" alt-text="Screenshot of the R D P connection page.":::

## Linux-based virtual machines

To connect to a Linux-based VM, you can use a secure shell protocol (SSH) client. SSH is an encrypted connection protocol that allows secure sign-ins over unsecured connections. Depending on your organization's security policies, you can reuse a single public-private key pair to access multiple Azure VMs and services. You don't need a separate pair of keys for each VM or service you wish to access.

 -  The **public key** is placed on your Linux VM, or any other service that you wish to use with public-key cryptography.
 -  The **private key** remains on your local system. Protect this private key. don't share it.


> [!NOTE]
> Your public key can be shared with anyone, but only you (or your local security infrastructure) should possess your private key.

:::image type="content" source="../media/connect-ssh.png" alt-text="Screenshot of a L I N U X connection.":::

## Bastion connections

The Azure Bastion service is a fully platform-managed PaaS service. Bastion provides secure and seamless RDP/SSH connectivity to your virtual machines directly over SSL. When you connect via Azure Bastion, your virtual machines don't need a public IP address.

Bastion provides secure RDP and SSH connectivity to all VMs in the virtual network in which it's provisioned. Using Azure Bastion protects your virtual machines from exposing RDP/SSH ports to the outside world while still providing secure access using RDP/SSH. With Azure Bastion, you connect to the virtual machine directly from the Azure portal. You are not a client, agent, or another piece of software.

:::image type="content" source="../media/connect-bastion.png" alt-text="Screenshot of a Bastion connection.":::
