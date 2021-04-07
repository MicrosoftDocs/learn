Azure SQL Edge can help those organizations interested in innovating in the IoT space. It provides a data platform that's:

- Flexible enough to support the full range of IoT scenarios.
- Powerful enough to support edge compute.
- Secure enough to help meet the privacy needs of IoT applications.
- Fully compatible with a familiar ecosystem of products, tools, and services.

## What are the challenges of IoT development?

IoT systems can be found in many organizations, including those in: 

- Retail
- Finance
- Manufacturing
- Energy
- Government
- Education

These organizations use IoT devices to work with data originating in many scenarios, including the following:  smart factories;  remote medical assistance; predictive maintenance; analyzing satellite images; autonomous vehicles; point of sale devices; monitoring wind farms/solar energy panels; onsite inventory system; home security; and many others.

Given the wide range of industry sectors, and of IoT devices used, it can be challenging for developers to create secure and consistent apps to work with these devices. Often, developers resort to using proprietary database systems to manage all this data. This approach results in developers having to learn new skills on new platforms. It can also mean that performance and security might be compromised. 

The following table identifies some of the more common challenges faced by developers when working with IoT devices in these contexts.

| Challenge                                                    | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| IoT apps require a powerful database engine                  | Many IoT apps require near real-time analytics. Other apps require the ability to gather data when disconnected from backend systems. In these, and other, use cases, sending all data to the cloud can be very costly and bandwidth intensive. This means that the IoT devices need access to a local database engine which must be lightweight and powerful. |
| IoT apps require seamless connectivity to the backend ecosystem | IoT apps can be significantly constrained if they cannot easily connect to and communicate with backend systems in the organization's datacenter or with their hosted cloud services. Or Both. It's therefore vital that any system implemented at the edge on IoT devices can communicate with industry standard database systems. |
| IoT apps can run in insecure environments                    | Since many IoT apps might run in cars, hospitals, and factories, security and privacy are important. Therefore, the platform selected to work with data in these environments must be secure. It must be trusted by users and developers alike. |
| Building solutions on unfamiliar platforms                   | Many existing IoT platforms rely on solution-specific APIs and databases that developers don’t know well. These solutions might also require specific language skills that developers don’t yet have. It's important that any apps that you deploy to the edge to interact with IoT devices are built using standard components and tools with which developers are already familiar. |

## SQL Edge definition

Azure SQL Edge is a data engine built on the same codebase as SQL Server and Azure SQL Database. Azure SQL Edge:

- Has a small-footprint.
- Is edge-optimized.
- Is machine-learning (ML)-capable.

Because Azure SQL Edge shares the same codebase, developers with skills in SQL Server or SQL Database can re-use their code and skills to build your organization's edge-specific solutions on Azure SQL Edge. Using Azure SQL Edge, you can develop your apps once, and deploy them potentially anywhere. 

:::image type="content" source="../media/compatible.png" alt-text="A graphic depicting Azure SQL, SQL Server, and Azure SQL Edge.":::

> [!IMPORTANT] 
> Although Azure SQL Edge is built on the same codebase as SQL Server and SQL Database, the use cases for these products are different. Azure SQL Edge is optimized for IoT use cases and workloads. SQL Server and SQL Database, in contrast, are built for mission-critical data-management solutions and LOB apps.


## How to use SQL Edge to face challenges of IoT development 

Azure SQL Edge helps address the challenges when working with apps for IoT devices in the following ways:

- Supports solutions that work with or without network connectivity.
- Helps secure data movement of the local edge data to on-premises datacenters or to Azure.
- Provides support for standard tooling, programming languages, and a familiar query language (T-SQL) which help to provide compatibility with existing code.

   > [!TIP]
   > SQL Edge supports a large subset of the T-SQL surface area with which developers are familiar.

- Enables artificial intelligence (AI) and analytics at the edge.
- Includes native support for ingesting time-series data.
- Delivers excellent security and provides support for regulatory compliance.


> [!NOTE] 
> Beyond these compatibilities, you can also use familiar BI tools such as Microsoft Power BI and Tableau software. In addition, your developers can also use tools such as Azure Data Studio, SQL Server Management Studio, and Visual Studio. 





