Azure NetApp Files allows you to scale VMware-based storage-intensive workloads like SQL Server, general-purpose file servers, and others in Azure. When preparing to use Azure NetApp Files with Azure VMware Solution, there are three core configuration that you need to check: NetApp account, capacity pools, and volumes. 

When using Azure NetApp Files with Azure VMware Solution, it is recommended you using Standard rather than Basic network features. 

## NetApp accounts

The NetApp account can be considered the highest level organizing principle of an Azure NetApp Files deployment. You can have up to 10 NetApp accounts in your Azure subscription.

Each NetApp account is tied to a region. When you attach your Azure NetApp Files account to Azure VMware Solution, you should use volumes under the NetApp account that is tied to the same region that your Azure VMware Solution is deployed in. For example, if your Azure VMware Solution is deployed in West Europe, your NetApp account should also be in West Europe.

## Capacity pools

Azure NetApp Files volumes are contained in capacity pools. You are allowed to have 25 capacity pools per NetApp account. 

With capacity pools, you set a quota size and a performance tier. Azure NetApp Files offers three performance tiers: Standard, Premium, and Ultra. Performance tiers and the sizes of volumes determine the throughput of your data. There are no requirements for what performance tier to use when attaching Azure NetApp Files to Azure VMware Solution, though Ultra is recommended.
 
## Volumes

Azure NetApp Files can easily be connected to Azure VMware Solution. When creating an Azure NetApp Files volume, you have the option to select an “Azure VMware Solution” checkbox, which helps facilitate connection with Azure VMware Solution.

You must also [delegate a subnet](/azure/azure-netapp-files/azure-netapp-files-delegate-subnet) for your Azure NetApp Files volume. It is recommend you use a dedicated virtual network connected via ExpressRoute gateway.

When delegating a subnet in Azure NetApp Files, it will default to a /24 network mask, which provides for 251 available IP addresses. Subnet delegation should be Microsoft.NetApp/volumes. 
