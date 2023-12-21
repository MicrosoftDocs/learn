Azure Bastion is a service you deploy that lets you connect to a virtual machine using your browser and the Azure portal, or via the native SSH or RDP client already installed on your local computer. The Azure Bastion service is a fully platform-managed PaaS service that you provision inside your virtual network. It provides secure and seamless RDP/SSH connectivity to your virtual machines directly over TLS from the Azure portal or via native client. When you connect via Azure Bastion, your virtual machines don't need a public IP address, agent, or special client software.

Bastion provides secure RDP and SSH connectivity to all of the VMs in the virtual network in which it is provisioned. Using Azure Bastion protects your virtual machines from exposing RDP/SSH ports to the outside world, while still providing secure access using RDP/SSH.

:::image type="content" source="../media/new-azure-bastion-f0bf391b.png" alt-text="Diagram showing an example of how Azure Bastion service works.":::


## Key benefits

:::image type="content" source="../media/azure-bastion-key-benefits-table-e58bba70.png" alt-text="Screenshot of benefits and descriptions.":::


## SKUs (Stock-keeping units)

Azure Bastion has two available SKUs, Basic and Standard. The following table shows features and corresponding SKUs.

:::image type="content" source="../media/azure-bastion-stock-keeping-units-table-2c845988.png" alt-text="Screenshot of Azure Bastion available SKUs.":::


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
