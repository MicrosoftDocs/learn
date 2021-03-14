When administrators connect to remote VMs, they typically use either the remote desktop protocol (RDP) or secure shell (SSH) to achieve their administrative goals. The problem is, to connect to a hosted VM, you must connect to its public IP address. However, exposing the IP ports used by RDP and SSH to the internet is highly undesirable because it presents significant security risks. 

Azure Bastion is a fully managed PaaS service providing secure and seamless RDP and SSH access to your Azure VMs directly through the Azure Portal. 

Azure Bastion: 

- Is designed and configured to withstand attacks
- Provides RDP and SSH connectivity to your Azure workloads behind the bastion

## Why implement Azure Bastion?

By implementing Azure Bastion, you can manage the Azure VMs within a configured Azure virtual network using either RDP or SSH without needing to expose those managements ports to the public internet. Using Azure Bastion, you can:

- **Connect easily to your Azure VMs**. Connect your RDP and SSH sessions directly in the Azure Portal using a single click experience
- **Avoid exposing management ports to the internet**. Sign in to your Azure VMs, avoiding public internet exposure using SSH and RDP with private IP addresses only
- **Avoid extensive reconfiguration of your existing network infrastructure**. Integrate and traverse existing firewalls and security perimeter using a modern HTML5 based web client and standard SSL ports
- **Simplify sign in**. Use your SSH keys for authentication when signing in to your Azure VMs

> [!TIP]
> You can save all SSH private keys in Azure KeyVault to provide for centralized key storage.

## What are the important features?

The following table describes the features that are available after you deploy Azure Bastion.

| Feature                                                    | Description                                                  |
| ---------------------------------------------------------- | ------------------------------------------------------------ |
| RDP and SSH via the Azure portal                           | You can directly get to the RDP and SSH session directly in the Azure portal. |
| Remote Session over TLS and firewall traversal for RDP/SSH | Azure Bastion uses an HTML5 web client so that you get an RDP/SSH session over Transport Layer Security (TLS) on port 443. This enables the traffic to traverse firewalls securely. |
| No Public IP required on the Azure VM                      | Azure Bastion opens the RDP/SSH connection to your Azure VM using private IP on your VM. |
| No hassle of managing Network Security Groups (NSGs)       | Because Azure Bastion connects to your VMs over private IP, you can configure your NSGs to allow RDP/SSH from Azure Bastion only. You don't need to apply any NSGs on the Azure Bastion subnet. |
| Protection against port scanning                           | Your VMs are protected against port scanning by rogue and malicious users because you do not need to expose your VMs to the internet. |
| Hardening in one place only                                | Azure Bastion sits at the perimeter of your virtual network, so you don’t need to worry about hardening each of the VMs in your virtual network. |
