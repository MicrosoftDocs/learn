
# DevRel Azure IaaS microlearning: Implement Microsoft Azure Sentinel design

# Module Design

## Module: Deploy Microsoft Azure Sentinel

### Summary description

Contoso is planning to deploy Azure Sentinel to modernize their security operations with a cloud-native SIEM, to get centralized security visibility across their enterprise while eliminating complexity of infrastructure maintenance.

In this module, you'll learn about the necessary roles and permissions you must consider during deployment, and how to connect data sources to Azure Sentinel and manage its log data.
<!-- delete "and" before "how to connect data sources..." -->

**Problem statements:**

- "What roles and permissions must I consider when planning to implement Azure Sentinel?"
- "How can I connect data sources to Azure Sentinel?"

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

| azure                     | X   | azure-data-science-vm          |     | azure-machine-learning-studio |     |
|---------------------------|-----|--------------------------------|-----|-------------------------------|-----|
| azure-active-directory    |     | azure-data-share               |     | azure-maps                    |     |
| azure-advisor             |     | azure-databricks               |     | azure-monitor                 |     |
| azure-bot-service         |     | azure-digital-twins            |     | azure-portal                  | X   |
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
|                           |     | Azure Sentinel                 | X   | Azure Log Analytics workspace | X   |

### Prerequisites

To derive the best learning experience from this module, you should have
knowledge of, and experience with:

- Access to Azure Portal
- Fundamental Microsoft Azure administration.
- Azure Monitor and its Log Analytics workspace.

### Scenario with task(s) at end
Contoso is a medium-size financial services company in London with a branch office in New York. Contoso has moved aggressively to Azure services, and they currently use Microsoft 365 and Azure AD. They also use Azure Identity Protection, Microsoft Cloud App Security, Azure Advanced Threat Protection, Windows Advanced Threat Protection, Office 365 Advanced Threat Protection, Intune, and Azure Information Protection. They are also using the free security posture management capabilities provided by Azure Security Center and are upgrading to standard paid version to get threat protection for resources running in Azure and on-premises. In addition, Contoso has other non-Microsoft assets to monitor and protect.
<!-- delete "and" before "they currently use Microsoft 365 and Azure AD" -->
<!-- Replace "Intune" with "Microsoft Intune" -->

Contoso’s IT director realizes that their Security Analysts face a huge triage burden as they not only have to sift through a sea of alerts, but also correlate alerts from different product dashboards manually or by using a traditional correlation engine.
<!-- "a sea of alerts" might not translate to other languages, please consider replacing with "numerous alerts" -->

The IT director believes that Azure Sentinel could provide a means to address the pain points of Contoso. They are:

- multiple products
- to many alerts triaged across dashboards
- security operations team having to setup and maintain IT infrastructure, taking their time away from security tasks

She  believe that Azure Sentinel will help them save time performing complex investigations, and improve their security operations (secops).

As Contoso's lead system engineer and Azure administrator, you've been asked to set up a proof-of-concept environment trial to verify whether Azure Sentinel can harness the power of the cloud and artificial intelligence to help their security operations teams efficiently identify and stop cyberattacks before they cause harm.

In this module, you will learn about the deployment considerations to include the necessary roles and permission. You will also learn how to connect data sources to Azure Sentinel and how to manage its log data.


### Learning objectives

- Describe Azure Sentinel.
- Describe deployment considerations for Azure Sentinel.
- Create an Azure Log Analytics workspace.
- Enable Azure Sentinel.
- Explain how to deploy built-in connectors to Azure Sentinel.
- Explain how to connect syslogs and common-event format events to Azure Sentinel.
- Explain how to manage Azure Sentinel log data.

### References

- \<If known now, add reference links that will be helpful to students. Otherwise, add during development.\>

### Related MS Learn content

- \<If known, add related and useful MS Learn modules or learning paths here.\>

### Learn module outline

|#|Title|Duration|Source content|
|---|---|---|---|
|1|Introduction|2 minutes|<ul><li><p>Some reuse of Azure Hybrid Security Monitoring</p></li><li><p>Some reuse of AZ-500 Azure Security Engineer</p></li><li><p>Microsoft documentation:</p><ul><li><p>https://docs.microsoft.com/en-us/azure/sentinel/quickstart-onboard</p></li> <li><p><a href="https://docs.microsoft.com/en-us/azure/sentinel/connect-data-sources">https://docs.microsoft.com/en-us/azure/sentinel/connect-data-sources</a></p></li><li><p><a href="https://docs.microsoft.com/en-us/azure/sentinel/extend-sentinel-across-workspaces-tenants">https://docs.microsoft.com/en-us/azure/sentinel/extend-sentinel-across-workspaces-tenants</a></p></li><li><p>https://docs.microsoft.com/en-us/azure/sentinel/roles</p></li>|
|2|Consider deployment options|5 minutes   |   |
|3|Describe Azure Sentinel permissions and roles|5 minutes   |   |
|4|Connect data sources |10 minutes  | Built in connectors, common event format, syslog, Rest API.Ensure we have a section that provides details and highlights the integration with third party connection for ingestion of on-premises data. Probably could be an H2 section in the 4th unit maybe. |
|5|Consider data-connection methods |10 minutes  | Service to Service integration, External solutions via API, External Solutions via Agent |
|6|Manage logs |5 minutes   | Managing Sentinel data |
|7|Demonstration: Deploy Azure Sentinel and connect to Azure AD using a built-in connector|8 minutes  |   |
|8| Summary | 3 minutes |   |

### Estimated module duration

53  minutes

### Demo details

|Title|Duration|Link to resource content|
|---|---|---|
|Demonstration: Deploy Azure Sentinel and connect to Azure AD using a built-in connector|8 | |
