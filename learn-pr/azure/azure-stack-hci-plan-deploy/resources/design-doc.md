
# Module design

## Module: Plan and deploy Azure Stack HCI

### Summary description

In this module, you’ll learn to plan for and deploy Azure Stack HCI, including identifying Azure HCI-supported workloads, determining the optimal size of an Azure Stack HCI cluster, and evaluating Azure Stack HCI integration with Azure.

**Problem statements:**

- "What is the process of planning for Azure Stack HCI?"
- "For what types of workloads is Azure Stack HCI most suitable?"
- "What are Azure integration options for Azure Stack HCI?"
- "What is the process of deploying Azure Stack HCI?"
- "How do I verify that an Azure Stack HCI deployment is correctly deployed?"

### Audience role(s)

Mark with an (X) which roles this module applies to.

| Administrator    | X   | Data analyst    |     | Functional consultant |     |
|------------------|-----|-----------------|-----|-----------------------|-----|
| AI Edge engineer |     | Data engineer   |     | Maker                 |     |
| AI engineer      |     | Data scientist  |     | Security engineer     |     |
| Business analyst |     | Database admin  |     | Solution architect    | X   |
| Business owner   |     | Developer       |     | Student               |     |
| Business user    |     | DevOps engineer |     | Technology manager    | X   |

### Product(s)

Mark with an (X) which products this module applies to.

| Azure                     | X   | azure-data-science-vm          |     | azure-machine-learning-studio |     |
|---------------------------|-----|--------------------------------|-----|-------------------------------|-----|
| azure-active-directory    |     | azure-data-share               |     | azure-maps                    |     |
| azure-advisor             |     | azure-databricks               |     | azure-monitor                 | X   |
| azure-bot-service         |     | azure-digital-twins            |     | azure-portal                  |     |
| azure-cdn                 |     | azure-event-grid               |     | azure-redis-cache             |     |
| azure-clis                |     | azure-event-hubs               |     | azure-resource-manager        |     |
| azure-cloud-shell         |     | azure-functions                |     | azure-sdks                    |     |
| azure-cognitive-services  |     | azure-hdinsight                |     | azure-service-bus             |     |
| azure-container-instances |     | azure-iot-central              |     | azure-sql-data-warehouse      |     |
| azure-container-registry  |     | azure-iot-edge                 |     | azure-sql-database            |     |
| azure-cosmos-db           |     | azure-iot-hub                  |     | azure-storage                 |     |
| azure-cost-management     |     | azure-key-vault                |     | azure-stream-analytics        |     |
| azure-data-catalog        |     | azure-language-understanding   |     | azure-virtual-machines        |     |
| azure-data-factory        |     | azure-machine-learning-service |     |                               |     |

### Prerequisites

- Basic knowledge of Azure.
- Basic knowledge of Window Server hyper-converged Storage Spaces Direct technology.
- Basic knowledge of Windows Server converged networking.

### Scenario with task(s) at end

Contoso is a medium-size financial-services company with its headquarters in London and a branch office in New York. It’s currently operating almost entirely on-premises, with the majority of its compute environment running on the Windows Server and Linux operating system platforms, including virtualized workloads on Windows Server 2012 R2 and Microsoft Hyper-V hosts in Windows Server 2016. Its internal IT staff is well-versed in Microsoft technologies, including its virtualization and software-defined datacenter offerings.

In recent months, as part of datacenter consolidation and modernization initiatives, Contoso IT migrated some of its applications to a range of Azure IaaS and platform as a service (PaaS) services. However, several highly regulated workloads have to remain in the on-premises datacenters. 

Two of these workloads present a particular challenge because of their performance and resiliency requirements. The first workload is a group of heavily utilized Microsoft SQL Server instances that are hosting transactional databases for the Contoso’s loan-origination department, with the application tier running on Ubuntu 18.04. The second workload is an isolated Virtual Desktop Infrastructure (VDI) farm for users in Contoso’s securities research department, which is supposed to replace an aging Windows Server 2012 R2–based Remote Desktop Services (RDS) deployment.

Contoso’s Chief Information Officer (CIO) realizes that implementing these workloads will require additional hardware investment, and before making the investment, she wants to verify that the extra expense will help the IT organization deliver a modern technological solution and accelerate the datacenter-consolidation initiative. She also wants to ensure that it promotes a consistent management approach that leverages existing IT skills, and if possible, integrates with some of the cloud services from which Contoso is already benefiting, such as Azure Monitor. It’s also critical that the new solution provide multiple levels of high availability and resiliency, thereby protecting them from localized failures and facilitate disaster recovery to another on-premises location.

IT management has started its search for solutions that would satisfy these requirements. As lead system engineer, they've asked you to assist with the search and implement a proof-of-concept environment that would help identify the most viable candidate.

### Learning objectives

- Describe the process of planning for Azure Stack HCI.
- Explain how to select Azure Stack HCI hardware.
- Describe the Azure Stack HCI integration options.
- Explain how to deploy Azure Stack HCI.
- Explain how to verify a deployment of Azure Stack HCI.

### References

- Azure Stack HCI documentation: [https://docs.microsoft.com/en-us/azure-stack/hci/](https://docs.microsoft.com/en-us/azure-stack/hci/)

### Related MS Learn content

- &lt;If known, add related and useful MS Learn modules or learning paths here.&gt;

### Learn module outline

|#|Title|Duration|Source content|
|---|---|---|---|
|1|Introduction|2 minutes|Module 1: Introducing Azure Stack HCI, Lesson 1: Overview of the Azure Stack HCI implementation process|
|2|Identify types of Azure Stack HCI workloads|10 minutes   |   |
|3|Identify hardware suitable for Azure Stack HCI workloads |10 minutes |   |
|4|Identify the Azure Stack HCI integration options |10 minutes  |   |
|5|Deploy Azure Stack HCI |5 minutes  |   |
|6|Verify deployment of Azure Stack HCI |10 minutes   |   |
|7|Knowledge Check |2 minutes   |   |
|8|Summary  |3 minutes   |   |

### Estimated module duration

52 minutes

### Demo details

|Title|Duration|Link to resource content|
|---|---|---|
|Installing a hyper-converged cluster by using Windows Admin Center|5 minutes| [https://docs.microsoft.com/en-us/windows-server/manage/windows-admin-center/use/deploy-hyperconverged-infrastructure](https://docs.microsoft.com/en-us/windows-server/manage/windows-admin-center/use/deploy-hyperconverged-infrastructure) |