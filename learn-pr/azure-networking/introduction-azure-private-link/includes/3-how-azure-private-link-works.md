Now you know the basic features and benefits of Azure Private Link. It's time now to examine how Private Link works together with Private Endpoint and Private Link Service to offer private access to Azure services. This information should help you evaluate whether Private Link is the right solution for your company.

## How Private Link fits into an Azure virtual network

Azure Private Link provides access to Azure services privately over the Microsoft Azure backbone network instead of publicly over the internet. To make that switch to private connectivity, Private Link changes the connectivity method for the Azure resource from public endpoint to *private endpoint*.

In other words, access to the Azure resource changes from using a public IP address to using a private IP address. That is, Azure assigns the resource an IP address from the address space of your virtual network or a subnet of that network.

The key point here is that the Azure resource is effectively now a part of your virtual network. Clients on your network can access the resource—which is often called a *Private Link resource*—just like any other network resource.

Not only is the Azure resource now mapped to your virtual network, but the connection to the resource now uses the Microsoft Azure backbone network. That is, any traffic to and from the resource now entirely bypasses the public internet.

However, note that the resource's public endpoint still exists, even though you're not using it. The presence of a public endpoint, even an unused one, is still a security risk. However, it's possible to disable the Azure resource's public endpoint, which plugs that potential security hole.

## How Azure Private Endpoint works

Private Link's transition of a resource interface from public to private requires adding an Azure Private Endpoint to your network configuration. Private Endpoint is a network interface that enables a private connection between your virtual network and a specified Azure resource.

Private Endpoint takes an unused private IP address from the address space of a specified subnet of your virtual network. For example, suppose you have a subnet that uses the address space 10.1.0.0/24. Virtual machines on that subnet use IP addresses such as 10.1.0.20 or 10.1.0.155.

Using Private Endpoint, an Azure resource would get an IP address from the same address space, such as 10.1.0.32. Azure Private Endpoint then maps that IP address to a specified Azure service, which effectively brings the service into your virtual network.

> [!NOTE]
> Clients that connect to a Private Link resource don't need to use the Private Endpoint's assigned IP address in the connection string. Instead, if you configure the Private Endpoint to integrate with your private DNS zone, then Azure automatically assigns a fully qualified domain name (FQDN) to the endpoint. For example, if the Private Link resource is an Azure Storage table, the FQDN will be something like mystorageaccount1234.table.core.windows.net.

Here are a few key points to consider when evaluating Private Endpoint:

* Private Endpoint offers private connectivity between virtual machines and other clients on your Azure virtual network and Private Link-powered Azure services.
* Private Endpoint offers private connectivity between your regionally peered virtual networks and Private Link-powered Azure services.
* Private Endpoint offers private connectivity between your globally peered virtual networks and Private Link-powered Azure services.
* Private Endpoint offers private connectivity between your on-premises network—connected via Express Route Private Peering or a VPN—and Private Link-powered Azure services.
* You can deploy a maximum of 1,000 Private Endpoint interfaces per virtual network.
* You can deploy a maximum of 64,000 Private Endpoint interfaces per Azure subscription.
* You can map a maximum of 1,000 Private Endpoint interfaces to the same Private Link resource.

> [!CAUTION]
> Although it's possible to map multiple Private Endpoint interfaces to a single resource, it's not recommended because doing so can lead DNS conflicts and other problem. The best practice is to only ever map a single Private Endpoint to a single Private Link resource.

* Connections are one way, meaning that only clients can connect to a Private Endpoint interface. If an Azure service is mapped to a Private Endpoint interface, the provider of that service can't connect to (or even see) the Private Endpoint interface.
* A deployed Private Endpoint interface is read-only, meaning that it can't be modified. For example, the interface can't be mapped to a different resource, nor can the interface's IP address be changed.
* Although the Private Endpoint must be deployed in the same region as your virtual network, the Private Link resource can be located in a different region.

> [!NOTE]
> What is the difference between a service endpoint and a private endpoint? A *service endpoint* configures an Azure resource to allow connections only from a specified virtual network. However, that connection is still made via the resource's public endpoint, so some security risks remain. Private Endpoint removes those risks by enabling you to disable a resource's public endpoint.

## How Azure Private Link Service works

Azure Private Link Service brings the security and benefits of Private Link to your custom Azure services. As long as your custom service runs behind a Standard Load Balancer, you can create a Private Link Service resource and attach it to the load balancer's frontend IP address.

Once your Private Link Service resource has been created, Azure issues an *alias* for the resource, which is a globally unique read-only string with the syntax *prefix*.*guid*.*suffix*:

* *prefix*. A name you supply for the custom service.
* *guid*. A globally unique ID generated automatically by Azure.
* *suffix*. The text region.azure.privatelinkservice; region is the region where the Private Link Service is deployed.

Once that's done, you share the Private Link Service alias with the consumers of your custom service. Each consumer then sets up a Private Endpoint in their own Azure virtual network and maps the endpoint to the Private Link Service alias.

Here are some key points to consider when evaluating Private Link Service:

* Your Private Link Service can be accessed via a Private Endpoint in any public region.
* The Private Link Service must be deployed in the same region as the Standard Load Balancer and the virtual network that hosts your custom Azure service.
* You can deploy a maximum of 800 Private Link Service resources per Azure subscription.
* A maximum of 1,000 Private Endpoint interfaces can map to a single Private Link Service resource.
* You can deploy multiple Private Link Service resources on the same Standard Load Balancer using different frontend IP configurations.

## Putting it all together

If your goal is to either access or offer an Azure resource without using the public internet, Private Link, Private Endpoint, and Private Link Service get the job done as follows:

* To privately access an Azure PaaS service or an Azure service from a Microsoft Partner, create a Private Endpoint in a subnet of your Azure virtual network. That Private Endpoint uses Private Link to access the Azure service using a private IP address over the Microsoft Azure backbone. Peered virtual networks and on-premises networks that use ExpressRoute Private Peering or a VPN tunnel can also access the Azure service via the Private Endpoint.
* To offer private access to a custom Azure service, place the service behind a Standard Load Balancer, create a Private Link Service resource, and attach it to the load balancer's frontend IP configuration.

[The unit image will appear here]