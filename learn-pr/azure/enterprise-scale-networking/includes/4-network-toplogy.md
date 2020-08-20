# Network topology

    ![Diagram that illustrates a Virtual WAN network topology.](./media/virtual-wan-topology.png)

    ## Virtual WAN
        ***Considerations***
        -Azure Virtual WAN is a Microsoft-managed solution where end-to-end global transit connectivity is provided by default. Virtual WAN hubs eliminate the need to manually configure network connectivity. 
        -Virtual WAN hubs are locked down, and the only resources that you can deploy within them are virtual network gateways (Point-to-Site VPN, Site-to-Site VPN, and ExpressRoute), Azure Firewall via Firewall Manager, and route tables.
        -Virtual WAN increases the limit of up to 200 prefixes advertised from Azure to on-premises via ExpressRoute private peering to 10,000 prefixes per Virtual WAN hub. The limit of 10,000 prefixes also includes Site-to-Site VPN and Point-to-Site VPN. https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/azure-subscription-service-limits#virtual-wan-limits 
        ***Recommendations***
        -Do not use Virtual WAN if more than 2000 VMs will be deployed as that is the current limit of VMs per VWAN. Use a hub and spoke model for these scenarios.
        -Deploy a VWAN hub per Azure region and connect them to large offices or data centers with ExpressRoute, use VPN for smaller locations and point-to-site VPN for remote users. 
        -Traffic in Azure should stay in Azure. Don't route back to on premises to move data between Azure regions or services as this increases complexity and latency.
        -Azure Firewalls can be deployed into the VWAN hub, but third party firewalls have to be deployed into a spoke VNet. https://docs.microsoft.com/en-us/azure/virtual-wan/scenario-route-through-nva 
        -There is no need to build a transit network on top of VWAN, as VWAN is the transit network. To move from hub and spoke to vwan see: https://docs.microsoft.com/en-us/azure/virtual-wan/migrate-from-hub-spoke-topology 

        
    ## Hub and spoke
         ![Diagram that illustrates a hub-and-spoke network topology.](./media/hub-and-spoke-topology.png)
        ***Considerations***  
            -Use the hub and spoke model if no requirements for branch to branch communications, there is no need for SD-WAN integrated solutions, when highly granular routing control is required or when over 2000 virtual machines will be deployed.
            -Virtual networks do not span subscriptions, but VNets in different subscriptions or AAD tenants can be peered allowing for connectivity between subscriptions and authentication domains. 
            -When multiple ExpressRoute circuits are connected to the same VNet, connection weights or BGP techniques must be used to ensure an optimal path for traffic between on-premises and Azure. If connection weights are used, BGP AS prepending is ignored. https://docs.microsoft.com/en-us/azure/expressroute/expressroute-optimize-routing 
            
        ***Recommendations***
            -Each Azure region should have a hub, firewalls and ExpressRoute/VPN gateways should be deployed in that hub so that all spoke virtual networks can route through the hub or use shared services deployed there. 
            -Use multiple Expressroute circuits in different peering locations and different providers to maximize resiliency.
            -Deploy multiple circuits to avoid 'noisy neighbor' problems. Don't let an outage occur because one development project decided to load test over expressroute. 
            -For network architectures with multiple hub and spoke topologies across Azure regions, use global VNet peering to connect landing zone VNets when a small number of landing zones need to communicate across regions, this is simpler and has lower latency than bringing the traffic back to on premises.
            -Do not create more than 200 peering connections per central hub VNet. While VNets support up to 500 peering connections, ExpressRoute with private peering only supports advertising up to 200 prefixes from Azure to on-premises. https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/azure-subscription-service-limits 