# DNS

    ## Considerations

        -Fast and reliable DNS resolution is required for most applications to function well. Azure provides options for built-in name resolution or bring your own DNS, or both.
        -DNS resolvers can be used with Azure DNS for cross-premise DNS
        -Many deployments extend their DNS infrastructure to Azure
        -a VNet can link to 1000 private DNS zones
   
    ## Recommendations
        
        -If only Azure based resolution is required, use Azure Private DNS as this is the simplest solution and first party.
        -For cross premise resolution, deploy at least 2 DNS resolvers per Azure region into an azure VNet and configure VNets to use those resolvers. This allows for DNS resolution to not be impacted by latency or be offline due to a single VM failure. 
        -Use conditional forwarders with Azure Private DNS so that on premises servers can resolve Azure VMs and PaaS service names. 
        -Enable DNS auto-registration for Azure VMs, this is so VMs can locate each other by name. 
        -Use an Azure Private DNS zone in the global connectivity subscription. Additional zones might be needed for services such as Private Link. For detailed information on this DNS configuration see here: https://docs.microsoft.com/en-us/azure/private-link/private-endpoint-dns 
        -For more information on private DNS, see https://docs.microsoft.com/en-us/azure/dns/private-dns-scenarios 