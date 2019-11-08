# Module Design

## Title

Introduction to securing data at rest on Azure

## Role(s)

- Solution Architect
- Developer

## Level

- Beginner

## Product(s)

- Azure Key Vault
- Azure Storage
- Azure PaaS services
- Client-side encryption
- Storage service encryption

## Prerequisites

- Basic understanding of SSL/TLS encryption
- Basic knowledge of Azure PaaS services

## Summary

Identify the data used in your organization and ensure it's stored securely on Azure. Store secrets securely and leverage client-side and storage service encryption to protect your data.

## Learning objectives

- Identify the types of data your organization is using and the security requirements surrounding that data
- Identify the encryption capabilities for services on Azure

## Chunk your content into subtasks

Identify the subtasks of *Secure your data at rest with encryption on Azure*

| Subtask                                                   | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet?           | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| --------------------------------------------------------- | ------------------------------------------------------------ | -------------------------------------------------------- | ---------------------------------------------------------- | ------------------------------------------------------------ |
| Classify your data and protect confidential information   | need to identify and classify  data                          | Knowledge Check                                          | Identify the types of data your organization               | yes                                                          |
| Secure data at rest with Azure Storage Service Encryption | select the proper encryption method and/or service to protect this data | Knowledge Check                                          | Identify the encryption capabilities for services on Azure | yes                                                          |
| Secure data at rest in Azure SQL and Cosmos DB            | select the proper encryption method and/or service to protect this data | Knowledge Check                                          | Identify the encryption capabilities for services on Azure | Yes                                                          |
| Keep your keys and secrets safe using Azure Key Vault     | select the proper encryption method and/or service to protect this data | Knowledge Check                                          | Identify the encryption capabilities for services on Azure | yes                                                          |

## Outline the units

1. **Introduction**

*A manufacturing organization is moving several systems to Azure. They are storing a variety of data within these systems, such as customer details, financial information, and intellectual property. They need to correctly identify and classify this data, to ensure they secure it to meet business and regulatory requirements. Once this data is classified, they need to select the proper encryption method and/or service to protect this data.*

1. **Classify your data and protect confidential information.**

    To understand what level of encryption is required for your product you need to classify the data to understand its risk. By the end of this unit, you will be able to:

    - Understand the classifications of Confidential, Internal or Public
    - Understand structured-vs-unstructured data.
    - Understand the options for At Rest, Keys and Secrets, and In Transit.

    Cover the following topics:

    - Data exists in one of three basic states: at rest, in process and in transit.
      - All three states require technical solutions for the data classification, albeit the principles of data classification should be the same for each. For example, data that is classified as confidential needs to remain confidential be it at rest, in process or in transit.
    - Data classifications:
      - Terminology can change between organizations but typically fall into the three categories usually mapping to a High/Medium/Low sensitivity
      - Confidential (High) - Data that if lost would be catastrophic to either an individual or organization and may include data such as
        - Personal Data
        - Financial Records
        - Business data such as code or intellectual property
        - Legal Data
        - Authentication Data, credentials, cryptographic keys, certificates.
      - Internal Use Only (Medium)
        - Information including files and data that would not have a severe impact on an individual if lost or destroyed - this data may include
          - Emails which can be deleted or distributed without causing a crisis
          - Documents and files which do not include confidential data. 
        - With the exception of data that is made public or is confidential, all data within a business organization can be classified as Internal Use Only by default.
      - Public (Low)
        - Data and files that are not critical to business needs or have deliberately been released to the public for their use.
        - This could include marketing material, press announcement
    - Structured-vs-Unstructured 
      - Structured Data, for example, is a database or spreadsheet
      - Unstructured may be a document, source code or email.
      - It's easier and less time consuming to manage structured data, however, organizations usually have much more unstructured data than structured.
    - Regardless of type, it is essential for organizations to manage data sensitivity which helps ensure sensitive or confidential data assets are managed with greater oversight than data assets considered public or free to distribute
    - After data is classified,  you need to have an approach to protect confidential data. At rest, Keys and Secrets, in transit:
      - At rest, this can be addressed by Azure Storage Service Encryption. Covered in a later unit
      - For Keys and Secrets,  this can be addressed by Azure Key Vault and managed identities. Covered in a later unit.
      - For In transit, this can be addressed by SSL/TLS communications. Covered in a later unit.

    **Knowledge check**

    - Would an email be structured or unstructured data?
    - Which of *credential*, *PR release*, or *public key* could be classified as Public(Low)?
    - Would a group email not classified as confidential be Internal Use or Public classification?

1. **Secure data at rest with Azure Storage Service Encryption**

    You have an environment which is classified as confidential. It is your company's policy to encrypt data at rest be it in the cloud or on-premises or personal device.  By the end of this unit, you will be able to:

    - Understand what is Encryption at rest.
    - Why you would use Encryption at rest.
    - What is SSE
    - What is ADE
    - Understand how you would use Azure Storage Service Encryption.

    Cover the following topics

    - Data at rest is inactive data that is stored physically in a digital form (e.g IaaS operating systems, databases, files)
    - Encryption at Rest is the encoding (encryption) of data when it is persisted.
    - Microsoft offers Azure Storage Service Encryption for data at rest for its storage accounts
    - Whilst it is unlikely a physical hard disk in an Azure datacenter would be stolen (compared to losing a laptop), it is important to put in place safeguards in place to meet your organization's obligations and strategy for classified data.
    - Azure Storage Service Encryption (SSE) for data at rest helps you protect your data to meet your organizational security and compliance commitments.
    - SSE supports the following storage types:
      - Azure Blob 
      - Azure Table Storage
      - Azure Files
      - Azure Queue Storage
      - Azure Managed Disks
    - SSE key features:
      - SSE is encrypted through 256-bit AES encryption - one of the strongest block ciphers
      - SSE is enabled for all new and existing storage accounts and cannot be disabled
      - Data is secured by default,  in all storage tiers - both standard and premium.
      - A storage account can be configured to use a Customer-managed Key (BYOK) for Azure Storage at Rest or a Microsoft managed Key.
      - Microsoft managed keys are as secure as Customer-managed keys and live in an Azure Key Vault.
    - For IaaS VMs, Microsoft have Azure Disk Encryption (ADE) for Windows and Linux platforms
      - This provides an additional layer of security defense and is NOT enabled as default.
      - ADE leverages BitLocker for Windows and DM-Crypt for Linux
      - ADE integrates with Azure Key Vault to manage the disk-encryption keys.
    - Azure client-side encryption for storage
      - What is client-side encryption for storage?
      - Why would you use client-side encryption for storage?
      - How would you configure client-side encryption for storage in Azure?

    **Knowledge check**

    - PaaS: For Azure storage managed accounts is encryption enabled as default?
    - IaaS: Is Azure Disk Encryption a replacement or additional layer of security?
    - IaaS: Is Azure Disk Encryption enabled as default?

1. **Secure data at rest in Azure SQL and Cosmos DB**

    In order to comply with regulations, your company wants to ensure that all data in all of its databases is encrypted once it has been stored in Azure.  

    - By the end of this unit you will be able to:
      - Understand why you should enable encryption at rest on a database in Azure.
      - Understand how encryption at rest works on a database in Azure.
      - Understand how to enable encryption at rest on a database in Azure.

    Cover the following topics:

    - Why would you need encryption at rest for a database on Azure?
    - Describe encryption at rest for SQL DB.
    - Explain how to enable encryption at rest for SQL DB.
    - Describe encryption at rest for Cosmos DB.
    - Explain how to enable encryption at rest for Cosmos DB.

    **Knowledge check**

    1. How would you enable encryption at rest for your Azure SQL DB?
    1. Which objects are encrypted at rest in an Azure SQL DB?

1. **Keep your keys and secrets safe using Azure Key Vault**

    Your company's Intellectual Property is it's application source code.  As such, it is classified as confidential and you need to ensure no credentials or certificates are hard coded or shared into source code management products. By the end of this unit you will be able to:

    - Understand what is Azure Key Vault.
    - Understand why you would use Azure Key Vault.
    - Understand how you would use Azure Key Vault.
    - Understand the use case for consuming Azure Key Vault with managed identities

    Discuss the following topics:

    - When securing code there is sensitive information you want to protect, for example:
      - Connection strings, such as a Database connection string
      - Encryption keys used in your application to encrypt your data
      - Certificates. E.G. x509 certificates used in HTTPS/SSL communications which consist of a private and a public key, both of which should be stored securely.
      - For the storing of these, we can use Azure Key Vault
    - Azure Key Vault:
      - Centralized, secure key management
      - Azure Key Vault provides a way to securely store credentials, secrets, and other keys
      - Have the ability to Grant/Revoke access to people and applications using either the portal or the CLI
      - Provides auditing and logging abilities
      - Key rotation and versioning to ensure they are not compromised.
      - Versioning is important if you use Azure key vault to encrypt your Data at rest and rotate that key - your data will no longer accessible. With versioning,  you keep all versions of the key - which will allow you to decrypt your disk.
      - By separating credentials from code, and keeping them in Azure Key Vault you reduce the possibility of your credentials being pushed to a source code management tool such as GitHub and being compromised externally.
      - Hardware Security Module (HSM).  Azure Key Vault gives you the option to backend to HSM. This takes your key and keeps a copy in a secure device for added security ensuring tamper resistance
      - Natively supported by other Microsoft Azure services (e.g Database, Storage, App Services), and also accessible via API/PowerShell and CLI

    **Knowledge Check**

    - Should credentials for a confidential environment be stored in plain text or a centralized, auditable tool?
    - What is Managed identities used for?
    - For a system-assigned managed identity, would credential be automatically deleted if the instance was deleted?

- **Summary**

  *{How did you solve the problem in the initial scenario with the knowledge learned in the module?}*

  - Basics of data classification to understand the differing requirements of data sensitivity.
  - Walk through the capabilities of at rest encryption on Azure.
  - Walk through the capabilities of Azure Key Vault and Managed Identities for Azure resources
  - Walk through the benefits and concept behind encryption in transit with SSL/TLS 

## Notes

Encryption at rest doc - <https://docs.microsoft.com/en-us/azure/security/azure-security-encryption-atrest>

Storage security guide - <https://docs.microsoft.com/en-us/azure/storage/common/storage-security-guide?toc=/azure/security/toc.json&bc=/azure/security/breadcrumb/toc.json#encryption-at-rest>

This module may be limited on interactivity, as it's more of a tour of the encryption capabilities on Azure, and properly classifying data. If a good hands-on exercise is identified though, we can look at incorporating it.

Resources:

<https://docs.microsoft.com/en-us/azure/sql-database/sql-database-data-discovery-and-classification>
<https://docs.microsoft.com/en-us/azure/architecture/data-guide/scenarios/securing-data-solutions>
<https://docs.microsoft.com/en-us/azure/architecture/guide/technology-choices/data-store-overview>
<https://docs.microsoft.com/en-us/azure/security/azure-security-services-technologies>