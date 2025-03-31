Network security is an important measure to ensure unauthorized users can't reach the services that you're protecting. Limiting what users can see is always a great idea, since they can’t compromise what they can’t see.

## Network access restrictions

By default, Azure AI services are accessible from all networks. 

:::image type="content" source="../media/network-access.png" alt-text="Diagram showing a network configuration for an AI service, restricting access to a range of IP addresses.":::

The following services allow for network access restrictions: 

- Anomaly Detector
- Azure OpenAI
- Content Moderator
- Custom Vision
- Face
- Language Understanding (LUIS)
- Personalizer
- Speech service
- Language
- QnA Maker
- Translator

To limit access to selected networks, you must first change the default action.

## Changing the default action

When you change the default configuration, all access to the resource is effectively denied. When all access is denied, requests that attempt to consume the Azure AI services resource aren't permitted. This means your AI service isn't reachable by its clients. We recommended that you add an exception to a virtual network or firewall policy as you change the default action.

> [!NOTE]
> The Azure portal, Azure PowerShell, or the Azure CLI can still be used to configure the Azure AI services resource.

## Configuring network access restrictions

Network setting for Azure AI services supports three options:

- (Default) All networks: The default option applies no networking restrictions to the resource.
- Selected Networks and Private Endpoints: Blocks connections to the resource, unless a rule allows access to it. These rules can be set for Azure virtual networks, IP addresses, CIDR, or Private Endpoints.
- Disabled: Blocks all traffic to the resource. You can still add access to Private Endpoints. This is the most restrictive option.

## Configuring access rules for virtual networks and IP addresses

To configure access rules for virtual networks and IP addresses:

1. On the Azure portal, open the Azure AI service you want to configure.
1. On the resource page, expand Resource Management on the menu on the left-hand side.
1. Choose Networking.
1. On Allow access from, select Selected Networks and Private Endpoints.
1. Under Virtual Networks, choose + Add existing virtual network.
1. You can search for the desired virtual network by typing its name in the search box.
1. Once you find the virtual network, select it from the list, and select the subnet you want to provide access to the Azure AI service resource.
1. If a Service endpoint isn't present, a warning message shows: The following networks don’t have service endpoints enabled for 'Microsoft.CognitiveServices'. Enabling access takes up to 15 minutes to complete.
1. Choose Enable.
1. Once the service is enabled, choose Add.
1. Choose Save on the resource’s Networking page.
1. Alternatively, under Firewall, you can add an IP address or IP range. Under Firewall, type the IP address you want to allow access to the Azure AI service resource.
1. Choose Save.

> [!NOTE]
> To grant access from your on-premises networks to your Azure AI services resource with an IP network rule, you must first identify the internet-facing IP addresses used by your network. Contact your network administrator for help. If you use Azure ExpressRoute or a VPN on-premises for Microsoft peering, you need to identify the NAT IP addresses.

## Configuring access rules for private endpoint connections

When configuring network access rules for private endpoints, you first need to consider if you want to also allow virtual networks and IP addresses. If your goal is to restrict access to private endpoints only, you can change the Allow access from option to Disabled. However, we recommended that you configure the private endpoint connections before you change the network access to Disabled.

1. On the Azure portal, open the Azure AI service you want to configure.
1. On the resource page, expand Resource Management on the menu on the left-hand side.
1. Choose Networking.
1. On the Networking page, Choose Private endpoint connections.
1. Choose + Private endpoint to create a new connection.
1. On the Create a private endpoint page, make sure the Subscription, and Resource group are correct.
1. Provide a Name, Network Interface Name, and Region for the endpoint of the AI service resource and Choose Next.
1. On the Resource tab, make sure the Target subresource is the AI service you want to configure and Choose Next.
1. On the Virtual Network tab, the wizard shows the available virtual networks and subnets for your private endpoint. Select the virtual network and subnet you want to configure for this private endpoint.
1. You can also configure Dynamic or Statically allocation of IPs and Application security groups. For this tutorial, we use the default configuration. Choose Next.
1. By default, a private DNS integration is configured so the resources can query each other’s DNS name using the IP address of the private endpoint. You can change that configuration if needed. Choose Next.
1. Add the necessary Tags if needed and Choose Next.
1. On the Review + create page, make sure the configuration is validated and Choose Create.
1. The Deployment page shows the deployment progress. Once the deployment is successfully completed, close the Deployment page.
1.Open the Azure AI resource and Choose the Networking option under Resource Management.
1. Under Firewalls and virtual networks, select the option Disabled and Choose Save.
1. Choose the Private endpoint connections tab.
1. If necessary, you can reject or remove the private endpoint connection to remove access from that subnet.

## Exceptions for trusted services

A small subset of Azure services can have a preconfigured exception to network access rules for Azure AI services.

The Azure services under this class of trusted services are:

| Service name | Resource provider name |
|-------------|------------------------|
| Azure AI Services | Microsoft.CognitiveServices |
| Azure Machine Learning (also applies to Azure AI Foundry) | Microsoft.MachineLearningServices |
| Azure AI Search | Microsoft.Search |

To enable or disable exceptions for trusted services:

1. On the Azure portal, open the Azure AI service you want to configure.
1. On the resource page, expand Resource Management on the menu on the left-hand side.
1. Choose Networking.
1. Under Firewalls and virtual networks, make sure Allow access from is set to either Selected Networks and Private Endpoints or Disabled.
1. You can check or uncheck the option Allow Azure services on the trusted services list to access this cognitive services account under Exceptions.

> [!NOTE]
> When exceptions are enabled, these trusted services use managed identity to authenticate with your Azure AI service.
