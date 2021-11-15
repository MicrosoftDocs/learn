The overall architecture of SAP HANA on Azure (Large Instances) provides an SAP TDI-certified hardware configuration, which is a non-virtualized, bare metal, high-performance server for the SAP HANA database. It also provides the ability and flexibility of Azure to scale resources for the SAP application layer to meet your needs.

:::image type="content" source="../media/hli-architectural-overview-373f9bd5.png" alt-text="Architectural overview of SAP HANA on Azure (Large Instances)":::


SAP HANA on Azure (Large Instances) represents an Azure-specific example of 3-tier architecture, with the SAP application layer hosted on Azure VMs and the database layer residing on SAP TDI-configured hardware located in a Microsoft-hosted Large Instance stamp in the same Azure region.

Latency is the primary factor in imposing restrictions on supportability in cross-premises and cross-Azure region scenarios. In general, SAP does not support hosting some components of the same SAP system in Azure and others on-premises – for example, splitting instances of the SAP application layer between your on-premises environment and Azure VMs or running the database tier on-premises with the SAP application tier in Azure or vice versa. Similarly, it is not supported to host VMs running components of the same SAP system across multiple Azure regions.

There are, however, some exceptions to these rules. If the latency stays within the range of 2 milliseconds, the cross-premises restrictions do not apply. Such latency can be achieved with on-premises locations in physical proximity to Azure datacenters and connected to them via ExpressRoute. Incidentally, this is the approach that is used for deployment of SAP HANA Large Instances, where bare-metal servers hosting the database tier are connected to Azure VMs running the application components via ExpressRoute.

The typical architecture of SAP HANA on Azure (Large Instances) consists of three main components:

 -  On-premises infrastructure that runs LOB applications, such as SAP. Ideally, this on-premises infrastructure is connected to Azure with ExpressRoute.
 -  Azure IaaS, with Azure VMs hosting SAP and other applications that use SAP HANA as their DBMS system.
    
     -  Azure network services are used to group SAP systems together with other applications into virtual networks. These virtual networks connect to on-premises systems and to SAP HANA on Azure (Large Instances).
 -  SAP HANA TDI-certified hardware in the Azure Large Instance stamp. The HANA Large Instance units are connected to the virtual networks of your Azure subscription by using ExpressRoute. In May 2019, Microsoft started offering an optimized connectivity solution called ExpressRoute FastPath, which allows direct communication between the HANA Large Instance units and the Azure VMs without the use of the ExpressRoute Gateway.

The Azure Large Instance stamp consists of the following resources:

 -  **Compute**: Servers that are based on one of several generations of Intel Xeon processors that provide the necessary compute capability and are SAP HANA certified.
 -  **Network**: A unified high-speed network fabric that interconnects the compute and storage.
 -  **Storage**: A storage infrastructure that is accessed through a unified network fabric. The specific storage capacity that is provided depends on the specific SAP HANA on Azure (Large Instances) configuration specified by each customer. More storage capacity is available at an additional monthly cost.

Within the multi-tenant infrastructure of the Large Instance stamp, customers are deployed as isolated tenants. At the time of tenant deployment, each customer provides the name of an Azure subscription within their Azure enrollment. This Azure subscription is the one that the HANA Large Instance is billed against. Only one Azure subscription can be linked to only one tenant in a HANA Large Instance stamp in a specific Azure region. Conversely, a single HANA Large Instance stamp tenant can be linked to only one Azure subscription.

If SAP HANA on Azure (Large Instances) is deployed in multiple different Azure regions, a separate tenant is deployed in the HANA Large Instance stamp. You can run both under the same Azure subscription if these instances are part of the same SAP landscape.

From the networking standpoint, it's possible to access a HANA Large Instance unit deployed in one tenant in one Azure region from different virtual networks that belong to different Azure subscriptions. Those Azure subscriptions must belong to the same Azure enrollment.

Just as Azure VMs, SAP HANA on Azure (Large Instances) are offered in multiple Azure regions. This facilitates disaster recovery capabilities that customers can choose to implement. Different Large Instance stamps within one geo-political region are connected to each other. For example, HANA Large Instance stamps in US West and US East are connected through a dedicated network link for disaster recovery replication.

Just as you can choose between different VM types with Azure Virtual Machines, you can choose from different SKUs of HANA Large Instance that are tailored for different workload types of SAP HANA. SAP applies memory-to-processor-socket ratios for varying workloads based on the Intel processor generations. :::image type="content" source="../media/sap-hana-architecture-azure-large-instances-2c79e078.png" alt-text="SAP HANA architecture using Azure Large Instances":::
