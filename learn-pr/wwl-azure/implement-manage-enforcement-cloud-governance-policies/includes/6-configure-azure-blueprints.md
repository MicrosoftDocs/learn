## Architecture

The foundational environment created by this blueprint sample is based on the architecture principals of a [hub and spoke model](/azure/architecture/reference-architectures/hybrid-networking/hub-spoke). The blueprint deploys a hub virtual network that contains common and shared resources, services, and artifacts such as Azure Bastion, gateway and firewall for connectivity, management and jump box subnets to host additional/optional management, maintenance, administration, and connectivity infrastructure. One or more spoke virtual networks are deployed to host application workloads such as web and database services. Spoke virtual networks are connected to the hub virtual network using Azure virtual network peering for seamless and secure connectivity. Additional spokes can be added by reassigning the sample blueprint or manually creating an Azure virtual network and peering it with the hub virtual network. All external connectivity to the spoke virtual network(s) and subnet(s) is configured to route through the hub virtual network and, via firewall, gateway, and management jump boxes.

:::image type="content" source="../media/blueprint-sample-foundational-environment-10843ac1.png" alt-text="Diagram showing an example of a foundational environment created by a blueprint sample." lightbox="../media/blueprint-sample-foundational-environment-10843ac1.png" :::


This blueprint deploys several Azure services to provide a secure, monitored, enterprise-ready foundation. This environment is composed of:

 -  [Azure Monitor Logs](/azure/azure-monitor/logs/data-platform-logs) and an Azure storage account to ensure resource logs, activity logs, metrics, and networks traffic flows are stored in a central location for easy querying, analytics, archival, and alerting.
 -  [MIcrosoft Dedender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) (standard version) to provide threat protection for Azure resources.
 -  [Azure Virtual Network](/azure/virtual-network/virtual-networks-overview) in the hub supporting subnets for connectivity back to an on-premises network, an ingress and egress stack to/for Internet connectivity, and optional subnets for deployment of additional administrative or management services. Virtual Network in the spoke contains subnets for hosting application workloads. Additional subnets can be created after deployment as needed to support applicable scenarios.
 -  [Azure Firewall](/azure/firewall/overview) to route all outbound internet traffic and to enable inbound internet traffic via jump box. (Default firewall rules block all internet inbound and outbound traffic and rules must be configured after deployment, as applicable.)
 -  [Network security groups](/azure/virtual-network/network-security-group-how-it-works) (NSGs) assigned to all subnets (except service-owned subnets such as Azure Bastion, Gateway and Azure Firewall) configured to block all internet inbound and outbound traffic.
 -  [Application security groups](/azure/virtual-network/application-security-groups) to enable grouping of Azure Virtual Machines to apply common network security policies.
 -  [Route tables](/azure/virtual-network/manage-route-table) to route all outbound internet traffic from subnets through the firewall. (Azure Firewall and NSG rules will need to be configured after deployment to open connectivity.)
 -  [Azure Network Watcher](/azure/network-watcher/network-watcher-monitoring-overview) to monitor, diagnose, and view metrics of resources in the Azure virtual network.
 -  [Azure DDoS Protection](/azure/ddos-protection/ddos-protection-overview) to protect Azure resources against DDoS attacks.
 -  [Azure Bastion](/azure/bastion/bastion-overview) to provide seamless and secure connectivity to a virtual machine that does not require a public IP address, agent, or special client software.
 -  [Azure VPN Gateway](/azure/vpn-gateway/vpn-gateway-about-vpngateways) to enable encrypted traffic between an Azure virtual network and an on-premises location over the public Internet.

The Azure Security Benchmark Foundation lays out a foundational architecture for workloads.

## Deploy the Azure Security Benchmark Foundation blueprint sample

To deploy the Azure Security Benchmark Foundation blueprint sample, the following steps must be taken:

1.  Create a new blueprint from the sample.
2.  Mark your copy of the sample as Published.
3.  Assign your copy of the blueprint to an existing subscription.

If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free) before you begin.

### Create blueprint from sample

First, implement the blueprint sample by creating a new blueprint in your environment using the sample as a starter.

1.  Select All services in the left pane. Search for and select Blueprints.
2.  From the Getting started page on the left, select the Create button under *Create a blueprint*.
3.  Find the Azure Security Benchmark Foundation blueprint sample under *Other Samples* and select Use this sample.
4.  Enter the *Basics* of the blueprint sample:
    
    
     -  Blueprint name: Provide a name for your copy of the Azure Security Benchmark Foundation blueprint sample.
     -  Definition location: Use the ellipsis and select the management group to save your copy of the sample to.
5.  Select the *Artifacts* tab at the top of the page or Next: Artifacts at the bottom of the page.
6.  Review the list of artifacts that make up the blueprint sample. Many of the artifacts have parameters that we'll define later. Select Save Draft when you've finished reviewing the blueprint sample.

### Publish the sample copy

Your copy of the blueprint sample has now been created in your environment. It's created in Draft mode and must be Published before it can be assigned and deployed. The copy of the blueprint sample can be customized to your environment and needs, but that modification may move it away from the Azure Security Benchmark Foundation blueprint.

1.  Select All services in the left pane. Search for and select Blueprints.
2.  Select the Blueprint definitions page on the left. Use the filters to find your copy of the blueprint sample and then select it.
3.  Select Publish blueprint at the top of the page. In the new page on the right, provide a Version for your copy of the blueprint sample. This property is useful for if you make a modification later. Provide Change notes such as "First version published from the Azure Security Benchmark Foundation blueprint sample." Then select Publish at the bottom of the page.

### Assign the sample copy

Once the copy of the blueprint sample has been successfully Published, it can be assigned to a subscription within the management group it was saved to. This step is where parameters are provided to make each deployment of the copy of the blueprint sample unique.

1.  Select All services in the left pane. Search for and select Blueprints.
2.  Select the Blueprint definitions page on the left. Use the filters to find your copy of the blueprint sample and then select it.
3.  Select Assign blueprint at the top of the blueprint definition page.
4.  Provide the parameter values for the blueprint assignment:
    
    
     -  Basics
        
        
         -  Subscriptions: Select one or more of the subscriptions that are in the management group you saved your copy of the blueprint sample to. If you select more than one subscription, an assignment will be created for each using the parameters entered.
         -  Assignment name: The name is pre-populated for you based on the name of the blueprint. Change as needed or leave as is.
         -  Location: Select a region for the managed identity to be created in.
         -  Azure Blueprints uses this managed identity to deploy all artifacts in the assigned blueprint. To learn more, see [managed identities for Azure resources](/azure/active-directory/managed-identities-azure-resources/overview).
         -  Blueprint definition version: Pick a Published version of your copy of the blueprint sample.
     -  Lock Assignment
        
        
         -  Select the blueprint lock setting for your environment. For more information, see [blueprints resource locking](/azure/governance/blueprints/concepts/resource-locking).
     -  Managed Identity
        
        
         -  Choose either the default *system assigned* managed identity option or the *user assigned* identity option.
     -  Blueprint parameters
        
        The parameters defined in this section are used by many of the artifacts in the blueprint definition to provide consistency.
        
        
         -  Prefix for resources and resource groups: This string is used as a prefix for all resource and resource group names
         -  Hub name: Name for the hub
         -  Log retention (days): Number of days that logs are retained; entering '0' retains logs indefinitely
         -  Deploy hub: Enter 'true' or 'false' to specify whether the assignment deploys the hub components of the architecture
         -  Hub location: Location for the hub resource group
         -  Destination IP addresses: Destination IP addresses for outbound connectivity; comma-separated list of IP addresses or IP range prefixes
         -  Network Watcher name: Name for the Network Watcher resource
         -  Network Watcher resource group name: Name for the Network Watcher resource group
         -  Enable DDoS protection: Enter 'true' or 'false' to specify whether or not DDoS Protection is enabled in the virtual network
        
        If Network Watcher is already enabled, it's recommended that you use the existing Network Watcher resource group. You must also provide the location for the existing Network Watcher resource group for the artifact parameter Network Watcher resource group location.
     -  Artifact parameters
        
        
         -  The parameters defined in this section apply to the artifact under which it's defined. These parameters are [dynamic parameters](/azure/governance/blueprints/concepts/parameters#dynamic-parameters) since they're defined during the assignment of the blueprint. For a full list or artifact parameters and their descriptions, see [Artifact parameters table](/azure/governance/blueprints/samples/azure-security-benchmark-foundation/deploy#artifact-parameters-table).
5.  Once all parameters have been entered, select Assign at the bottom of the page. The blueprint assignment is created and artifact deployment begins. Deployment takes roughly an hour. To check on the status of deployment, open the blueprint assignment.

The Azure Blueprints service and the built-in blueprint samples are free of cost. Azure resources are [priced by product](https://azure.microsoft.com/pricing/). Use the [pricing calculator](https://azure.microsoft.com/pricing/calculator/) to estimate the cost of running resources deployed by this blueprint sample.

## Artifact parameters table

The table provides a list of the blueprint parameters:

| **Artifact name**                            | **Artifact type**         | **Parameter name**                      | **Description**                                                                                                                                                                                           |
| -------------------------------------------- | ------------------------- | --------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Hub resource group                           | Resource group            | Resource group name                     | Locked - Concatenates prefix with hub name                                                                                                                                                                |
| Hub resource group                           | Resource group            | Resource group location                 | Locked - Uses hub location                                                                                                                                                                                |
| Azure Firewall template                      | Resource Manager template | Azure Firewall private IP address       |                                                                                                                                                                                                           |
| Azure Log Analytics and Diagnostics template | Resource Manager template | Log Analytics workspace location        | Location where Log Analytics workspace is created; run Get-AzLocation \| Where-Object Providers -like 'Microsoft.OperationalInsights' \| Select DisplayName in Azure PowersShell to see available regions |
| Azure Log Analytics and Diagnostics template | Resource Manager template | Azure Automation account ID (optional)  | Automation account resource ID; used to create a linked service between Log Analytics and an Automation account                                                                                           |
| Azure Network Security Group template        | Resource Manager template | Enable NSG flow logs                    | Enter 'true' or 'false' to enable or disable NSG flow logs                                                                                                                                                |
| Azure Virtual Network hub template           | Resource Manager template | Virtual network address prefix          | Virtual network address prefix for hub virtual network                                                                                                                                                    |
| Azure Virtual Network hub template           | Resource Manager template | Firewall subnet address prefix          | Firewall subnet address prefix for hub virtual network                                                                                                                                                    |
| Azure Virtual Network hub template           | Resource Manager template | Bastion subnet address prefix           | Bastion subnet address prefix for hub virtual network                                                                                                                                                     |
| Azure Virtual Network hub template           | Resource Manager template | Gateway subnet address prefix           | Gateway subnet address prefix for hub virtual network                                                                                                                                                     |
| Azure Virtual Network hub template           | Resource Manager template | Management subnet address prefix        | Management subnet address prefix for hub virtual network                                                                                                                                                  |
| Azure Virtual Network hub template           | Resource Manager template | Jump box subnet address prefix          | Jump box subnet address prefix for hub virtual network                                                                                                                                                    |
| Azure Virtual Network hub template           | Resource Manager template | Subnet address names (optional)         | Array of subnet names to deploy to the hub virtual network; for example, "subnet1","subnet2"                                                                                                              |
| Azure Virtual Network hub template           | Resource Manager template | Subnet address prefixes (optional)      | Array of IP address prefixes for optional subnets for hub virtual network; for example, "10.0.7.0/24","10.0.8.0/24"                                                                                       |
| Spoke resource group                         | Resource group            | Resource group name                     | Locked - Concatenates prefix with spoke name                                                                                                                                                              |
| Spoke resource group                         | Resource group            | Resource group location                 | Locked - Uses hub location                                                                                                                                                                                |
| Azure Virtual Network spoke template         | Resource Manager template | Deploy spoke                            | Enter 'true' or 'false' to specify whether the assignment deploys the spoke components of the architecture                                                                                                |
| Azure Virtual Network spoke template         | Resource Manager template | Hub subscription ID                     | Subscription ID where hub is deployed; default value is the subscription where the blueprint definition is located                                                                                        |
| Azure Virtual Network spoke template         | Resource Manager template | Spoke name                              | Name of the spoke                                                                                                                                                                                         |
| Azure Virtual Network spoke template         | Resource Manager template | Virtual Network address prefix          | Virtual Network address prefix for spoke virtual network                                                                                                                                                  |
| Azure Virtual Network spoke template         | Resource Manager template | Subnet address prefix                   | Subnet address prefix for spoke virtual network                                                                                                                                                           |
| Azure Virtual Network spoke template         | Resource Manager template | Subnet address names (optional)         | Array of subnet names to deploy to the spoke virtual network; for example, "subnet1","subnet2"                                                                                                            |
| Azure Virtual Network spoke template         | Resource Manager template | Subnet address prefixes (optional)      | Array of IP address prefixes for optional subnets for the spoke virtual network; for example, "10.0.7.0/24","10.0.8.0/24"                                                                                 |
| Azure Virtual Network spoke template         | Resource Manager template | Deploy spoke                            | Enter 'true' or 'false' to specify whether the assignment deploys the spoke components of the architecture                                                                                                |
| Azure Network Watcher template               | Resource Manager template | Network Watcher location                | Location for the Network Watcher resource                                                                                                                                                                 |
| Azure Network Watcher template               | Resource Manager template | Network Watcher resource group location | If Network Watcher is already enabled, this parameter value must match the location of the existing Network Watcher resource group.                                                                       |

## Troubleshooting

If you encounter the error the resource group 'NetworkWatcherRG' failed to deploy due to the following error: Invalid resource group location '\{location\}'. The Resource group already exists in location '\{location\}'., check that the blueprint parameter Network Watcher resource group name specifies the existing Network Watcher resource group name and that the artifact parameter Network Watcher resource group location specifies the existing Network Watcher resource group location.
