Azure VMware Solution enables running VMware workloads natively in Azure. You'll start with exploring current options available to such workloads for outbound internet connectivity.

## How workloads in Azure VMware Solution can be connected to internet

When Azure VMware Solution private cloud is deployed, it offers multiple ways for outbound internet connectivity. If you're already using Azure Virtual WAN, then you can choose to inject the default route (0.0.0.0/0) – which denotes outbound internet connectivity from Azure Virtual WAN integrated with either Azure Firewall or a certified third party NVA. If you aren't using Azure Virtual WAN, then you can use a managed SNAT capability provided by Azure VMware Solution. If you're looking to use a fixed public IP address for connecting with internet then you can use a public IP deployed at NSX edge of Azure VMware Solution.

Choosing the right way for outbound internet connectivity depends upon whether you already have services like Azure Virtual WAN or not. Additionally, whether you require a fixed public IP address for all outbound internet connectivity or not also plays a role in choosing between Managed SNAT and public IP deployed at NSX edge.

## Controlling internet traffic

Contoso has very prescriptive requirements on how workloads should be connected to the internet. Such requirements allow Contoso to have a centralized exit for internet bound traffic from all applications running inside and outside of Azure VMware Solution.  To meet these requirements, Contoso wants to implement customized internet outbound connectivity on top of options provided by Azure VMware Solution.

### Disable outbound internet connectivity

To implement customized internet outbound connectivity, Contoso first needs to prevent Azure VMware Solution private cloud from having any outbound internet connectivity. Directions to disable internet connectivity are outlined in next unit.
