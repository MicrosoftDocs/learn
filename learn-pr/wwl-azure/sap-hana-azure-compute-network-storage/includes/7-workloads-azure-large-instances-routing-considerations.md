Azure implements a default routing configuration that eases basic connectivity. Including reaching the internet and communicating with other resources on the same network or directly connected virtual networks. You can modify this default configuration in two ways:

* **Creating user-defined routes**, which are route tables with one or more rules altering the default routing behavior and associate them with virtual network subnets. These route table rules apply to any traffic leaving these subnets and targeting IP address ranges that you referenced as prefixes in the route table. IP targeting rules allow you to affect routing behavior between subnets in the same virtual network and between connected virtual networks, between on-premises networks and Azure virtual networks in hybrid scenarios, and on traffic from virtual network subnets to the internet.

* **Configuring Border Gateway Protocol (BGP) routing** facilitates dynamic route exchange between on-premises networks and Azure virtual networks in hybrid scenarios. This allows you to affect routing behavior between on-premises networks and Azure virtual networks in hybrid scenarios and traffic from virtual network subnets to the internet. For example, by implementing forced tunneling.

The rules that dictate routing behavior applicable to SAP HANA on Azure (Large Instances) are as follows:

* By default, SAP HANA on Azure (Large Instances) cannot be accessed directly from on-premises. Connections are established through Azure VMs within the same SAP HANA on Azure (Large Instances) VNet and through using a dedicated ExpressRoute connection. The transitive routing restrictions are due to the Azure network architecture currently provided for SAP HANA Large Instances. Administration clients and any applications that need direct access, such as SAP Solution Manager running on-premises, can't connect to the SAP HANA on Azure (Large Instances) database by default.

* If you have HANA Large Instance units deployed in two different Azure regions for disaster recovery, the transient routing restrictions apply. IP addresses of a HANA Large Instance unit in one region isn’t directly routed to a HANA Large Instance unit deployed in another region. For example, US West IP addresses won’t be routed to US East. The restriction is independent of the use of Azure network peering across regions or cross connecting the ExpressRoute circuits that connect HANA Large Instance units to virtual networks. This restriction, which comes with the deployed architecture, prohibits the immediate use of HANA System Replication as disaster recovery functionality.

* SAP HANA on Azure (Large Instances) units have an assigned IP address from the server IP pool address range that you submit when requesting the HANA Large Instance deployment. This IP address is accessible through Azure subscriptions and the circuit that connects Azure virtual networks to HANA Large Instances. The IP address assigned out of that server IP pool address range is directly assigned to the hardware unit. It's not assigned through NAT anymore, as was the case in the first deployments of this solution.

As described above, by default the transitive routing between HANA Large Instance units and on-premises or between HANA Large Instance routing that are deployed in two different regions does not work. There are several possibilities to enable such a transitive routing.

* ExpressRoute Global Reach

* A reverse-proxy to route data, to and from SAP HANA on Azure (Large Instances). This can be, for example, F5 BIG-IP or NGINX with Traffic Manager deployed in the Azure virtual network.

* IPTables rules in a Linux VM to enable routing between on-premises locations and HANA Large Instance units, or between HANA Large Instance units in different regions. The VM running IPTables needs to be deployed in the Azure virtual network that connects to HANA Large Instances and to on-premises network. You'll need to size the VM to meet the expected network traffic.

* Azure Firewall to direct traffic between on-premises and HANA Large instance units.

With a reverse-proxy, IPTables, and Azure Firewall, traffic routed through an Azure virtual network can be further filtered by Azure Network Security Groups. Certain IP addresses or IP address ranges from on-premises can be blocked or explicitly allowed to access HANA Large Instances. Implementation and support for custom solutions involving third-party network appliances or IPTables isn't provided by Microsoft. Support must be provided by the vendor of the component used or the integrator.
