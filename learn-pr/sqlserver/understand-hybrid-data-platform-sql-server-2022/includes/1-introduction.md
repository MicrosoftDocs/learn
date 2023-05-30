---
ms.custom:
  - build-2023
---
In this module, you'll learn about SQL Server 2022 scenarios that can be extended to the cloud and understand the advantages of using a hybrid approach to increase productivity and innovation, and how you can connect to Azure for managing disaster recovery, near real-time analytics, and enhancements to authentication.

Understanding how SQL Server operates as a hybrid data platform can be valuable in modernizing your data estate, improving scalability and control. Moreover, the hybrid data platform enables you to explore the benefits of cloud computing before fully migrating to Azure, providing a valuable, low-risk opportunity to evaluate performance and reliability metrics before a full commitment.

To leverage a hybrid data platform for SQL Server, you have the flexibility to choose from various options and models, such as:

* Azure SQL Managed Instance Link
* Azure Arc-enabled SQL Server 
* Azure Synapse Link for SQL Server
* Azure Active Directory (Azure AD) authentication
* Microsoft Purview

A cloud connected service can also be adopted in mixed ways, such as storing SQL Server data files on Azure Storage, or used to replace on-premises services such as failing over SQL Server to Azure during a disaster recovery or migration scenario.

SQL Server 2022 connects to the cloud with the following Azure services as seen in the following diagram:

:::image type="content" source="../media/module-2-sql-server-2022-cloud-connected.png" alt-text="Diagram of SQL Server 2022 cloud connected capabilities.":::

### Increased agility and innovation

In order to keep up with the rapid pace of technological advancements, services are requiring substantial amount computing resources due to the ever-increasing volume of data. To address this challenge, a hybrid approach for your data services may provide the agility, and at the same time scalability for your services. Managing and maintaining a disaster recovery site for your data can be a difficult and costly task. Getting started on utilizing business continuity through Azure SQL Managed Instance link can help ease with some of this burden and ease your transition to the cloud.

SQL Server may not include every service or capability necessary for specific needs. Hence, there are times where cloud services offer additional capabilities as services to supplement the existing features of SQL Server.

We'll highlight the hybrid services available on SQL Server 2022 that can help you optimize costs for several workloads, avoid unnecessary infrastructure investments, and increase team agility. Additionally, a hybrid approach can also be adopted by organizations with an outdated on-premises legacy setup that is no longer supported by third-party vendors.

### Security enhancements

A properly secured hybrid cloud infrastructure can not only provide a safe environment for your services, but also enhance your overall security framework.

Security solutions should provide visibility and control over the network, as well as various security options to safeguard hybrid cloud environments. Additionally, compliance and governance are important considerations when it comes to security in certain industries like finance, government, and healthcare.

For this reason, it is essential to have a security solution that adheres to industry standards and regulations in hybrid cloud environments to ensure data security, confidentiality, and integrity. 

Azure Active Directory authentication for SQL Server 2022 is a central authentication repository that supports advanced authentication methods like Azure Active Directory Universal with Multi-Factor Authentication and Azure Active Directory access token where a company can add an extra layer of security to their authentication process. 

With a cloud-based central authentication authority like Azure Active Directory, you can take advantage of the latest SQL Server security features, while also reducing the risk of security breaches caused by weak or reused passwords.

In SQL Server 2022, Microsoft Purview can be used to manage data access policies at scale, simplifying access management and ensuring consistent policies across an organization. Access policies include Data and DevOps types, allowing Azure AD accounts to log into SQL Server and have access to read data or perform specific tasks. Access policies can be deleted or applied across multiple instances for central governance.

**Watch this video** to see the cloud connected capabilities of SQL Server 2022:

> [!VIDEO https://learn-video.azurefd.net/vod/player?show=data-exposed&ep=sql-server-2022-cloud-connected-ep-2-data-exposed]

## Learning objectives

At the end of this module, you will be able to:

- Describe the services that support SQL Server data files in a hybrid platform
- Describe how Azure Arc-enabled SQL Server works
- Discover best practices for disaster recovery using Azure SQL Managed Instance
- Understand how to implement near real time analytics with Azure Synapse Link for SQL Server
- Explain cloud connected technologies that support security with Azure Active Directory (Azure AD) authentication
- Explore Microsoft Purview access policies for SQL Server

## Prerequisites

- Basic working knowledge of SQL Server, including deployment, security, query processing, and high availability
- Fundamental knowledge of the T-SQL language
- Basic knowledge of Azure concepts, including subscriptions, resource groups, Infrastructure-as-a-Service (IaaS) and Platform-as-a-Service (PaaS)
