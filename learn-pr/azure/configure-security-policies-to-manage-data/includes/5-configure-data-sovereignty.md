Digital information is always subject to the laws of the country or region where it's stored. This concept is known as *data sovereignty*. Many of the concerns that surround data sovereignty relate to enforcing privacy regulations and preventing data stored in a foreign country/region from being subpoenaed by the host country/region's government.

In Azure, customer data can be replicated within a geographic area for enhanced data durability if there's a significant data center disaster.

> [!IMPORTANT]
> No matter where customer data is stored, Microsoft does not control or limit the locations from which customers or their end users might access their data.

### Paired regions

Azure operates in multiple geographies around the world. Azure geography is a defined area of the world that contains at least one **Azure region**. An Azure region is an area containing one or more data centers.

Each Azure region is paired with another region within the same geography, forming a *region pair*. The exception is Brazil South, which is paired with a region outside its geography. Across the region pairs, Azure serializes platform updates (or planned maintenance) so that only one region is updated at a time. If an outage affecting multiple regions occurs, one region in each pair is prioritized for recovery.

:::image type="content" source="../media/regional-pair.png" alt-text="Diagram of a regional pair box, which contains two region boxes, each with a box in it labeled datacenter.":::

We recommend that you configure business continuity and disaster recovery (BCDR) across regional pairs to benefit from Azure's isolation and VM policies. For apps that support multiple active regions, we recommend using both regions in a region pair, where possible. This approach ensures optimal availability for apps and minimized recovery time in the event of a disaster.

### An example of paired regions

The following illustration shows a hypothetical app that uses a regional pair for disaster recovery. The arrows highlight the cross-region activities of three Azure services (Azure Compute, Azure Storage, and Azure Database), and how they are configured to replicate across regions.

:::image type="content" source="../media/primary-secondary-region.png" alt-text="Diagram of a primary region and a secondary region, each containing compute, storage, database, and management services sections.":::

### Cross-region activities number key

* **Azure Compute (IaaS)**: To ensure resources are available in another region during a disaster, you must provision additional compute resources in advance. For more information, see [Recommendations for performing failure mode analysis](/azure/well-architected/reliability/failure-mode-analysis).
* **Azure Storage**: Geo-redundant storage (GRS) is configured by default when an Azure Storage account is created. With GRS, data is automatically replicated three times within the primary region and three times in a paired region. For more information, see [Azure Storage redundancy](/azure/storage/common/storage-redundancy).
* **Azure SQL Database**: With Azure SQL Database geo-replication, you can configure asynchronous replication of transactions to any region in the world; however, we recommend you deploy these resources in a paired region for most disaster-recovery scenarios. For more information, see [Configure active geo-replication for Azure SQL Database in the Azure portal](/azure/sql-database/sql-database-active-geo-replication-portal).
* **Azure Resource Manager**: Resource Manager inherently provides logical isolation of components across regions. This means that logical failures in one region are less likely to impact other regions.

### Benefits of Azure paired regions number key

* **Physical isolation**: When possible, Azure services prefer at least 300 miles of separation between datacenters in a regional pair (although this isn't practical or possible in all geographies). Physical datacenter separation reduces the likelihood of both regions being affected simultaneously as a result of natural disasters, civil unrest, power outages, or physical network outages. Isolation is subject to the constraints within the geography, such as geography size, power, network infrastructure availability, and regulations.
* **Platform-provided replication**: Some services, such as geo-redundant storage, provide automatic replication to the paired region.
* **Region recovery order**: In the event of a widespread outage, recovery of one region is prioritized out of every pair. Apps that are deployed across paired regions are guaranteed to have one of the regions recovered with priority. If an app is deployed across regions that are not paired, recovery might be delayed. In the worst case, the chosen regions might be the last two to be recovered.
* **Sequential updates**: Planned Azure system updates are rolled out to paired regions sequentially, not at the same time. This helps minimize downtime, the effect of bugs, and logical failures in the rare event of a bad update.
* **Data residency**: To meet data residency requirements for tax and law-enforcement jurisdiction purposes, a region resides within the same geography as its pair (with the exception of Brazil South).

Microsoft also complies with international data-protection laws regarding transfers of customer data across borders. For example, to accommodate the continuous flow of information required by the international business (including the cross-border transfer of personal data), many Microsoft business cloud services offer customers [European Union Model Clauses](/compliance/regulatory/offering-eu-model-clauses) that provide additional contractual guarantees around transfers of personal data for in-scope cloud services. European Union data-protection authorities have validated the Microsoft implementation of the EU Model Clauses as being in line with the rigorous privacy standards that regulate international data transfers by companies operating in its member states.

In addition to our commitments under the Standard Contractual Clauses and other model contracts, Microsoft is certified to the EU-U.S. Privacy Shield Framework as set forth by the U.S. Department of Commerce regarding the collection, use, and retention of personal information transferred from the European Union to the United States. Microsoft participation in the EU-U.S. Privacy Shield applies to all personal data that is subject to the Microsoft Privacy Statement and is received from the EU, European Economic Area, and Switzerland. Microsoft also abides by Swiss data-protection law regarding the processing of personal data from the European Economic Area and Switzerland.

> [!IMPORTANT]
> Microsoft will not transfer to any third-party (not even for storage purposes) data that you provide to Microsoft through the use of our business cloud services, and that are covered under the [Microsoft Online Services Terms](https://azure.microsoft.com/support/legal/).
