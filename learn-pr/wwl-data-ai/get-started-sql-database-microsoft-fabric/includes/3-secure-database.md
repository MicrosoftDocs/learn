---
ms.custom:
  - ignite-2024
---
In a database, users have access to several capabilities aimed at safeguarding sensitive information. These security measures are capable of securing or masking data from users or roles without proper authorization, ensuring data protection across both the database and the SQL analytics endpoints. This ensures a smooth and secure user experience, with no need for changes to the existing applications.

## Understand security capabilities

Users who are often well-versed in the SQL engine and adept at using T-SQL, find databases in Microsoft Fabric easy to use.

This is because SQL Database in Microsoft Fabric is powered by the same SQL engine they're familiar with, enabling them to perform complex queries and data manipulations. The SQL engine’s wide range of security features further allows for sophisticated security mechanism at the database level.

### [**Workspaces roles**](/fabric/data-warehouse/workspace-roles/?azure-portal=true) 

Designed to provide different levels of access and control within the workspace. You can assign users to the various workspace roles such as **Admin**, **Member**, **Contributor**, and **Viewer**. These roles are crucial for maintaining the security and efficiency of SQL database operations within an organization.

### [**Item permissions**](/fabric/database/sql/share-sql-manage-permission?azure-portal=true) 

Individual databases can have item permissions assigned directly to them. The main intent behind assigning such permissions is to facilitate the sharing of the SQL database for downstream use. You can review permissions for a SQL database, its SQL analytics endpoint, or its default semantic model by navigating to the item in the workspace and selecting the **Manage permissions** quick action.

> [!NOTE]
> Granting item permissions has no impact on the security metadata inside the database.

### [**Data protection**](/fabric/database/sql/configure-sql-access-controls?azure-portal=true)  

You can use T-SQL to grant specific permissions to users for more precise control. SQL database supports a range of data protection features that enable administrators to shield sensitive data from unauthorized access. 

It includes object-level security for database objects, column-level security for table columns, row-level security for table rows using `WHERE` clause filters, and dynamic data masking to obscure sensitive data like email addresses.

You can manage database-level roles from Fabric portal by selecting **Security** and then choosing **Manage SQL security**.

:::image type="content" source="../media/3-manage-sql-security.png" alt-text="Screenshot from the Fabric portal of the button to open the SQL security options." lightbox="../media/3-manage-sql-security.png":::
