Reliable, fast and resilient name resolution is critical for application availability. This unit discusses the design considerations and recommendations for DNS.

## Considerations

Fast and reliable DNS resolution is required for most applications to function well. Azure provides options for built-in name resolution or bring your own DNS, or both. Many customers will use a mix of built in Azure DNS services and bring-your-own DNS.

## Recommendations

If only Azure based resolution is required, use Azure Private DNS as this is the simplest solution and first party, but for cross-premises resolution, deploy at least 2 DNS resolvers per Azure region into an azure VNet and configure VNets to use those resolvers. This allows for DNS resolution to not be impacted by latency or be offline due to a single VM failure. Use zone redundant services where available.

## Tips

-Use conditional forwarders with Azure Private DNS so that on premises servers can resolve Azure VMs and PaaS service names.
-Enable DNS auto-registration for Azure VMs, this is so VMs can locate each other by name.
-Use an Azure Private DNS zone in the global connectivity subscription. Additional zones might be needed for services such as Private Link. 