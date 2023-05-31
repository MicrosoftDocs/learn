---
ms.custom:
  - build-2023
---
Microsoft Purview is a unified data governance solution that allows you to manage and govern your infrastructure anywhere. 

In SQL Server 2022, you no longer have to grant access to user individually to your SQL Server instance. Instead, you can use Microsoft Purview to manage data access policies at scale. This allows you to simplify access management and ensure consistent policies across your organization.

Access policies include two different types:

* **Data:** A data access policy allows an Azure AD account to log into SQL Server and have access to read data from user tables in any database for the instance. This feature is currently in public preview.

* **DevOps:** A DevOps access policy allows an Azure AD account to log into SQL Server and perform specific tasks, such as Performance Monitoring or Security Auditing.

You can delete the access policy from Microsoft Purview to remove the authentication and authorization of the Azure AD account at any time. You can also apply an access policy across multiple SQL Server 2022 instances, thereby providing a central governance method.

To learn more about Microsoft Purview access policies for SQL Server 2022, see [Provision access by data owner for SQL Server on Azure Arc-enabled servers](https://aka.ms/purviewsqlaccesspolicies).
