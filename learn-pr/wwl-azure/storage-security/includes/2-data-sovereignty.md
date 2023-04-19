
**What is Data Sovereignty?** \- Data sovereignty is the concept that information, which has been converted and stored in binary digital form, is subject to the laws of the country or region in which it is located. Many of the current concerns that surround data sovereignty relate to enforcing privacy regulations and preventing data stored in a foreign country or region from being subpoenaed by the host country or region’s government.

In Azure, customer data might be replicated within a selected geographic area for enhanced data durability during a major data center disaster, and in some cases will not be replicated outside it.

### Paired regions

Azure operates in multiple geographies around the world. An Azure geography is a defined area of the world that contains at least one Azure Region. An Azure region is an area within a geography, containing one or more datacenters.

Each Azure region is paired with another region within the same geography, forming a regional pair. The exception is Brazil South, which is paired with a region outside its geography. Across the region pairs Azure serializes platform updates (or planned maintenance), so that only one paired region is updated at a time. If an outage affecting multiple regions, one region in each pair will be prioritized for recovery.

:::image type="content" source="../media/az500-data-sovereignty-7c0c9521.png" alt-text="A Geography box contains a regional pair box, which in turn contains two region boxes, each with a box in it labeled datacenter.":::


We recommend that you configure business continuity and disaster recovery (BCDR) across regional pairs to benefit from Azure’s isolation and VM policies. For applications that support multiple active regions, we recommend using both regions in a region pair where possible. Multiple regions will ensure optimal availability for applications and minimized recovery time in a disaster.

### Benefits of Azure paired regions

 -  **Physical isolation** \- When possible, Azure services prefer at least 300 miles of separation between datacenters in a regional pair (although longer distance isn't practical or possible in all geographies). Physical datacenter separation reduces the likelihood of both regions being affected simultaneously as a result of natural disasters, civil unrest, power outages, or physical network outages. Isolation is subject to the constraints within the geography, such as geography size, power and network infrastructure availability, and regulations.
 -  **Platform-provided replication** \- Some services such as geo-redundant storage provide automatic replication to the paired region.
 -  **Region recovery order** \- If a broad outage occurs, recovery of one region is prioritized out of every pair. Applications that are deployed across paired regions are guaranteed to have one of the regions recovered with priority. If an application is deployed across regions that are not paired, recovery might be delayed. In the worst case, the chosen regions might be the last two to be recovered.
 -  **Sequential updates** \- Planned Azure system updates are rolled out to paired regions sequentially, not at the same time. A staged roll-out helps minimize downtime, the effect of bugs, and logical failures in the rare event of a bad update.
 -  **Data residency** \- To meet data residency requirements for tax and law enforcement jurisdiction purposes, a region resides within the same geography as its pair (except for Brazil South).

Microsoft also complies with international data protection laws regarding transfers of customer data across borders. For example, to accommodate the continuous flow of information required by international business (including the cross-border transfer of personal data), many Microsoft business cloud services offer customers European Union Model Clauses that provide extra contractual guarantees around transfers of personal data for in-scope cloud services. European Union data protection authorities have validated the Microsoft implementation of the EU Model Clauses as being in line with the rigorous privacy standards that regulate international data transfers by companies operating in its member states.

In addition to our commitments under the Standard Contractual Clauses and other model contracts, Microsoft is certified to the EU-U.S. Privacy Shield framework as set forth by the U.S. Department of Commerce regarding the collection, use, and retention of personal information transferred from the European Union to the United States. Microsoft participation in the EU-U.S. Privacy Shield applies to all personal data that is subject to the Microsoft Privacy Statement, and is received from the EU, European Economic Area, and Switzerland. Microsoft also abides by Swiss data protection law regarding the processing of personal data from the European Economic Area and Switzerland.

Microsoft will not transfer to any third party (not even for storage purposes) data that you provide to Microsoft by using our business cloud services, and that are covered under the Microsoft Online Services Terms.

> [!NOTE]
> No matter where customer data is stored, Microsoft does not control or limit the locations from which customers, or their end users might access their data.
