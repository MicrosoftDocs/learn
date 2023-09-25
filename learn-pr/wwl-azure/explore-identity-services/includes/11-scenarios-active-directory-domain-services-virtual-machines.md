


There are three main scenarios that involve AD DS and Azure VMs:

- **AD DS deployed to Azure VMs without cross-premises connectivity**. This deployment results in the creation of a new forest, with all domain controllers residing in Azure. Use this approach if you plan to implement Azure-resident workloads hosted on Azure VMs that rely on Kerberos authentication or Group Policy but have no on-premises dependencies.
- **Existing on-premises AD DS deployment with cross-premises connectivity to an Azure virtual network where the Azure VMs reside**. This scenario uses an existing on-premises Active Directory environment to provide authentication for Azure VM-resident workloads. When considering this design, you should consider the latency associated with cross-premises network traffic.
- **Existing on-premises AD DS deployment with cross-premises connectivity to an Azure virtual network hosting additional domain controller on Azure VMs**. The primary objective of this scenario is to optimize workload performance by localizing authentication traffic.

When planning the deployment of AD DS domain controllers to Azure VMs, you should consider the following:

- **Cross-premises connectivity**. If you intend to extend your existing AD DS environment to Azure, then a key design element is cross-premises connectivity between your on-premises environment and the Azure virtual network. You must set up either a site-to-site virtual private network (VPN) or Microsoft Azure ExpressRoute.
- **Active Directory topology**. In cross-premises scenarios, you should configure AD DS sites to reflect your cross-premises network infrastructure. This allows you to localize the authentication traffic and control the replication traffic between on-premises and Azure VM-based domain controllers. Intra-site replication assumes high bandwidth and permanently available connections. By contrast, inter-site replication allows for scheduling and throttling replication traffic. In addition, a proper site design ensures that domain controllers in a given site handle authentication requests originating from that site.
- **Read-only domain controllers (RODCs)**. Some customers are feeling cautious about deploying writeable domain controllers to Azure VMs due to security concerns. One way to mitigate this concern is to deploy RODCs instead. RODCs and writeable domain controllers provide similar user experiences. However, RODCs lower the volume of egress traffic and the corresponding charges. This is a good option if an Azure-resident workload doesn't require frequent write access to AD DS.
- **Global catalog placement**. Regardless of your domain topology, you should configure all your Azure VM-based domain controllers as global catalog servers. This arrangement prevents global catalog lookups from traversing cross-premises network links, which would negatively affect performance.
