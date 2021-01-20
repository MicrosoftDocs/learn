Let’s assume you’ve set up multiple virtual networks that are using a combination of Network Security Groups and Azure Firewalls to protect and filter access to the assets and resources, including virtual machines (VMs). It is now protected from external threats, but you now need to allow your developers and data scientist, who are working remotely, direct access to those VMs. 

In a traditional model, you’d need to expose the Remote Desktop Protocol (RDP) and Secure shell (SSH) ports to the Interne, these protocols can be used to gain remote access to your VMs.  This creates a significant surface threat that can be exploited by attackers.  

:::image type="content" source="../media/2-azure-bastion.jpg" alt-text="Diagram showing how a user can make a remote desktop connection to an Azure VM using Azure Bastion.":::

Azure Bastion provides secure and seamless RDP/SSH connectivity to your virtual machines directly from the Azure portal using Transport Layer Security (TLS). When you connect via Azure Bastion, your virtual machines don't need a public IP address, agent, or special client software.

Bastion provides secure RDP and SSH connectivity to all VMs in the virtual network in which it's provisioned. Using Azure Bastion protects your virtual machines from exposing RDP/SSH ports to the outside world, while still providing secure access using RDP/SSH.

Azure Bastion deployment is per virtual network, not per subscription/account or virtual machine. Once you provision an Azure Bastion service in your virtual network, the RDP/SSH experience is available to all your VMs in the same virtual network.

### Key Features of using Azure Bastion

The following features are available:

- **RDP and SSH directly in Azure portal**: You can directly get to the RDP and SSH session directly in the Azure portal using a single click seamless experience.
- **Remote Session over TLS and firewall traversal for RDP/SSH**: use an HTML5 based web client that is automatically streamed to your local device so that you get your Remote Desktop Protocol (RDP) and Secure Shell (SSH) to traverse the corporate firewalls securely.
- **No Public IP required on the Azure VM**: Azure Bastion opens the RDP/SSH connection to your Azure virtual machine using private IP on your VM. You don't need a public IP on your virtual machine.
- **No hassle of managing NSGs**: a fully managed platform PaaS service from Azure that is hardened internally to provide you secure RDP/SSH connectivity. You don't need to apply any NSGs on an Azure Bastion subnet.
- **Protection against port scanning**: Because you don't need to expose your virtual machines to the Internet, your VMs are protected against port scanning by rogue and malicious users located outside your virtual network.
- **Protect against zero-day exploits**: a fully platform-managed PaaS service. Because it sits at the perimeter of your virtual network, you don’t need to worry about hardening each virtual machine in your virtual network. The Azure platform protects against zero-day exploits by keeping the Azure Bastion hardened and always up to date for you.

Use Azure Bastion to establish secure RDP and SSH connectivity to your virtual machines in Azure.
