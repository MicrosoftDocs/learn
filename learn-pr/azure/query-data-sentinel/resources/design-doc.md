# Module: Query, visualize, and monitor Azure Sentinel data

## Learner roles

- Administrator
- Auditor
- Risk practitioner
- Security engineer
- Solution architect
- Student
- Technology manager

## Learner level

- **Beginner**: Introductory and overview material that assumes little or no topic expertise. Covers topic concepts, functions, features, and benefits.

## Products taught

- Microsoft Azure Sentinel
- Azure Data explorer
- Azure Sentinel workbooks

## Prerequisites

To get the best learning experience from this module, you should have:

- Familiarity with security operations in an organization.
- Basic experience with Azure services.
- Basic knowledge of operational concepts such as monitoring, logging, and alerting.

## Module summary description

In this module, you'll learn about Azure Sentinel workbooks and their visual interactive data reports for security and compliance. Workbooks present<!-- "retrieve?" --> data from Log Analytics workspaces using Kusto Query Language.

## Subtasks in this module

- Use Azure Sentinel workbooks to visualize security data.
- Use Kusto Query Language to query data stored in Azure Log Analytics.
- Use built-in workbooks.
- Create custom workbooks.

## Lab exercise

- Draft lab exercise title: Create a workbook using a template
  - Task 1. Explore a Logs page in Azure Sentinel
  - Task 2. Create and edit a workbook form templates
- In this exercise, students interact with Azure Sentinel workbooks and review collected security data.
- Feasibility questions or concerns?
  - Create a new Azure Sentinel workbook
  - Visualize data by adding texts, queries, and a graph into a workbook

## Module learning objectives

After completing this module, you'll be able to:

- Visualize security data using Azure Sentinel workbooks.
- Query your logs using Kusto Query Language.
- Explore workbook capabilities.
- Create an Azure Sentinel workbook.

## Estimated module duration

49 minutes

## Module outline of units

1. Introduction
2. Exercise Setup
3. Monitor and visualize data
4. Query data using Kusto Query Language
5. Use default Azure Sentinel workbooks
6. Create a new Azure Sentinel workbook
7. Exercise unit
8. Summary

## First unit: Introduction

**Type of unit:** Introduction unit

**Estimated unit duration:** 3 minutes

### Module scenario

Contoso, Ltd. is a medium-size financial services company in London with a branch office in New York. Contoso has moved aggressively to Azure services, and it currently uses Microsoft 365 and Azure Active Directory (Azure AD). It also uses Azure AD Identity Protection, Cloud App Security, Azure Advanced Threat Protection (Azure ATP), Microsoft Defender for Endpoint, Microsoft Office 365 Advanced Threat Protection, Endpoint Protection, and Microsoft Azure Information Protection. Contoso is also using the paid version of Azure Security Center for threat protection for resources that are running on Azure and on-premises. Additionally, Contoso has other non-Microsoft assets to monitor and protect.

A recent incident with compromised identities led to exposed customer data. The Contoso Security Operations (SecOps) team wants to ensure that proper monitoring and reporting methods are in place. You need to demonstrate the Azure Sentinel reporting and monitoring capabilities, and how they can alert your organization to potential security incidents.

## Second unit: Exercise unit - Prepare the environment for exercise unit

**Type of unit:** Exercise unit

**Estimated unit duration:** 5 minutes

**Use of supplemental demo video:** Potentially

### Key content per learning objective

In this exercise, you'll setup:

- Create an Azure Sentinel instance
- Create resources needed for exercise units.

## Third unit: Monitor and visualize data

**Type of unit:** Learning content unit

**Estimated unit duration:** 6 minutes

### Key content per learning objective

After you complete this unit, you&#39;ll be able to visualize security data using Azure Sentinel workbooks. Unit topics include:

- Introduction to the Azure Sentinel Logs page
- Navigate through the Logs page

## Fourth unit: Query data using Kusto Query Language

**Type of unit:** Learning content unit

**Estimated unit duration:** 8 minutes

### Key content per learning objective

After you complete this unit, you&#39;ll be able to query your logs using Kusto Query Language. Unit topics include:

- Query a table
- Test your Kusto Query Language queries
- Review the graphical results<!-- View is a non-accessibility term, so I replaced it here with "Review." -->

## Fifth unit: Use default Azure Sentinel workbooks

**Type of unit:** Learning content unit

**Estimated unit duration:** 10 minutes

### Key content per learning objective

After you complete this unit, you&#39;ll be able to explore existing workbook capabilities. Unit topics include:

- Explore existing workbook capabilities
- Work with different data visualizations

## Sixth unit: Create a new Azure Sentinel workbook

**Type of unit:** Learning content unit

**Estimated unit duration:** 10 minutes

### Key content per learning objective

After you complete this unit, you&#39;ll be to create an Azure Sentinel workbook. Unit topics include:

- Work with different steps<!-- Steps are a task with an order that must be followed. I'm not sure how you "work with steps." Can you revisit this? --> in a workbook
- Add texts, queries, and graphs to a workbook

## Seventh unit: Exercise, Visualize data using Azure Sentinel workbooks (tjm)

**Type of unit:** Exercise unit

**Estimated unit duration:** 10 minutes

**Use of supplemental demo video:** Potentially

### Key content per learning objective

- Draft lab exercise title: Create a workbook from a template
  - Task 1. Create a workbook from a template
  - Task 2. Edit a workbook to modify the results
  
In this exercise, you will learn to:

- Create a new Azure Sentinel workbook.
- Visualize data by adding text, queries, and a graph into your workbook.

Review the steps for this exercise: Create an Azure Sentinel workbook using the Azure portal.

To repeat these steps, sign up for a free trial Azure subscription.

After completing the steps, delete any resource groups you created.

## 7Eigth unit: Summary

**Type of unit:** Summary unit

**Estimated unit duration:** 2 minutes

### Resolution of module problem

Contoso SecOps can now use Azure Sentinel Workbooks to provide interactive reports with graphs, charts, and tables, and to visualize their security data using advanced filtering. They can use these techniques to gain more insights into their data during their investigations.

In this module, you learned about different workbook elements, and how to tune and visualize your data. You also learned how to define parameters using a new step, and then use those parameters to further filter your queries. <!-- We didn't have one of these sentences in Module 6. Can we make them consistent and either delete this "In this module, you've learned" pgph, or add one to Mod 6? -->
