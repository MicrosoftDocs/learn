## Single SAP system

To run SAP landscapes in Azure, connect to the enterprise edge router closest to the Azure region in the SAP landscape. HANA Large Instance stamps are connected through dedicated enterprise edge router devices to minimize network latency between VMs in Azure IaaS and HANA Large Instance stamps.

The ExpressRoute gateway, for the VMs that host SAP application instances, is connected to one ExpressRoute circuit that connects to an on-premises network. The same virtual network is connected to a separate enterprise edge router dedicated to connecting to Large Instance stamps.

This system is a straightforward example of a single SAP system. The SAP application layer is hosted in Azure. The SAP HANA database runs on SAP HANA on Azure (Large Instances). The assumption is that the ExpressRoute gateway bandwidth of 2 Gbps or 10 Gbps throughput doesn't represent a bottleneck.

## Multiple SAP systems

If multiple SAP systems or large SAP systems are deployed to connect to SAP HANA on Azure (Large Instances), the throughput of the ExpressRoute gateway might become a bottleneck. You might also need to isolate production and non-production systems. In such cases, split the application layers into multiple virtual networks. You might also want to create a special virtual network that connects to HANA Large Instance for cases such as:

 -  Performing backups directly from the HANA instances in HANA Large Instance to a VM in Azure that hosts NFS shares.
 -  Copying large backups or other files from HANA Large Instance units to disk space managed in Azure.

For a more scalable network architecture:

 -  Leverage multiple virtual networks for a single, larger SAP application layer.
 -  Deploy one separate virtual network for each SAP system deployed, compared to combining these SAP systems in separate subnets under the same virtual network.

Dependent on the rules and restrictions, you want to apply between the different virtual networks hosting VMs of different SAP systems, you should peer those virtual networks.
