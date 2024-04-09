Azure Bastion is a service you deploy that lets you connect to a virtual machine using your browser and the Azure portal, or via the native SSH or RDP client already installed on your local computer. The Azure Bastion service is a fully platform-managed PaaS service that you provision inside your virtual network. It provides secure and seamless RDP/SSH connectivity to your virtual machines directly over TLS from the Azure portal or via native client. When you connect via Azure Bastion, your virtual machines don't need a public IP address, agent, or special client software.

Bastion provides secure RDP and SSH connectivity to all of the VMs in the virtual network in which it is provisioned. Using Azure Bastion protects your virtual machines from exposing RDP/SSH ports to the outside world, while still providing secure access using RDP/SSH.

The following diagram shows connections to virtual machines via a Bastion deployment that uses a Basic or Standard SKU.

:::image type="content" source="../media/architecture-29bc391b.png" alt-text="Diagram showing connections to virtual machines using a Bastion deployment.":::


## Key benefits

| **Benefit**                                                | **Description**                                                                                                                                                                                                                                                                                                        |
| ---------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| RDP and SSH through the Azure portal                       | You can get to the RDP and SSH session directly in the Azure portal using a single-click seamless experience.                                                                                                                                                                                                          |
| Remote Session over TLS and firewall traversal for RDP/SSH | Azure Bastion uses an HTML5 based web client that is automatically streamed to your local device. Your RDP/SSH session is over TLS on port 443. This enables the traffic to traverse firewalls more securely. Bastion supports TLS 1.2 and above. Older TLS versions aren't supported.                                 |
| No Public IP address required on the Azure VM              | Azure Bastion opens the RDP/SSH connection to your Azure VM by using the private IP address on your VM. You don't need a public IP address on your virtual machine.                                                                                                                                                    |
| No hassle of managing Network Security Groups (NSGs)       | You don't need to apply any NSGs to the Azure Bastion subnet. Because Azure Bastion connects to your virtual machines over private IP, you can configure your NSGs to allow RDP/SSH from Azure Bastion only. This removes the hassle of managing NSGs each time you need to securely connect to your virtual machines. |
| No need to manage a separate bastion host on a VM          | Azure Bastion is a fully managed platform PaaS service from Azure that is hardened internally to provide you secure RDP/SSH connectivity.                                                                                                                                                                              |
| Protection against port scanning                           | Your VMs are protected against port scanning by rogue and malicious users because you don't need to expose the VMs to the internet.                                                                                                                                                                                    |
| Hardening in one place only                                | Azure Bastion sits at the perimeter of your virtual network, so you don’t need to worry about hardening each of the VMs in your virtual network.                                                                                                                                                                       |
| Protection against zero-day exploits                       | The Azure platform protects against zero-day exploits by keeping the Azure Bastion hardened and always up to date for you.                                                                                                                                                                                             |

## SKUs (Stock-keeping units)

Azure Bastion has two available SKUs, Basic and Standard. The following table shows features and corresponding SKUs.

| **Feature**                                           | **Developer SKU** | **Basic SKU** | **Standard SKU** |
| ----------------------------------------------------- | ----------------- | ------------- | ---------------- |
| Connect to target VMs in same virtual network         | Yes               | Yes           | Yes              |
| Connect to target VMs in peered virtual networks      | No                | Yes           | Yes              |
| Support for concurrent connections                    | No                | Yes           | Yes              |
| Access Linux VM Private Keys in Azure Key Vault (AKV) | No                | Yes           | Yes              |
| Connect to Linux VM using SSH                         | Yes               | Yes           | Yes              |
| Connect to Windows VM using RDP                       | Yes               | Yes           | Yes              |
| Connect to Linux VM using RDP                         | No                | No            | Yes              |
| Connect to Windows VM using SSH                       | No                | No            | Yes              |
| Specify custom inbound port                           | No                | No            | Yes              |
| Connect to VMs using Azure CLI                        | No                | No            | Yes              |
| Host scaling                                          | No                | No            | Yes              |
| Upload or download files                              | No                | No            | Yes              |
| Kerberos authentication                               | No                | Yes           | Yes              |
| Shareable link                                        | No                | No            | Yes              |
| Connect to VMs via IP address                         | No                | No            | Yes              |
| VM audio output                                       | Yes               | Yes           | Yes              |
| Disable copy/paste (web-based clients)                | No                | No            | Yes              |

## Architecture

Azure Bastion is deployed to a virtual network and supports virtual network peering. Specifically, Azure Bastion manages RDP/SSH connectivity to VMs created in the local or peered virtual networks.

RDP and SSH are some of the fundamental means through which you can connect to your workloads running in Azure. Exposing RDP/SSH ports over the Internet isn't desired and is seen as a significant threat surface. This is often due to protocol vulnerabilities. To contain this threat surface, you can deploy bastion hosts (also known as jump-servers) at the public side of your perimeter network. Bastion host servers are designed and configured to withstand attacks. Bastion servers also provide RDP and SSH connectivity to the workloads sitting behind the bastion, as well as further inside the network.<br>

Currently, by default, new Bastion deployments don't support zone redundancies. Previously deployed bastions might or might not be zone-redundant. The exceptions are Bastion deployments in Korea Central and Southeast Asia, which do support zone redundancies.<br>

 -  The Bastion host is deployed in the virtual network that contains the AzureBastionSubnet subnet that has a minimum /26 prefix.
 -  The user connects to the Azure portal using any HTML5 browser.
 -  The user selects the virtual machine to connect to.
 -  With a single click, the RDP/SSH session opens in the browser.
 -  No public IP is required on the Azure VM.

## Host scaling

Azure Bastion supports manual host scaling. You can configure the number of host instances (scale units) in order to manage the number of concurrent RDP/SSH connections that Azure Bastion can support. Increasing the number of host instances lets Azure Bastion manage more concurrent sessions. Decreasing the number of instances decreases the number of concurrent supported sessions. Azure Bastion supports up to 50 host instances. This feature is available for the Azure Bastion Standard SKU only.
