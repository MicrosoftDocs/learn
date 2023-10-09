It's vital to be able to securely administer and manage remote hosted VMs. To begin, let's define *secure remote management*, and then review the features of Azure Bastion. This overview helps you decide if Azure Bastion is a good fit for your requirements.

## What is secure remote management?

Secure remote management is the ability to connect to a remote resource without exposing that resource to security risks. This type of connection can sometimes be challenging, especially if the resource is being accessed across the internet.

When administrators connect to remote VMs, they typically use either RDP or SSH to achieve their administrative goals. The problem is, to connect to a hosted VM, you must connect to its public IP address. However, exposing the IP ports used by RDP and SSH (**3389** and **22**) to the internet is highly undesirable, because it presents significant security risks.

## Azure Bastion definition

Azure Bastion is a fully managed platform as a service (PaaS) that helps provide secure and seamless RDP and SSH access to your Azure VMs directly through the Azure portal.

Azure Bastion:

- Is designed and configured to withstand attacks.
- Provides RDP and SSH connectivity to your Azure workloads behind the bastion.

The following table describes the features that are available after you deploy Azure Bastion.

| Feature                                                    | Description                                                  |
| ----------------------------------------------------------| ------------------------------------------------------------|
|RDP and SSH through the Azure portal|You can directly get to the RDP and SSH session directly in the Azure portal.|
|Remote Session over TLS and firewall traversal for RDP/SSH|Azure Bastion uses an HTML5 web client so that you get an RDP/SSH session over Transport Layer Security (TLS) on port **443**. This configuration enables the traffic to traverse firewalls more securely.|
|No Public IP required on the Azure VM| Azure Bastion opens the RDP/SSH connection to your Azure VM by using a private IP on your VM.|
|No hassle of managing Network Security Groups (NSGs)| Because Azure Bastion connects to your VMs over private IP, you can configure your NSGs to allow RDP/SSH from Azure Bastion only. You don't need to apply any NSGs on the Azure Bastion subnet.|
|Protection against port scanning|Your VMs are protected against port scanning by rogue and malicious users because you don't need to expose them to the internet.|
|Hardening in one place only|Azure Bastion sits at the perimeter of your virtual network, so you don’t need to worry about hardening each of the VMs in your virtual network.|

## How to avoid exposing remote management ports

By implementing Azure Bastion, you can manage the Azure VMs within a configured Azure virtual network by using either RDP or SSH, without needing to expose those management ports to the public internet. By using Azure Bastion, you can:

- Connect easily to your Azure VMs. Connect your RDP and SSH sessions directly in the Azure portal.
- Avoid exposing management ports to the internet. Sign in to your Azure VMs and avoid public internet exposure by using SSH and RDP with private IP addresses only.
- Avoid extensive reconfiguration of your existing network infrastructure. Integrate and traverse existing firewalls and security perimeters by using a modern HTML5-based web client over TLS on port **443**.
- Simplify sign in. Use your SSH keys for authentication when signing in to your Azure VMs.

> [!TIP]
> You can save all your SSH private keys in Azure Key Vault to support centralized key storage.
