There are several ways to access your virtual machines in Azure.

:::image type="content" source="../media/bastion-connections-29c60c68.png" alt-text="A person is shown using RDP and SSH to directly access a virtual machine subnet. A person is also shown using SSL and the Cloud Shell to access a Bastion virtual network.":::


## Windows-based virtual machines

You'll use the remote desktop client to connect to the Windows-based VM hosted on Azure. Most versions of Windows natively contain support for the remote desktop protocol (RDP).

## Linux-based virtual machines

To connect to a Linux-based VM, you need a secure shell protocol (SSH) client. For example, PuTTY which is a free and open-source terminal emulator, serial console and network file transfer application. PuTTY supports several network protocols, including SCP, SSH, Telnet, rlogin, and raw socket connection. It can also connect to a serial port.

## Bastion connections

The Azure Bastion service is a new fully platform-managed PaaS service that you provision inside your virtual network. It provides secure and seamless RDP/SSH connectivity to your virtual machines directly in the Azure portal over SSL. When you connect via Azure Bastion, your virtual machines do not need a public IP address.

Bastion provides secure RDP and SSH connectivity to all VMs in the virtual network in which it is provisioned. Using Azure Bastion protects your virtual machines from exposing RDP/SSH ports to the outside world while still providing secure access using RDP/SSH. With Azure Bastion, you connect to the virtual machine directly from the Azure portal. You don't need an additional client, agent, or piece of software.
