Azure Bastion provides a secure remote connection from the Azure portal to Azure virtual machines (VMs) over Transport Layer Security (TLS). Provision Azure Bastion to the same Azure Virtual Network as your VMs or a peered virtual network. Then connect to any VM on that virtual network or a peered virtual network directly from the Azure portal. 

## Provide secure RDP and SSH connectivity to an internal VM

Bastion allows you to easily open an RDP or SSH session from the Azure portal to a VM that's not publicly exposed. Azure Bastion connects to your virtual machines over private IP. You don't have to expose RDP or SSH ports, or public IP addresses for your internal VMs. 

Because Bastion is a fully managed platform PaaS service, you don't need to apply any network security groups to the Azure Bastion subnet. But if you want additional security, you can configure your NSGs to allow RDP and SSH from Azure Bastion only.

Bastion provides RDP and SSH connectivity to all VMs on same virtual network or on a peered virtual network as the Bastion subnet. You don't need to install an additional client, agent, or software to use Bastion. 

## Easily connect to a VM by using Bastion

After you deploy Bastion, on the VM overview page, select **Connect** > **Bastion** > **Use Bastion** and then enter the sign in credentials for the VM to connect.

:::image type="content" source="../media/2-connect-bastion-enter-credentials.png" alt-text="Screenshot of the Bastion page that prompts you to enter username and password for the VM.":::


## Key security features

- Traffic initiated from the Azure Bastion to target virtual machines stays within the virtual network or  between peered virtual networks.
- No need to apply NSGs to the Bastion subnet as it's hardened internally. But for additional security, you can configure NSGs to only allow remote connections to the target Virtual Machines from the Bastion host.
- Protects against port scanning. RDP and SSH ports, and public IP addresses aren't publicly exposed for your VMs.
- Protects against zero-day exploits. Azure Bastion sits at the perimeter of your virtual network. So you don’t need to worry about hardening each of the virtual machines in your virtual network. The Azure platform keeps Bastion always up to date.
- Ability to integrate with native Azure Virtual Network security appliances like Azure Firewall.
- Ability to monitor and manage remote connections.

## Concurrent sessions supported

The following table shows how many concurrent RDP and SSH sessions each Bastion resource can support assuming normal day-to-day usage. If there are other on-going RDP sessions or SSH sessions,  these numbers may vary.


|Resource |Limit  |
|---------|---------|
|Concurrent RDP connections    |   25      |
|Concurrent SSH connections   |    50     |

<!--I don't understand what this means: "Both RDP and SSH are a usage-based protocol. High usage of sessions will cause the bastion host to support a lower total number of sessions." -->

## Features supported while connected to a VM

The following table highlights some of the user experience features that are supported for Bastion users.

|Feature  |Supports  |
|---------|---------|
|Browsers     | - Windows: Microsoft Edge browser, Microsoft Edge Chromium, or Google Chrome</br>     - Apple Mac: Google Chrome browser or Microsoft Edge Chromium.      |
|Keyboard layout in the VM    | - En-us-qwerty</br>- Other locales not currently supported        |
|Functions within VM   | - Text copy and paste</br>- Features like file copy not currently supported        |


## Roles required to use Bastion

As with other Azure resources, you need access to the resource group or the Bastion resource itself to deploy or manage Bastion.

For you to connect to the VM resource by using Bastion, the following roles provide the least privilege you need:

- Reader role on the virtual machine
- Reader role on the NIC with private IP of the virtual machine
- Reader role on the Azure Bastion resource
