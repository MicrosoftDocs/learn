Network security is an important measure to ensure unauthorized users can't reach the services that you are protecting. Limiting what users can see is always a great idea, since they can’t compromise what they can’t see.

## Apply network access restrictions

By default, Azure AI services are accessible from all networks. Some individual AI services resources (such as **Azure AI Face service**, **Azure AI Vision**, and others) can be configured to restrict access to specific network addresses - either public Internet addresses or addresses on virtual networks.

:::image type="content" source="../media/network-access.png" alt-text="Diagram showing a network configuration for an AI service, restricting access to a range of IP addresses.":::

With network restrictions enabled, a client trying to connect from an IP address that isn't allowed will receive an **Access Denied** error.

> [!NOTE]
> For more information about configuring network access for AI services, see the [AI services documentation](/azure/ai-services/cognitive-services-virtual-networks).
