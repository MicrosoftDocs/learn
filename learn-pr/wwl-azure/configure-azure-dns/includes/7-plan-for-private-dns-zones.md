Azure Private DNS zones can be created by using your own custom domain names rather than the names provided by Azure. With your own custom domain names, you can tailor your virtual network architecture to best suit your organization's needs. You gain name resolution for virtual machines within your virtual network and between virtual networks. You can configure DNS zone names with a _split-horizon_ view, which allows a private and a public DNS zone to share the same domain name.

:::image type="content" source="../media/private-domains-4d85c760.png" alt-text="Diagram that shows how Azure DNS responds to a request with a private IP address." border="false":::

### Things to know about Azure Private DNS benefits

There are many benefits to implementing Azure Private DNS for your domain.

| Benefit | Description | 
| --- | --- |
| **No custom DNS solution required** | Previously, many customers created custom DNS solutions to manage DNS zones in their virtual network. You can now perform DNS zone management by using the native Azure infrastructure. Azure Private DNS removes the burden of creating and managing custom DNS solutions. |
| **Support for common DNS records types** | Azure Private DNS supports all common DNS record types, including `A`, `AAAA`, `CNAME`, `MX`, `PTR`, `SOA`, `SRV`, and `TXT`. |
| **Automatic hostname record management** | Along with hosting your custom DNS records, Azure Private DNS automatically maintains hostname records for the virtual machines in the specified virtual networks. In this scenario, you can optimize the domain names you use without needing to create custom DNS solutions or modify applications. |
| **Hostname resolution between virtual networks** | Unlike Azure-provided host names, Azure Private DNS zones can be shared between virtual networks. This capability simplifies cross-network and service-discovery scenarios, such as virtual network peering. |
| **Familiar tools and user experience** | To reduce the learning curve, Azure Private DNS uses well-established Azure DNS tools, including PowerShell, Azure Resource Manager (ARM) templates, and the REST API. |
| **Split-horizon DNS support** | With Azure Private DNS, you can create zones with the same name that resolve to different answers from within a virtual network and from the public internet. A typical scenario for a split-horizon DNS is to provide a dedicated version of a service for use inside your virtual network. |
| **Azure region support** | Azure Private DNS zones are available in all Azure regions in the Azure public cloud. |

In the next section, we'll review some common implementation scenarios for Azure Private DNS.