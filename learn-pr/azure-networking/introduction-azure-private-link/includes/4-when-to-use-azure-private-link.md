You know what Private Link is and how it works. Now you need some criteria to help you evaluate whether Private Link is a suitable choice for your company. To help you make a decision, let's consider the following goals:

* Bringing Azure PaaS services into your virtual network
* Securing traffic between your company network and the Azure cloud
* Eliminating internet exposure for PaaS services
* Accessing Azure PaaS resources across networks
* Lowering the risk of data exfiltration
* Offering customers private access to company-created Azure services

As part of your Azure Private Link evaluation, you know that Contoso has several of these goals. Read the corresponding sections below for more details.

## Bringing Azure PaaS services into your virtual network

Depending on the resource and how it's configured, connecting to Azure PaaS services can be complicated. Private Link reduces that complexity by making Azure services appear to be just another node on your Azure virtual network. With a Private Link resource now effectively part of your virtual network, clients can use a relatively straightforward FQDN to make the connection.

## Securing traffic between your company network and the Azure cloud

Here's one of the paradoxes of cloud computing: For a cloud-based virtual machine to access a service in the same cloud provider, the connection and traffic must go outside of the cloud. That is, although the endpoints are located in the cloud, the traffic must travel along the internet.

Unfortunately, once that traffic leaves the cloud, it becomes "public" and at risk. There's a long list of potential exploits that nefarious actors can use to steal, monitor, or corrupt that traffic.

Private Link eliminates that risk by rerouting traffic so that it doesn't traverse the internet. Instead, all traffic between your virtual network and a Private Link resource rides along Microsoft's secure and private Azure backbone.

## Eliminating internet exposure for PaaS services

Most Azure PaaS resources are internet-facing. These resources have, by default, a public endpoint that offers a public IP address so that clients can connect to the resource via the internet.

The public endpoint exposes the resource to the internet, which is by design. However, that endpoint can also act as an attack point for black-hat hackers seeking a way to infiltrate or disrupt the service.

Private Link doesn't do anything to prevent such attacks. However, once you've created a Private Endpoint and mapped it to the Azure resource, you no longer need the resource's public endpoint. Fortunately, you can configure the resource to disable its public endpoint so that it no longer presents an attack surface to the internet.

## Accessing Azure PaaS resources across networks

Network setups rarely consist of a single virtual network. Most networks also include either or both of the following items:

* One or more peered networks connected via Azure Virtual Network peering.

* One or more on-premises networks connected either via ExpressRoute private peering or via a VPN tunnel.

Without Private Link, these networks must create their own connections to a specific Azure resource. Those connections usually require the public internet. That changes once Private Endpoint maps the Azure resource to a private IP address in your virtual network. Now all your peered networks can connect to the Private Link resource directly, without any other configuration.

## Lowering the risk of data exfiltration

Suppose a virtual machine in your network is connected to an Azure service. It's often possible for a user on the virtual machine to access multiple resources in the Azure service. For example, if the service is Azure Storage, a user could access multiple blobs, tables, files, and so on.

Now suppose that the user is a malicious infiltrator who has taken control of the virtual machine. In that scenario, the user could move data from one resource to another one that's controlled by the attacker.

This scenario is an example of *data exfiltration*. Private Link lowers the risk of data exfiltration by  mapping a Private Endpoint to a single instance of an Azure resource. An attacker might still be able view the data, but has no way to copy or move it to another resource.

:::image type="content" source="../media/4-using-private-link.png" alt-text="Network diagram of an Azure virtual network accessing a single instance of an Azure SQL database via a private IP address mapped by Private Endpoint and not allowing access to other instances of Azure SQL Database.":::

## Offering customers private access to company-created Azure services

Suppose your company creates custom Azure services. Who consumes those services? It could be anyone in the following list:

* People who buy your products.
* Company suppliers or vendors.
* Your company's employees.

You can say that each consumer in the above list is a *customer* of your service.

There's an excellent chance that the data accessed and created by those customers is every bit as important as your company's data. So your customer's data deserves the same level of privacy and security as your company data.

If you believe that Private Link is the right choice for securing your company data, then you'll want to extend that security model to your custom Azure services. By putting your custom services behind Azure Standard Load Balancer, you can use Private Link Service to enable customers to access your service using Private Endpoint.

Imagine the satisfaction of your marketing department when you tell them they can now offer customers private and secure access to your custom Azure services.
