Many organizations are considering digital transformation projects as their traditional IT hardware and infrastructure comes to the end of life. Here, we'll explore features of both on-premises and cloud environments.  We'll also explore the factors businesses must consider when exploring each option.

## On-premises

### Computing Environment

On-premises environments require an investment in physical equipment to execute applications and services. This equipment includes physical servers, network infrastructure, and storage. The equipment must have power, cooling, and requires periodic maintenance by qualified personnel. The servers must also have at least one operating system (OS) installed, and possibly more than one if the organization is utilizing virtualization technology.  Each installed OS could potentially require its own licensing cost.

### Licensing Model

With on-premises servers, OS and software licenses were typically sold per server or per CAL (Client Access Licensing). As companies grew, the licensing arrangements became more rigid and restrictive.

### Maintainability

Maintaining on-premises systems requires maintaining the hardware, firmware, drivers, BIOS, operating system, software, and anti-virus software. These are additional considerations associated with the operational costs of such an environment. Organizations will look to reduce these costs where it makes sense.

### Scalability

When scaling up a server is no longer possible, administrators look to scale out their operations. To scale an on-premises server horizontally, the server administrator would add an additional server node to a cluster.  Clustering leverages either a hardware or software load balancer to distribute incoming network requests to an individual node of the cluster.  A limitation of server clustering is that the hardware for each server in the cluster must be identical. Therefore, once the server cluster reaches maximum capacity, a server administrator must replace or upgrade each node in the cluster.

### High Availability

High availability systems must be available most of the time. Service Level Agreements (SLAs) will dictate specific expectations. Three 9's, four 9's, or five 9's commonly refers to 99.9%, 99.99%, or 99.999% system uptime. To calculate this in terms of the number of hours, multiply these percentages by the number of hours in a single year (8760).

| Uptime Level    | Uptime Hours per Year    | Downtime Hours per Year    |
| --------------- | ------------------------ | -------------------------- |
| 99.9%           | 8751.24                  | (8760 – 8751.24) = 8.76 hrs per year |
| 99.99%          | 8759.12                  | (8760 – 8759.12) = 0.88 hrs per year |
| 99.999%         | 8759.91                  | (8760 - 8759.91) = 0.09 |

The higher the uptime required, the more expensive it can become for on-premises servers.

### Supportability

There are hundreds of vendors for physical server hardware, requiring server administrators to learn many different platforms.  This makes it more difficult for organizations to find human resources with the diverse skills required to administer, maintain and support these systems.

### Multi-lingual Support

In on-premises SQL Server systems, supporting multi-lingual scenarios is difficult and expensive. One concern with multiple languages is the impact on the sort order of text data, as different languages can sort text data differently. To support this, the SQL Server Database Administrator must install and configure the collation settings for the data. To leverage these settings, SQL Database Developers needed to consider multi-lingual functionality at design time. This increases the complexity of managing and maintaining such systems.

### Total Cost of Ownership (TCO)

The term Total Cost of Ownership (TCO) is used to describe the total cost of owning a given technology. In on-premises systems, TCO includes:

- Hardware Costs
- Software Licensing Costs
- Labor Costs (Installation, upgrades, maintenance)
- Data Center Overhead Costs (power, telecommunications, building, heating & cooling)

From a cost perspective, it is difficult to match the on-premises expense to actual usage. Servers are purchased with additional capacity to accommodate future growth, so when a server is purchased there will always be excess capacity that isn't used. When an on-premises server is at maximum capacity, even an incremental increase in resource demand will require the purchase of additional hardware. 

From a finance perspective, due to the large expense of on-premises server systems, these costs were often capitalized, meaning that the costs were allocated across the expected lifetime of the server equipment.  Capital expenditures limited IT Managers from being able to upgrade server equipment when it was required during the expected server lifetime, limiting the server system's ability to meet the increased demand.  In cloud solutions, expenses are recorded on the financial statements each month as an expense instead of a capital expenditure. Therefore, there is no expected server lifetime to limit the IT manager's ability to upgrade the system to meet an increase in demand when required.

## Cloud

### Computing Environment

Cloud computing environments contain the physical and logical infrastructure to host services, virtual servers, intelligent applications, and containers as if they belonged to the organization. There is no capital investment required for physical servers. Instead, an organization will provision services in the cloud and only pay for what they use. In addition, operational costs are reduced as the servers and services are moved into the cloud.

An organization can provision anything from virtual servers to clusters of containerized apps to Azure services within minutes, and all the physical and logical infrastructure is automatically created and handled in the background, reducing the complexity and cost of creating the services.

Where on-premises servers used physical and virtual disks, the cloud platform refers to storage more generically as there are many different storage types such as Azure Blob Storage, File Storage, and Disk Storage. Complex systems often leverage each type of storage as part of their technical architecture. With disk storage, customers can choose to either have Microsoft manage their disk storage or the customer can pay a premium to have greater control over disk allocation.

### Maintainability

In the cloud, Microsoft manages many operations to create a stable computing environment that's included as part of the investment for Microsoft Azure products. Microsoft manages key infrastructure services such as physical hardware, computer networking, firewalls and network security, data center fault tolerance, compliance, and physical security over the plant or buildings. Microsoft also spends nearly 1 billion US dollars each year in battling cybersecurity threats and applies operating system updates and firmware updates on behalf of the customer. This allows Data Engineers to focus on more data engineering and eliminating some of the system complexity.

### Scalability

Whereas, achieving scalability in on-premises systems was complicated and time-consuming, achieving scalability in the cloud can be as simple as the point and click of a mouse in many cases. Scalability in the cloud is typically measured in compute units. Compute units may be defined differently for each Microsoft Azure product being evaluated. 

### High Availability

In Azure, Microsoft commits to duplicating customers content for redundancy and high availability. Many of the services and platforms also have specific Service Level Agreements (SLAs) to ensure customers are aware of the available capabilities of the platform that they are using.

### Supportability

Cloud systems are easy to support because the environments are standardized. When Microsoft applies an update, the update applies to all consumers of the product.

### Multi-lingual support

In cloud systems, it's common to store data as a JSON file that includes the Language Code ID (LCID) to identify the language used in the data. Apps processing the data can use translation services such as the Bing Translate API to convert the data into an expected language when the data is consumed or as part of a data preparation process.

### Total Cost of Ownership

In cloud systems like Microsoft Azure, costs are tracked by subscriptions, which can be based upon usage including compute units, the number of hours, or the number of transactions. The hardware, software, disk storage, and labor costs are included in this amount. Due to economies of scale, it is difficult for an on-premises system to compete with the cloud concerning the measurement of the service usage.

On-premises server systems rarely matched the cost of operating the system with the actual usage of the system. In cloud systems, the cost more closely matches the actual usage of the system. However, if a cloud administrator provisions a service that isn't used by the business, there will be costs with no usage, referred to as underutilization.  Organizations can reduce underutilization by adopting a best practice to only provision production instances once an application is ready to be deployed to production.  This might require developers to use emulators like the Azure Cosmos DB emulator or the Azure Storage emulator to develop cloud applications without incurring production costs during development and testing.

### Understand Lift and Shift

When moving to the cloud, one strategy that many customers will use is to migrate from physical or virtualized on-premises servers to Azure Virtual Machines. This is known as "Lift and Shift."  In Lift and Shift, server administrators migrate an application from a physical environment to Azure Virtual machines without rearchitecting the applications.

While Lift and Shift provides immediate benefits such as the ability to provide higher availability, reduce operational costs, and be able to transfer workloads from one data center to another, the application is unable to take advantage of the many features available within Azure.

While Lift and Shift may seem appealing in the short term, organizations are using the migration as an opportunity to transform their business practices by creating new versions of their applications and databases to take advantage of the new services in Azure such as Cognitive Services, Bots and some of the available machine learning capabilities.
