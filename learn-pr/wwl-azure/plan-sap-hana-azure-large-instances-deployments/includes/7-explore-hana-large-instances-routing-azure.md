There are several rules that dictate routing behavior applicable to SAP HANA on Azure (Large Instances):

 -  By default, SAP HANA on Azure (Large Instances) can be accessed only through Azure VMs and the dedicated ExpressRoute connection, not directly from on-premises. The transitive routing restrictions are due to the current Azure network architecture used for SAP HANA Large Instances. Some administration clients and any applications that need direct access, such as SAP Solution Manager running on-premises, won’t be able to connect to the SAP HANA database by default.
 -  If you have HANA Large Instance units deployed in two different Azure regions for disaster recovery, the same transient routing restrictions applied in the past. In other words, IP addresses of a HANA Large Instance unit in one region (for example, US West) were not routed to a HANA Large Instance unit deployed in another region (for example, US East). This restriction was independent of the use of Azure network peering across regions or cross-connecting the ExpressRoute circuits that connect HANA Large Instance units to virtual networks. This restriction, which came with the deployed architecture, prohibited the immediate use of HANA System Replication as disaster recovery functionality.
 -  SAP HANA on Azure (Large Instances) units have an assigned IP address from the server IP pool address range that you submitted when requesting the HANA Large Instance deployment. This IP address is accessible through the Azure subscriptions and circuit that connects Azure virtual networks to HANA Large Instances. The IP address assigned out of that server IP pool address range is directly assigned to the hardware unit. It's not assigned through NAT anymore, as was the case in the first deployments of this solution.

As described above, by default the transitive routing between HANA Large Instance units and on-premises or between HANA Large Instance routing that are deployed in two different regions does not work. There are several possibilities to enable such a transitive routing.

 -  ExpressRoute Global Reach
 -  A reverse-proxy to route data to and from SAP HANA on Azure (Large Instances). This can be, for example, F5 BIG-IP or NGINX with Traffic Manager deployed in the Azure virtual network.
 -  IPTables rules in a Linux VM to enable routing between on-premises locations and HANA Large Instance units, or between HANA Large Instance units in different regions. The VM running IPTables needs to be deployed in the Azure virtual network that connects to HANA Large Instances to on-premises network. The VM needs to be sized accordingly, so, that the network throughput of the VM is enough for the expected network traffic.
 -  Azure Firewall to direct traffic between on-premises and HANA Large instance units.

With a reverse-proxy, IPTables, and Azure Firewall, traffic routed through an Azure virtual network could be additionally filtered by Azure Network Security Groups, so that certain IP addresses or IP address ranges from on-premises could be blocked or explicitly allowed to access HANA Large Instances. Be aware that implementation and support for custom solutions involving third-party network appliances or IPTables aren't provided by Microsoft. Support must be provided by the vendor of the component used or the integrator.

## Explore SAP HANA on Azure (Large Instances) ExpressRoute Global Reach

With ExpressRoute Global Reach, customers can link ExpressRoute circuits together to make a private network between on-premises networks. Global Reach can be used for HANA Large Instances in two scenarios:

 -  Enable direct access from on-premises to your HANA Large Instance units deployed in different regions.
 -  Enable direct communication between your HANA Large Instance units deployed in different regions.

### Examine SAP HANA on Azure (Large Instances) direct access from on-premises

In the Azure regions where Global Reach is offered, you can request to enable the Global Reach functionality for your ExpressRoute circuit that connects your on-premises network to the Azure virtual network that connects to your HANA Large Instance units as well. There are some cost implications for the on-premises side of your ExpressRoute circuit. There is no additional cost for you related to the circuit that connects the HANA Large Instance unit(s) to Azure.

In the case of using Global Reach to enable direct access between HANA Large Instance units and on-premises assets, the network data and control flow is not routed through Azure virtual networks, but directly between the Microsoft enterprise exchange routers. As a result, any NSG or ASG rules, or any type of firewall, NVA, or proxy you deployed in an Azure virtual network, don't impact connectivity. If you use ExpressRoute Global Reach to enable direct access from on-premises to HANA Large Instance units, restrictions on access to HANA Large Instance units need to be defined in the on-premises firewalls.

### Explore SAP HANA on Azure (Large Instances) multi-regional connectivity

ExpressRoute Global Reach can also be used to connect HANA Large Instances tenants deployed in two different regions. This connectivity leverages the ExpressRoute circuits that your HANA Large Instance tenants are using to connect to Azure in both regions. There are no additional charges for connecting two HANA Large Instance tenants that are deployed in two different regions.

The data flow and control flow of the network traffic between different HANA Large Instance tenants will not be routed through Azure virtual networks. As a result, you can't use Azure NSGs to apply connectivity restrictions between your two HANA Large Instances tenants.

## Recognize SAP HANA on Azure (Large Instances) internet connectivity

HANA Large Instances don't have direct internet connectivity. This limitation will prevent you from registering the operating system instances directly with the OS vendor. As a workaround, you can use SUSE Linux Enterprise Server Subscription Management Tool or Red Hat Enterprise Linux Subscription Manager.
