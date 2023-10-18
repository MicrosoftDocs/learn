Many organizations have applications they want to make available to their customers, their suppliers, and almost certainly their users. The tricky part is making sure those applications are highly available. In addition, they need to be able to quickly respond while being appropriately secured. Azure Front Door provides different tiers (pricing tiers) that meet these requirements. Let's briefly review the features and benefits of these tiers so you can determine which option best suits your requirements.

## What is a secure, modern cloud CDN?

A secure, modern cloud CDN provides a distributed platform of servers. This helps minimize latency when users are accessing webpages. Historically, IT staff might have used a CDN and a web-application firewall to control HTTP and HTTPS traffic flowing to and from target applications.  

If an organization uses Azure, they might achieve these goals by implementing the products described in the following table:

| Product                        | Description                                                  |
| ------------------------------ | ------------------------------------------------------------ |
| Azure Front Door               | Enables an entry point to your apps positioned in the Microsoft global edge network. Provides faster, more secure, and scalable access to your web applications. |
| Azure Content Delivery Network | Delivers high-bandwidth content to your users by caching their content at strategically placed physical nodes around the world. |
| Azure Web Application Firewall | Helps provide centralized, greater protection for web applications from common exploits and vulnerabilities. |

## Azure Front Door definition

*Azure Front Door Standard/Premium* provides the capabilities of these three products. It offers a fast, reliable, and more secure modern cloud CDN by using the Microsoft global edge network to integrate with intelligent threat protection. Azure Front Door resides in the edge locations and manages user requests to your hosted applications. Users connect to your application through the Microsoft global network. Azure Front Door then routes user requests to the fastest and most available application backend.

> [!NOTE]
> An *application backend* is any internet-facing service that you host, either inside or outside Azure.

The following Azure Front door tiers are available:

- **Azure Front Door (classic)**, which is the entry level. Existing Azure customers often bolster these features with Azure Content Delivery Network, and Azure Web Application Firewall.
- **Azure Front Door Standard**, which is optimized for seamless content delivery.
- **Azure Front Door Premium**, which is optimized for improved security.

Let's examine these last two tiers in more detail.

### Azure Front Door Standard

Azure Front Door Standard provides the capabilities of Azure Front Door (Classic), Azure Content Delivery Network, and Azure Web Application Firewall. Azure Front Door Standard includes:

- Content-delivery optimization
- Static and dynamic content acceleration
- Global load balancing
- Secure Sockets Layer (SSL) offload
- Domain and certificate management
- Enhanced traffic analytics
- Basic security capabilities

### Azure Front Door Premium

Azure Front Door Premium provides the same capabilities as Azure Front Door Standard. However, it's security optimized and includes the following extra features:

- Extensive security capabilities across Web Application Firewall
- Private link support
- Integration with Microsoft Threat Intelligence and security analytics

## How to improve your cloud app delivery

To improve your cloud application delivery, consider deploying an Azure Front Door solution that best fits your needs. In the following unit, we discuss these choices in more detail.
