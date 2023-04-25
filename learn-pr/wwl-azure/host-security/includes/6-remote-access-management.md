
This topic explains how to connect to and sign into the virtual machines (VMs) you created on Azure. Once you've successfully connected, you can work with the VM as if you were locally logged on to its host server.

## Connect to a Windows VM

The most common way to connect to a Windows based VM running in Azure is by using Remote Desktop Protocol (RDP). Most versions of Windows natively contain support for the remote desktop protocol (RDP). If you are connecting to a Windows VM from a Mac, you will need to install an RDP client for Mac.

If you are using PowerShell and have the Azure PowerShell module installed you may also connect using the `Get-AzRemoteDesktopFile` cmdlet.

## Connect to a Linux-based VM

To connect the Linux-based VM, you need a secure shell protocol (SSH) client. The most used free tool is **PuTTY** SSH terminal. The following shows the PuTTY configuration dialog.

:::image type="content" source="../media/az500-putty-9887de6d.png" alt-text="PuTTY configuration dialog box.":::


## Azure Bastion

The Azure Bastion service is a fully platform-managed PaaS service that you provision inside your virtual network. It provides secure and seamless RDP/SSH connectivity to your virtual machines directly in the Azure portal over TLS. When you connect using Azure Bastion, your virtual machines do not need a public IP address.

Bastion provides secure RDP and SSH connectivity to all the VMs in the virtual network in which it is provisioned. Using Azure Bastion protects your virtual machines from exposing RDP/SSH ports to the outside world, while still providing secure access using RDP/SSH. With Azure Bastion, you connect to the virtual machine directly from the Azure portal.

## Architecture

Azure Bastion is deployed to a virtual network and supports virtual network peering. Specifically, Azure Bastion manages RDP/SSH connectivity to VMs created in the local or peered virtual networks.

RDP and SSH are some of the fundamental means through which you can connect to your workloads running in Azure. Exposing RDP/SSH ports over the Internet isn't desired and is seen as a significant threat surface. This is often due to protocol vulnerabilities. To contain this threat surface, you can deploy bastion hosts (also known as jump-servers) at the public side of your perimeter network. Bastion host servers are designed and configured to withstand attacks. Bastion servers also provide RDP and SSH connectivity to the workloads sitting behind the bastion, as well as further inside the network.

:::image type="content" source="../media/az500-bastion-b40322c2.png" alt-text="Architecture of a bastion host.":::


This figure shows the architecture of an Azure Bastion deployment. In this diagram:

 -  The Bastion host is deployed in the virtual network.
 -  The user connects to the Azure portal using any HTML5 browser.
 -  The user selects the virtual machine to connect to.
 -  With a single click, the RDP/SSH session opens in the browser.
 -  No public IP is required on the Azure VM.

## Key features

The following features are available:

 -  **RDP and SSH directly in Azure portal**: You can directly get to the RDP and SSH session directly in the Azure portal using a single click seamless experience.
 -  **Remote Session over TLS and firewall traversal for RDP/SSH**: Azure Bastion uses an HTML5 based web client that is automatically streamed to your local device, so that you get your RDP/SSH session over TLS on port 443 enabling you to traverse corporate firewalls securely.
 -  **No Public IP required on the Azure VM**: Azure Bastion opens the RDP/SSH connection to your Azure virtual machine using private IP on your VM. You don't need a public IP on your virtual machine.
 -  **No hassle of managing NSGs**: Azure Bastion is a fully managed platform PaaS service from Azure that is hardened internally to provide you secure RDP/SSH connectivity. You don't need to apply any NSGs on Azure Bastion subnet. Because Azure Bastion connects to your virtual machines over private IP, you can configure your NSGs to allow RDP/SSH from Azure Bastion only.
 -  **Protection against port scanning**: Because you do not need to expose your virtual machines to public Internet, your VMs are protected against port scanning by rogue and malicious users located outside your virtual network.
 -  **Protect against zero-day exploits**. Hardening in one place only: Azure Bastion is a fully platform-managed PaaS service. Because it sits at the perimeter of your virtual network, you don’t need to worry about hardening each of the virtual machines in your virtual network.
