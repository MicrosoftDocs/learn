Your development team want to be able to focus on creating and deploying IoT apps to your edge network. They don't want to have to learn new skills or work with unfamiliar tools. Your security team want to make sure that any apps exposed at the edge are protected by powerful security and compliance features. When you're thinking about which database to implement at the edge to support your IoT apps, Azure SQL Edge should be a consideration. In this unit, you'll evaluate whether Azure SQL Edge addresses your organization's needs. You'll evaluate against the following criteria:

- Connectivity and broadband limitations
- Latency
- Data security, privacy, and ownership
- Synchronization with and connectivity to backend systems
- Familiarity

## Decision criteria

To help you determine whether Azure SQL Edge is a good choice for your organization, use the criteria described in the following table.

| Criteria                                            | Analysis                                                     |
| --------------------------------------------------- | ------------------------------------------------------------ |
| Connectivity and broadband limitations              | Cloud-based solutions work only when an active internet connection is available. But many IoT apps must be able to work while offline. In addition, some IoT devices might be connected to limited bandwidth connections, potentially prohibiting decision-making. |
| Latency                                             | Cloud-based solutions can introduce round-trip delays between an action and its response. However, many IoT apps require near real-time response. |
| Data security, privacy, and ownership               | IoT devices often operate in insecure locations. In addition, there are risks posed to any device, and its data, when exposed to the internet. It's also important that any solution selected meets corporate and governmental compliance standards. |
| Synchronization and connectivity to backend systems | IoT apps can be significantly constrained if they cannot easily connect to and communicate with backend systems in your organization's datacenter or with your hosted cloud services. Or both. |
| Familiarity                                         | Many existing IoT platforms rely on solution-specific APIs and databases that developers don’t know well. These solutions might also require specific language skills that developers don’t yet have. |


## Apply the criteria

Let's explore how Azure SQL Edge addresses these criteria. 

- **Connectivity**. Azure SQL Edge supports solutions that work with or without network connectivity.
- **Latency**. Azure SQL Edge provides a powerful, local database. This negates the need to forward all data to a cloud-based database, thereby eliminating latency. 
- **Data security, privacy, and ownership**. Azure SQL Edge implements RBAC and ABAC, encryption, and data classification to help you secure and control access to your IoT apps' data. 
- **Synchronization and connectivity to backend systems**. Azure SQL Edge provides compatibility with many Microsoft apps and services, including SQL Database, SQL Server, and Azure Cosmos DB.
- **Familiarity**. Because Azure SQL Edge shares the same codebase, developers with skills in SQL Server or SQL Database can re-use their code and skills to build your organization's edge-specific solutions on Azure SQL Edge. Using Azure SQL Edge, you can develop your apps once, and deploy them potentially anywhere. 

Consider using Azure SQL Edge when your IoT apps:

- Must  work both when connected to the internet and when offline.
- Are connected to the internet by slow or intermittent connections.
- Require near real-time response.
- Are operating in insecure environments, such as schools, factories, or vehicles.
- Must be able to comply with governmental data compliance regulations.
- Need to exchange data with systems such as Azure SQL Database, SQL Server, and Azure Cosmos DB.
- Are developed by people with skills in SQL Server and related technologies and tools.

