Azure Bastion provides a secure remote connection from the Azure portal to Azure virtual machines (VMs) over Transport Layer Security (TLS). Provision Azure Bastion to the same Azure virtual network as your VMs or to a peered virtual network. Then connect to any VM on that virtual network or a peered virtual network directly from the Azure portal. 

## Provide secure RDP and SSH connectivity to an internal VM

You can use Azure Bastion to easily open an RDP or SSH session from the Azure portal to a VM that's not publicly exposed. Azure Bastion connects to your virtual machines over private IP. You don't have to expose RDP ports, SSH ports, or public IP addresses for your internal VMs. 

Because Azure Bastion is a fully managed platform as a service (PaaS) service, you don't need to apply any network security groups to the Azure Bastion subnet. But if you want additional security, you can configure your network security groups (NSGs) to allow RDP and SSH from Azure Bastion only.

Azure Bastion provides RDP and SSH connectivity to all VMs on same virtual network as the Azure Bastion subnet, or on a peered virtual network. You don't need to install an additional client, agent, or software to use Azure Bastion. 

## Connect to a VM by using Azure Bastion

After you deploy Azure Bastion, on the VM overview page, select **Connect** > **Bastion** > **Use Bastion**. Then enter the sign-in credentials for the VM to connect.

:::image type="content" source="../media/2-connect-bastion-enter-credentials.png" alt-text="Screenshot of the Azure Bastion page that prompts you to enter username and password for the VM.":::


## Key security features

- Traffic initiated from Azure Bastion to target virtual machines stays within the virtual network or between peered virtual networks.
- There's no need to apply NSGs to the Azure Bastion subnet, because it's hardened internally. For additional security, you can configure NSGs to allow only remote connections to the target virtual machines from the Azure Bastion host.
- Azure Bastion helps protect against port scanning. RDP ports, SSH ports, and public IP addresses aren't publicly exposed for your VMs.
- Azure Bastion helps protect against zero-day exploits. It sits at the perimeter of your virtual network. So you don't need to worry about hardening each of the virtual machines in your virtual network. The Azure platform keeps Azure Bastion up to date.
- The service integrates with native security appliances for an Azure virtual network, like Azure Firewall.
- You can use the service to monitor and manage remote connections.

## Concurrent sessions supported

The following table shows how many concurrent RDP and SSH sessions each Azure Bastion resource can support, assuming normal day-to-day usage. If there are other ongoing RDP sessions or SSH sessions, these numbers might vary.


|Resource |Limit  |
|---------|---------|
|Concurrent RDP connections    |   25      |
|Concurrent SSH connections   |    50     |

## Features supported during connection to a VM

The following table highlights some of the user experience features that Azure Bastion supports.

|Feature  |Supports  |
|---------|---------|
|Browsers     | - Windows: Microsoft Edge browser, Microsoft Edge Chromium, or Google Chrome</br>     - Apple Mac: Google Chrome browser or Microsoft Edge Chromium.      |
|Keyboard layout in the VM    | - En-us-qwerty</br>- Other locales not currently supported        |
|Functions within VM   | - Text copy and paste</br>- Features like file copy not currently supported        |


## Roles required to use Azure Bastion

As with other Azure resources, you need access to the resource group or the Azure Bastion resource itself to deploy or manage Azure Bastion.

For you to connect to the VM resource by using Azure Bastion, the following roles provide the least privilege that you need:

- Reader role on the virtual machine
- Reader role on the NIC with private IP of the virtual machine
- Reader role on the Azure Bastion resource
