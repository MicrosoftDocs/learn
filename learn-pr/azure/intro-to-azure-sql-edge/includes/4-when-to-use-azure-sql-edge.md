Here, you decide whether Azure SQL Edge is a suitable choice for your organization. You need to implement a database at the network edge to support your IoT apps. Your development team wants to focus on creating and deploying IoT apps to your edge network. They don't want to take time learning new skills or working with unfamiliar tools. Meanwhile, your security team wants to ensure protection for any apps exposed at the edge, using powerful security and compliance features. In this unit, you evaluate whether Azure SQL Edge addresses your organization's needs, by using the following criteria:

- Connectivity and broadband limitations.
- Latency.
- Data security, privacy, and ownership.
- Synchronization with, and connectivity to, back-end systems.
- Familiarity.

## Decision criteria

| Criteria | Analysis |
| --- | --- |
| Connectivity and broadband limitations | Cloud-based solutions work only when an active internet connection is available. However, many IoT apps must be able to work while offline. Also, some IoT devices might be connected to limited bandwidth connections, which can potentially prohibit decision making. |
| Latency | Cloud-based solutions can introduce round-trip delays between an action and its response. However, many IoT apps require near real-time response. |
| Data security, privacy, and ownership | IoT devices often operate in less secure locations. Additionally, there are risks posed to any device, and its data, when exposed to the internet. It's also important that any selected solution meets corporate and governmental compliance standards. |
| Synchronization and connectivity to back-end systems | IoT apps can be constrained if they can't easily connect to, and communicate with, back-end systems. Either in an organization's datacenter, their hosted cloud services, or both. |
| Familiarity | Many existing IoT platforms rely on solution-specific APIs and databases that developers don’t know well. These solutions might also require specific language skills that developers don’t have. |

## Apply the criteria

Let's explore how Azure SQL Edge addresses these criteria.

- Connectivity and broadband limitations. Azure SQL Edge supports solutions that work with, or without, network connectivity.
- Latency. Azure SQL Edge provides a powerful, local database. It negates needing to forward all data to a cloud-based database, which eliminates latency.
- Data security, privacy, and ownership. Azure SQL Edge implements RBAC and ABAC, encryption, and data classification, all of which helps you secure and control access to your IoT apps' data.
- Synchronization and connectivity to back-end systems. Azure SQL Edge provides compatibility with many Microsoft apps and services, including SQL Database, SQL Server, and Azure Cosmos DB.
- Familiarity. Azure SQL Edge shares the same codebase as SQL Server. As such, developers with skills in SQL Server or SQL Database can reuse their code and skills to build your organization's edge-specific solutions on Azure SQL Edge. Using Azure SQL Edge, you can develop your apps once, and deploy them potentially anywhere.

Consider using Azure SQL Edge when your IoT apps:

- Must work both when connected to the internet and when offline.
- Are connected to the internet by slow or intermittent connections.
- Require near real-time response.
- Are operating in less-secure environments, such as schools, factories, or vehicles.
- Must be able to comply with governmental data-compliance regulations.
- Need to exchange data with systems such as Azure SQL Managed Instance, Azure SQL Database, SQL Server, and Azure Cosmos DB.
- Are developed by people with skills in SQL Server and related technologies and tools.
