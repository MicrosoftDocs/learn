# Module Design

## Title

Introduction to securing data at rest on Azure

## Role(s)

- Solution architect
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

Identify the data used in your organization and ensure it's stored securely on Azure. Store secrets securely, and leverage client-side and storage service encryption to protect your data.

## Learning objectives

- Identify the types of data your organization is using and the security requirements surrounding that data
- Identify the encryption capabilities for services on Azure

## Chunk your content into subtasks

Identify the subtasks of *Secure your data at rest with encryption on Azure*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- |---|---|---|---|
| Data Classification in the Azure Cloud Platform | The need to identify and classify data, ensure they secure it to meet business and regulatory requirements| Knowledge Check & Exercise | 1 | Yes |
| Discover and classify data using Azure SQL Server | The need to identify and classify data, ensure they secure it to meet business and regulatory requirements| Knowledge Check & Exercise | 1 | Yes |
| Data at rest encryption with Azure | The need to select the proper encryption method and/or service | Knowledge Check | 2 | Yes |
||||||


## Outline the units

1. **Introduction**

    *A manufacturing organization is moving several systems to Azure. They are storing a variety of data within these systems, such as customer details, financial information, and intellectual property. They need to properly identify and classify this data, to ensure they secure it to meet business and regulatory requirements. Once this data is classified, they need to select the proper encryption method and/or service to protect this data.*

2. **Understand data discovery and classification with Azure SQL Server**

    List the content that will enable the learner to *Understand data discovery and classification with Azure SQL Server*:

    - Data Classification in the Azure Cloud Platform
        - Roles and responsibilities in the cloud
        - Compliance considerations
        - Data Classification Process
        - Walk through of data ownership\stewardship

    - Discover and classify data using Azure SQL Database
        - Summary of Azure SQL Database capabilities
        - Understanding taxonomies
        - Dynamic Data masking

3. **Exercise - Discover and classify data using Azure SQL Database**

List the steps which apply the learning content from previous unit (separate out each language):

    1. Run a script in the Cloud Shell to create an azure SQL server and database.
    2. Complete the steps to enable base sql database configuration using ATP.
    3. git clone source code with sample data.
    4. Run through the classification process in the portal
    5. Apply automatic classifications and create some manual classifications
    6. Access sensitive data on the sql database
    7. Audit sensitive data access using SQL DB audit.

4. **Knowledge check**

    What types of questions will test *Identify the types of data your organization is using and the security requirements surrounding that data*?

    - Which is the correct data classification process?
    - Why are compliance considerations important? 
    - What is the correct T-SQL statement for data classification in Azure SQL?

5. **Data at rest Encryption on Azure**

    List the content that will enable the learner to *Data at rest Encryption on Azure*:

    - What is encryption at rest on Azure
        - Introduction to encryption at rest
        - Why you should encrypt data at rest
        - Base components of Azure at rest encryption

    - Azure Key Vault
        - Introduction to Azure Key Vault
        - Manage keys, secrets and certificates

    - Encryption at rest for Azure Services
        - Storage Service Encryption
        - Client-side encryption
        - Azure Storage encryption
        - Azure SQL Server
        - Azure SQL DW
        - Azure Data Lake

6. **Knowledge check**

    What types of questions will test *Identify the encryption capabilities for services on Azure*?

    - What is the prime consideration for encrypting data at rest on Azure?
    - Which are the correct features of Azure encryption at rest?
    - Which method is used to invoke keys from Azure Key Vault?
    - Which Azure services have encryption at rest enabled by default?

7. **Summary**

   *{How did you solve the problem in the initial scenario with the knowledge learned in the module?}*

    - Basics of data classification to understand the differing requirements of data sensitivity.
    - Azure SQL used as an example process to discovering and classifying data
    - Walk through the capabilities of at rest encryption on Azure.
    - Whistle stop tour of encryption at rest for key data services


## Notes

Encryption at rest doc - https://docs.microsoft.com/en-us/azure/security/azure-security-encryption-atrest

Storage security guide - https://docs.microsoft.com/en-us/azure/storage/common/storage-security-guide?toc=/azure/security/toc.json&bc=/azure/security/breadcrumb/toc.json#encryption-at-rest

This module may be limited on interactivity, as it's more of a tour of the encryption capabilities on Azure, and properly classifying data. If a good hands on exercise is identified though, we can look at incorporating it.

Resources:

https://docs.microsoft.com/en-us/azure/sql-database/sql-database-data-discovery-and-classification
https://docs.microsoft.com/en-us/azure/architecture/data-guide/scenarios/securing-data-solutions
https://docs.microsoft.com/en-us/azure/architecture/guide/technology-choices/data-store-overview
https://docs.microsoft.com/en-us/azure/security/azure-security-services-technologies
