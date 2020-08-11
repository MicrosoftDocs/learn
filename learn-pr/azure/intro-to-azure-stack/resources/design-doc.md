## Module: Introduction to Azure Stack

### Summary description

This module describes the differences between the capabilities of global Azure, Azure Stack Hub, Azure Stack HCI, and Azure Stack Edge. It also describes each product's most common use cases to help you make the best choice for delivering Microsoft cloud-based services for your organization.

**Problem statements:**

- "What are the differences between global Azure, Azure Stack Hub, Azure Stack HCI, and Azure Stack Edge?"
- "What are the most common use cases of global Azure, Azure Stack Hub, Azure Stack HCI, and Azure Stack Edge?"

### Audience role(s)

Mark with an (X) which roles this module applies to.

| Administrator    | X   | Data analyst    |     | Functional consultant |     |
|------------------|-----|-----------------|-----|-----------------------|-----|
| AI Edge engineer | X   | Data engineer   |     | Maker                 |     |
| AI engineer      |     | Data scientist  |     | Security engineer     | X   |
| Business analyst |     | Database admin  | X   | Solution architect    | X   |
| Business owner   | X   | Developer       |     | Student               |     |
| Business user    |     | DevOps engineer |     | Technology manager    | X   |

### Product(s)

Mark with an (X) which products this module applies to.

| Azure                     | X   | azure-data-science-vm          |     | azure-machine-learning-studio |     |
|---------------------------|-----|--------------------------------|-----|-------------------------------|-----|
| azure-active-directory    |     | azure-data-share               |     | azure-maps                    |     |
| azure-advisor             |     | azure-databricks               |     | azure-monitor                 | X   |
| azure-bot-service         |     | azure-digital-twins            |     | azure-portal                  | X   |
| azure-cdn                 |     | azure-event-grid               |     | azure-redis-cache             |     |
| azure-clis                |     | azure-event-hubs               |     | azure-resource-manager        |     |
| azure-cloud-shell         |     | azure-functions                | X   | azure-sdks                    |     |
| azure-cognitive-services  |     | azure-hindsight                |     | azure-service-bus             |     |
| azure-container-instances |     | azure-iot-central              | X   | azure-sql-data-warehouse      |     |
| azure-container-registry  |     | azure-iot-edge                 | X   | azure-sql-database            | X   |
| azure-cosmos-db           |     | azure-iot-hub                  | X   | azure-storage                 | X   |
| azure-cost-management     |     | azure-key-vault                |     | azure-stream-analytics        |     |
| azure-data-catalog        |     | azure-language-understanding   |     | azure-virtual-machines        | X   |
| azure-data-factory        |     | azure-machine-learning-service |     |                               |     |

### Prerequisites

- Basic knowledge of Azure.
- Basic knowledge of Window Server software-defined storage.
- Basic knowledge of Windows Server Software-Defined Networking.
- Basic knowledge of IoT technologies.

### Scenario with task(s) at end

Contoso is a medium-size financial-services company with its headquarters in London and a branch office in New York. It’s currently operating almost entirely on-premises, with the majority of its compute environment running on the Windows Server and Linux operating system platforms, including virtualized workloads on Windows Server 2012 R2 and Microsoft Hyper-V hosts in Windows Server 2016. Its internal IT staff is well-versed in Microsoft technologies, including its virtualization and software-defined datacenter offerings.

In recent months, as part of datacenter consolidation and modernization initiatives, Contoso IT migrated some of its applications to a range of Azure IaaS and platform as a service (PaaS) services. However, several highly regulated workloads have to remain in the on-premises datacenters.

Two of these workloads present a particular challenge because of their performance and resiliency requirements. The first workload is a group of heavily utilized Microsoft SQL Server instances that are hosting transactional databases for the Contoso’s loan-origination department, with the application tier running on Ubuntu 18.04. The second workload is an isolated Virtual Desktop Infrastructure (VDI) farm for users in Contoso’s securities research department, which is supposed to replace an aging Windows Server 2012 R2–based Remote Desktop Services (RDS) deployment.

Contoso’s Chief Information Officer (CIO) realizes that implementing these workloads will require additional hardware investment, and before she makes the investment, she wants to verify that the extra expense will help the IT organization deliver a modern technological solution and accelerate the datacenter-consolidation initiative. She also wants to ensure that it promotes a consistent management approach that leverages existing IT skills, and if possible, integrates with some of
the cloud services from which Contoso is already benefiting, such as Azure Monitor. It’s also critical that the new solution provide multiple levels of high availability and resiliency, thereby protecting them from localized failures and facilitating disaster recovery to another on-premises location.

IT management has started its search for solutions that would satisfy these requirements. As lead system engineer, they've asked you to assist with the search and implement a proof-of-concept environment that would help identify the most viable candidate.

### Learning objectives

- Describe the differences between global Azure, Azure Stack Hub, Azure Stack HCI, and Azure Stack Edge.
- Describe the most common use cases of global Azure, Azure Stack Hub, Azure Stack HCI, and Azure Stack Edge.

### References

- Azure Stack documentation: [https://docs.microsoft.com/en-us/azure-stack/](https://docs.microsoft.com/en-us/azure-stack/)

### Related MS Learn content

- &lt;If known, add related and useful MS Learn modules or learning paths here.&gt;

### Learn module outline

|#|Title|Duration|Source content|
|---|---|---|---|
|1|Introduction|2 minutes|<p>Module 1: Introducing Azure Stack HCI</p><p>Lesson 1: Overview of Azure Stack</p><ul><li><p>Azure Stack portfolio</p></li><li><p>Azure Stack HCI solutions</p></li><li><p>Azure Stack Hub</p></li><li><p>Azure Stack Edge</p></li>|
|2|Describe Azure Stack portfolio|3 minutes  |   |
|3|Identify features of Azure Stack Hub |7 minutes   |   |
|4|Identify features of Azure Stack Edge |7 minutes  |   |
|5|Identify features of Azure Stack HCI |7 minutes  |   |
|6|Identify use cases of Azure Stack Hub |7 minutes   |   |
|7|Identify use cases of Azure Stack Edge |7 minutes   |   |
|8|Identify use cases of Azure Stack HCI |7 minutes  |   |
|9|Summary  |3 minutes   |   |

### Estimated module duration

52 minutes

### Demo details

| **Title** | **Duration** | **Link to resource content** |
|-----------|--------------|------------------------------|
| N/A       |              |                              |