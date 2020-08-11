# Module design

## Module: Introduction to Microsoft Azure Stack HCI Core Technologies

### Summary description

This module introduces Azure Stack HCI technologies. You’ll learn about the main Azure Stack HCI technology parts, including Hyper-V
replication, shared virtual hard disk (VHDX), scale-out file servers, Cluster Shared Volumes (CSVs), Software-Defined Networking (SDN), Storage Spaces Direct (S2D), guarded fabric, and cluster sets.

**Problem statements:**

- "How can I use Azure Stack HCI core technologies to provide fault tolerance for server workloads?"
- "How can I use Hyper-V and Hyper-V replication to protect critical virtual machines?"
- "How can I use CSVs?"
- "How can I use scale-out file servers?"
- "How can I use SDN and S2D?"
- "What are guarded fabric and cluster sets?"

### Audience level

Mark with an (X) which roles this module applies to.

|          |     |              |     |          |     |
|----------|-----|--------------|-----|----------|-----|
| Beginner |     | Intermediate | X   | Advanced |     |

### Audience role(s)

Mark with an (X) which roles this module applies to.

| Administrator    | X   | Data analyst    |     | Functional consultant |     |
|------------------|-----|-----------------|-----|-----------------------|-----|
| AI Edge engineer |     | Data engineer   |     | Maker                 |     |
| AI engineer      |     | Data scientist  |     | Security engineer     |     |
| Business analyst |     | Database admin  | X   | Solution architect    | X   |
| Business owner   |     | Developer       |     | Student               | X   |
| Business user    |     | DevOps engineer |     | Technology manager    | X   |

### Product(s)

Mark with an (X) which products this module applies to.

| azure                     | X   | azure-data-science-vm          |     | azure-machine-learning-studio |     |
|---------------------------|-----|--------------------------------|-----|-------------------------------|-----|
| azure-active-directory    |     | azure-data-share               |     | azure-maps                    |     |
| azure-advisor             |     | azure-databricks               |     | azure-monitor                 |     |
| azure-bot-service         |     | azure-digital-twins            |     | azure-portal                  | X   |
| azure-cdn                 |     | azure-event-grid               |     | azure-redis-cache             |     |
| azure-clis                |     | azure-event-hubs               |     | azure-resource-manager        |     |
| azure-cloud-shell         | X   | azure-functions                |     | azure-sdks                    |     |
| azure-cognitive-services  |     | azure-hdinsight                |     | azure-service-bus             |     |
| azure-container-instances |     | azure-iot-central              |     | azure-sql-data-warehouse      |     |
| azure-container-registry  |     | azure-iot-edge                 |     | azure-sql-database            |     |
| azure-cosmos-db           |     | azure-iot-hub                  |     | azure-storage                 |     |
| azure-cost-management     |     | azure-key-vault                |     | azure-stream-analytics        |     |
| azure-data-catalog        |     | azure-language-understanding   |     | azure-virtual-machines        | X   |
| azure-data-factory        |     | azure-machine-learning-service |     |                               |     |

### Prerequisites

- Management of the Windows Server operating system.
- Understanding of core Microsoft compute, storage, networking, and virtualization technologies.
- Conceptual understanding of Hyper-V and Hyper-V Replica in Windows Server.
- Conceptual understanding of failover clustering.
- Basic understanding of SDN and S2D.
- Familiarity with Windows PowerShell.

### Scenario with task(s) at end

Contoso is a medium-size financial-services company in London with a branch office in New York. Most of its compute environment runs on-premises on Windows Server, including virtualized workloads and cluster services on Windows Server 2012 R2 hosts. Contoso IT staff are migrating Contoso servers to Windows Server 2019, and
the server vendors are guaranteeing their hardware meets the Microsoft Windows Server Hardware catalog requirements for HCI.

Contoso’s IT director realizes that Contoso has an outdated operational model with limited data-protection technologies and a reliance on dated technology. The Contoso IT Engineering team is exploring Azure capabilities, but still have business requirements that require on-premises services. They want to determine whether Azure Stack services might
assist with modernizing the current on-premises failover clusters, especially regarding the new technologies that Windows Server 2019 and Azure Stack HCI provide.

As the lead system engineer and server administrator, you've been asked to set up a proof-of-concept environment to verify whether Azure Stack services can help modernize your IT infrastructure and meet business goals.

Contoso will continue to operate an on-premises environment after they begin migrating workloads to Azure infrastructure as a service (IaaS) virtual machines (VMs). Consequently, the ability to apply Azure Stack HCI technologies to on-premises Windows Server workloads will be important. Additionally, administrators need to
understand SDN and S2D.

In this module, you'll learn the purpose and features of Azure Stack HCI technologies and provide a plan that uses Azure Stack HCI with your new server purchases.

### Learning objectives

- Explain Hyper-V and Hyper-V replication.
- Describe failover clustering.
- Describe CSVs.
- Implement scale-out file servers.
- Describe software-defined storage.
- Describe SDN.
- Explain how to use guarded fabric and cluster sets.

### References

- As below:

### Related MS Learn content

- Azure Stack HCI solution overview: [https://docs.microsoft.com/en-us/azure-stack/hci/overview](https://docs.microsoft.com/en-us/azure-stack/hci/overview)
- Get started with Azure Stack HCI and Windows Admin Center: [https://docs.microsoft.com/en-us/azure-stack/hci/get-started](https://docs.microsoft.com/en-us/azure-stack/hci/get-started)
- Fault tolerance and storage efficiency in Azure Stack HCI: [https://docs.microsoft.com/en-us/azure-stack/hci/concepts/fault-tolerance](https://docs.microsoft.com/en-us/azure-stack/hci/concepts/fault-tolerance)
- Software Defined Networking (SDN): [ttps://docs.microsoft.com/en-us/windows-server/networking/sdn/](https://docs.microsoft.com/en-us/windows-server/networking/sdn/) 

### Learn module outline

|#|Title|Duration|Source content|
|---|---|---|---|
|1|Introduction|2 minutes|WS-013 ILT course, Module 1: Introducing Azure Stack HCI, Lesson 2: Overview of Azure Stack HCI technologies|
|2|Explain Hyper-V and Hyper-V replication |7 minutes   |   |
|3|Describe failover clustering  |5 minutes   |   |
|4|Use CSVs in failover clustering |5 minutes  |   |
|5|Implement scale-out file servers |5 minutes   |   |
|6|Use software-defined storage |9 minutes   |   |
|7|Demonstration: Manage hyperconverged infrastructure with Windows Admin Center  |7 minutes  |   |
|8|Describe Software-Defined Networking |5 minutes |   |
|9|Explain guarded fabric  |5 minutes |  |
|10|Explain cluster sets | 5 minutes |  |
|12|Summary |2 minutes   |   |

### Estimated module duration

60 minutes

### Demo details

|Title|Duration|Link to resource content|
|---|---|---|
| Demonstration: Manage hyperconverged infrastructure with Windows Admin Center|10 minutes|[https://docs.microsoft.com/en-us/windows-server/manage/windows-admin-center/use/manage-hyper-converged](https://docs.microsoft.com/en-us/windows-server/manage/windows-admin-center/use/manage-hyper-converged)|
