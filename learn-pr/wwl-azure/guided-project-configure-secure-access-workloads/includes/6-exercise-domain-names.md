
## **Scenario** 

Your organization requires workloads to record and resolve domain names internally in virtual networks. Virtual machines in virtual networks can use domain name instead of IPs for internal communication. In that case, the domain names will be resolved by a private DNS zone through a virtual network link. 

### **Architecture diagram**

|Network solution | Tasks|
| --- | --- |
| :::image type="content" source="../media/task5.png" alt-text="Diagram of Azure DNS linked to a virtual network." border="true"::: | <ul><li>Create and configure a private DNS zone. </li><li> Create and configure DNS records. </li><li>  Configure DNS settings on a virtual network.</li></ul> |

## **Exercise instructions**

1. Create a private DNS Zone named ****Contoso.com**** in the ****RG1**** resource group. 

1. Create a Virtual Network Link within the private DNS Zone to the **app-vnet** named ****app-vnet-link**** with auto registration enabled.

1. Create a DNS record set for VM2 named **backend** that is Type A with IP address **10.1.1.4** 

1. Verify that **contoso.com** has a record set named **backend**
