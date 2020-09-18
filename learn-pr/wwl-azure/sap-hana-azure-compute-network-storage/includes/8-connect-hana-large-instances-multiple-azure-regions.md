ExpressRoute Global Reach can also be used to connect HANA Large Instance tenants deployed in two different regions. This connectivity leverages the ExpressRoute circuits that your HANA Large Instance tenants are using to connect to Azure in both regions. There are no additional charges for connecting two HANA Large Instance tenants that are deployed in two different regions.

The data flow and control flow of the network traffic between different HANA Large instance tenants will not be routed through Azure virtual networks. As a result, you can't use Azure NSGs to apply connectivity restrictions between your two HANA Large Instances tenants.

