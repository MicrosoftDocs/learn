Reliable, fast, and resilient name resolution is critical for application availability. This unit discusses the design considerations and recommendations for DNS.

## Considerations

Fast and reliable DNS resolution is required for most applications to function well. Azure provides options for built-in name resolution, name resolution using your own DNS server, or both. Many customers use a mix of built-in Azure DNS services and their own DNS servers.

## Recommendations

If you only need resolution inside an Azure virtual network, you can use Azure Private DNS to minimize your operational and administrative effort. For cross-premises resolution, deploy at least two DNS resolvers per Azure region into an Azure virtual network. Configure the virtual networks to use those resolvers. With this configuration, latency doesn't affect DNS resolution and it isn't taken offline because of a single VM failure. Use zone-redundant services where available.

Use conditional forwarders with Azure Private DNS so that on-premises servers can resolve Azure VMs and platform as a service (PaaS) service names.

Enable DNS autoregistration for Azure VMs so they can locate each other by name.

Use an Azure Private DNS zone in the global connectivity subscription. You might need more zones for services such as Azure Private Link.