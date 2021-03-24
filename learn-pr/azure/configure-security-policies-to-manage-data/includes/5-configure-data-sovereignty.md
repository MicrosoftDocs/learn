Digital information is always subject to the laws of the country or region where it's stored. This concept is known as _data sovereignty_. Many of the concerns that surround data sovereignty relate to enforcing privacy regulations and preventing data that are stored in a foreign country from being subpoenaed by the host country or region's government.

In Azure, customer data can be replicated within a geographic area for enhanced data durability if there's a significant data center disaster.

> [!IMPORTANT]
> No matter where customer data is stored, Microsoft does not control or limit the locations from which customers or their end users might access their data.

### Paired regions

Azure operates in multiple geographies around the world. Azure geography is a defined area of the world that contains at least one **Azure Region**. An Azure region is an area containing one or more data centers.

Each Azure region is paired with another region within the same geography, forming a _region pair_. The exception is Brazil South, which is paired with a region outside its geography. Across the region pairs, Azure serializes platform updates (or planned maintenance) so that only one region is updated at a time. If an outage affecting multiple regions occurs, one region in each pair will be prioritized for recovery.

![A Geography box contains a regional pair box, which in turn contains two region boxes, each with a box in it labeled datacenter. ](../media/M4_01_04_01.png)

It's recommended that you configure business continuity and disaster recovery (BCDR) across regional pairs to benefit from Azure's isolation and VM policies. For apps that support multiple active regions, we recommend using both regions in a region pair, where possible. This approach will ensure optimal availability for apps and minimized recovery time in the event of a disaster.

### An example of paired regions

The following illustration shows a hypothetical app that uses a regional pair for DR. The arrows highlight the cross-region activities of three Azure services (Azure Compute, Azure Storage, and Azure Database), and how they are configured to replicate across regions.

![In this geography diagram, two regions - a primary region and a secondary region - each contain compute, storage, database, and management services sections. MISSING: Lines connecting sections are numbered, and are described in the following cross-region activities number key text.](../media/M4_01_04_02.png)

### Cross-region activities number key

* **Azure Compute (IaaS)** - To ensure resources are available in another region during a disaster, you must provision additional compute resources in advance. For more information, see [Designing resilient apps for Azure](https://docs.microsoft.com/azure/resiliency/resiliency-technical-guidance).
* **Azure Storage**- Geo-redundant storage (GRS) is configured by default when an Azure Storage account is created. With GRS, data is automatically replicated three times within the primary region, and three times in a paired region. For more information, see [Azure Storage redundancy](https://docs.microsoft.com/azure/storage/common/storage-redundancy).
* **Azure SQL Database** - With Azure SQL Database geo-replication, you can configure asynchronous replication of transactions to any region in the world; however, we recommend you deploy these resources in a paired region for most disaster recovery scenarios. For more information, see [Configure active geo-replication for Azure SQL Database in the Azure portal](https://docs.microsoft.com/azure/sql-database/sql-database-active-geo-replication-portal).
* **Azure Resource Manager** - Resource Manager inherently provides logical isolation of components across regions. This means that logical failures in one region are less likely to impact other regions.

### Benefits of Azure paired regions number key

* **Physical isolation** - When possible, Azure services prefer at least 300 miles of separation between datacenters in a regional pair (although this isn't practical or possible in all geographies). Physical datacenter separation reduces the likelihood of both regions being affected simultaneously as a result of natural disasters, civil unrest, power outages, or physical network outages. Isolation is subject to the constraints within the geography, such as geography size, power, and network infrastructure availability, and regulations.
* **Platform-provided replication** - Some services such as geo-redundant storage provide automatic replication to the paired region.
* **Region recovery order** - In the event of a widespread outage, recovery of one region is prioritized out of every pair. Apps that are deployed across paired regions are guaranteed to have one of the regions recovered with priority. If an app is deployed across regions that are not paired, recovery might be delayed. In the worst case, the chosen regions might be the last two to be recovered.
* **Sequential updates** - Planned Azure system updates are rolled out to paired regions sequentially, not at the same time. This helps minimize downtime, the effect of bugs, and logical failures in the rare event of a bad update.
* **Data residency** - To meet data residency requirements for tax and law enforcement jurisdiction purposes, a region resides within the same geography as its pair (with the exception of Brazil South).

Microsoft also complies with international data protection laws regarding transfers of customer data across borders. For example, to accommodate the continuous flow of information required by the international business (including the cross-border transfer of personal data), many Microsoft business cloud services offer customers [European Union Model Clauses](https://www.microsoft.com/TrustCenter/Compliance/eu-model-clauses) that provide additional contractual guarantees around transfers of personal data for in-scope cloud services. European Union data protection authorities have validated the Microsoft implementation of the EU Model Clauses as being in line with the rigorous privacy standards that regulate international data transfers by companies operating in its member states.

In addition to our commitments under the Standard Contractual Clauses and other model contracts, Microsoft is certified to the EU-U.S. Privacy Shield Framework as set forth by the U.S. Department of Commerce regarding the collection, use, and retention of personal information transferred from the European Union to the United States. Microsoft participation in the EU-U.S. Privacy Shield applies to all personal data that is subject to the Microsoft Privacy Statement and is received from the EU, European Economic Area, and Switzerland. Microsoft also abides by Swiss data protection law regarding the processing of personal data from the European Economic Area and Switzerland.

> [!IMPORTANT]
> Microsoft will not transfer to any third party (not even for storage purposes) data that you provide to Microsoft through the use of our business cloud services, and that are covered under the [Microsoft Online Services Terms](https://azure.microsoft.com/support/legal/).
