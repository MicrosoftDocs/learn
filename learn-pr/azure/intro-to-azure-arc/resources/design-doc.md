# DevRel Azure IaaS microlearning: Module 1, Introduction to Microsoft Azure Arc

# Module design

## Module: Introduction to Azure Arc

### Summary description

This module introduces you to Azure Arc, and describes its available services and preview services. You’ll learn about Azure Arc for Servers, and Azure Arc for Kubernetes.

**Problem statements:**

- "How can I apply Azure policies to on-premises Windows Server workloads?"
- "How can I review on-premises Windows Server instances in the Azure portal?"
- "How can I review a Kubernetes cluster in the Azure portal?"
- "How can I review connected data services in the Azure portal?"

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
| Business analyst |     | Database admin  |     | Solution architect    | X   |
| Business owner   |     | Developer       |     | Student               | X   |
| Business user    |     | DevOps engineer |     | Technology manager    | X   |

### Product(s)

Mark with an (X) which products this module applies to.

| azure | X   | azure-data-science-vm |     | azure-machine-learning-studio |     |
|-------|-----|-----------------------|-----|-------------------------------|-----|
| azure-active-directory |     | azure-data-share |     | azure-maps  |     |
| azure-advisor          |     | azure-databricks |     | azure-monitor   |     |
| azure-bot-service      |     | azure-digital-twins |     | azure-portal  | X   |
| azure-cdn              |     | azure-event-grid    |     | azure-redis-cache  |     |
| azure-clis             |     | azure-event-hubs  |     | azure-resource-manager  |     |
| azure-cloud-shell      | X   | azure-functions   |     | azure-sdks       |     |
| azure-cognitive-services  |     | azure-hindsight  |     | azure-service-bus  |     |
| azure-container-instances |     | azure-iot-central|     | azure-sql-data-warehouse  |     |
| azure-container-registry  |     | azure-iot-edge  |     | azure-sql-database     |     |
| azure-cosmos-db           |     | azure-iot-hub     |     | azure-storage                 |     |
| azure-cost-management     |     | azure-key-vault     |     | azure-stream-analytics   |     |
| azure-data-catalog        |     | azure-language-understanding   |     | azure-virtual-machines  | X   |
| azure-data-factory        |     | azure-machine-learning-service |     |                  |     |

### Prerequisites

To derive the best learning experience from this module, it's important that you have knowledge about, and experience with:

- Personal computer operating systems.
- Fundamentals of virtualization.
- Azure IaaS workloads.

### Scenario with task(s) at end

Contoso is a medium-size, financial-services company in London with a branch office in New York. Most of its compute environment runs on-premises on Windows Server. These include virtualized workloads on Windows Server 2012 R2 hosts, and Contoso IT staff are currently migrating Contoso servers to Windows Server 2019. Some line of business apps run on Linux. 

Contoso’s IT director realizes that the company's operational model is outdated, and that it has limited automation and too much reliance on dated technology. Therefore, the Contoso IT Engineering team is exploring Azure capabilities, and they want to determine whether Azure services might help them modernize their current operational model through automation and virtualization.

As the IT team's lead system engineer and server administrator, you've been asked to configure a proof-of-concept environment to verify whether Azure services can help modernize Contoso's IT infrastructure and help them meet business goals.


Contoso will continue to operate an on-premises environment after they begin migrating workloads to Azure IaaS virtual machines (VMs). Consequently, the ability to apply Azure policies to on-premises workloads will be important. Additionally, administrators will need to review on-premises server instances in the Azure portal and must be able to use the Azure portal to review Kubernetes clusters.

In this module, you'll learn to describe Azure Arc and implement Azure Arc with on-premises server instances, and Azure Arc-enabled Kubernetes. Finally, you’ll learn to implement Azure Policies with Azure Arc.

### Learning objectives

- Onboard Windows Server instances into Azure Arc.
- Use the Azure portal to connect hybrid machines to Azure.
- Use Azure Arc to manage Window Server instances.
- Describe Azure Arc-enabled Kubernetes.
- Integrate Azure Arc integration with Azure Monitor.

### References

- Azure Arc: [https://aka.ms/azure-azure-arc?azure-portal=true](https://aka.ms/azure-azure-arc?azure-portal=true)
- What is Azure Arc for servers (preview)? [https://aka.ms/azure-arc-servers?azure-portal=true](https://aka.ms/azure-arc-servers?azure-portal=true)
- What is Azure Arc-enabled Kubernetes Preview? [https://aka.ms/azure-arc-servers?azure-portal=true](https://docs.microsoft.com/en-us/azure/azure-arc/kubernetes/overview)


### Related MS Learn content

- N/A

### Learn module outline

|#|Title|Duration|Source content|
|---|---|---|---|
|1|Introduction|2 minutes|Some reuse of Microlearning module “Manage hybrid workloads with Azure Arc”. WS-012 ILT course, Module 3: Management and Operational Monitoring in Hybrid Scenarios, Lesson 2: Azure Arc|
|2|Describe Azure Arc|5 minutes   |   |
|3|Onboard server instances into Azure Arc   |7 minutes   |   |
|4|Demonstration: Use the Azure portal to connect hybrid machines to Azure |5 minutes  |   |
|5|Use Azure Arc to manage Window Server instances   |4 minutes  |   |
|6|Describe Azure Arc-enabled Kubernetes  |4 minutes   |   |
|7|Use Azure Policy with Azure Arc   |6 minutes  |   |
|8| Integrate Azure Arc with Azure Monitor                       |4 minutes  |   |
|9|Summary  |2 minutes   |   |

### Estimated module duration

42 minutes

### Demo details


|Title|Duration|Link to resource content|
|---|---|---|
|Connect hybrid machines to Azure from the Azure portal|5| [https://aka.ms/onboard-portal?azure-portal=true"](https://aka.ms/onboard-portal?azure-portal=true)<br> (Video already exists:) <br> [https://www.microsoft.com/videoplayer/embed/RE4zf4p](https://www.microsoft.com/videoplayer/embed/RE4zf4p)|