

## What is Azure Private Link Service?

Private Link gives you private access from your Azure virtual network to PaaS services and Microsoft Partner services in Azure. But, what if your company has its own Azure services? Is it possible to offer those customers a private connection to your company's services?

Yes, by using [Azure Private Link Service](/azure/private-link/private-link-service-overview). This service lets you offer Private Link connections to your custom Azure services. Consumers of your custom services can then access those services privately—that is, without using the internet—from their own Azure virtual networks.

Azure Private Link service is the reference to your own service that is powered by Azure Private Link. Your service that is running behind Azure standard load balancer can be enabled for Private Link access so that consumers to your service can access it privately from their own VNets. Your customers can create a private endpoint inside their VNet and map it to this service. A Private Link service receives connections from multiple private endpoints. A private endpoint connects to one Private Link service.

:::image type="content" source="../media/consumer-provider-endpoint.png" alt-text="Diagram of the private link service workflow." lightbox="../media/consumer-provider-endpoint.png":::

## Private link and DNS integration for hub-spoke networks

The following diagram shows a typical high-level architecture for enterprise environments with central DNS resolution. The network architecture is hub-spoke network with Private Link resources and Azure Private DNS.

:::image type="content" source="../media/private-link-example-central-dns-73e26cad.png" alt-text="Diagram of high-level workflow of enterprise environments with central DNS resolution.":::

In the previous diagram, it's important to highlight: 

1. All Azure virtual networks use the DNS private resolver that is hosted in the hub virtual network.
1. On-premises DNS servers have conditional forwarders configured for each private endpoint public DNS zone, pointing to the DNS private resolver hosted in the hub virtual network.
1. The DNS private resolver hosted in the hub virtual network uses the Azure-provided DNS (168.63.129.16) as a forwarder. IP address 168.63.129.16 is a virtual public IP address that facilitates a communication channel to Azure platform resources. 
1. The hub virtual network must be linked to the Private DNS zone names for Azure services, such as privatelink.blob.core.windows.net, as shown in the diagram.

> [!NOTE]
> There are many other [DNS integration scenarios](/azure/cloud-adoption-framework/ready/azure-best-practices/private-link-and-dns-integration-at-scale#private-link-and-dns-integration-in-hub-and-spoke-network-architectures) to fit your organization's needs. 


### What is Azure DNS Private Resolver

[Azure DNS Private Resolver](/azure/dns/dns-private-resolver-overview) enables you to query Azure DNS on-premises private zones without deploying VM based DNS servers. When you use DNS Private Resolver, you don't need a DNS forwarder, and Azure DNS is able to resolve on-premises domain names.

> [!TIP]
> Learn more about Azure DNS Private Resolver in the [Intro to Azure DNS Private Resolver](/training/modules/intro-to-azure-dns-private-resolver/) module.