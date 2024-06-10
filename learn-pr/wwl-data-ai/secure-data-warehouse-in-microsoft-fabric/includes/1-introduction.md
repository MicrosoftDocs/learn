[Microsoft Fabric Data Warehouse](/fabric/data-warehouse/?azure-portal=true) is a complete platform for data, analytics, and AI (Artificial Intelligence). It refers to the process of storing, organizing, and managing large volumes of structured and semi-structured data. 

In a warehouse, administrators have access to a suite of technologies aimed at safeguarding sensitive information. These security measures are capable of securing or masking data from users or roles without proper authorization, ensuring data protection across both Warehouse and SQL analytics endpoints. This ensures a smooth and secure user experience, with no need for alterations to the existing applications.

## Understand security features

Data engineers who are often well-versed in the SQL engine and adept at using T-SQL, will find warehouses in Microsoft Fabric easy to use.

This is because warehouses are powered by the same SQL engine they're familiar with, enabling them to perform complex queries and data manipulations. The SQL engine’s wide range of security features further allows for sophisticated security mechanism at the warehouse level. 

- [**Workspaces roles**](/fabric/data-warehouse/workspace-roles/?azure-portal=true) – Designed to provide different levels of access and control within the workspace. You can assign users to the various workspace roles such as **Admin**, **Member**, **Contributor**, and **Viewer**. These roles are crucial for maintaining the security and efficiency of data warehousing operations within an organization.

- [**Item permissions**](/fabric/data-warehouse/share-warehouse-manage-permissions/?azure-portal=true) – Individual warehouses can have item permissions assigned directly to them. The main intent behind assigning such permissions is to facilitate the sharing of the Warehouse for downstream use.

- [**Data protection security**](/fabric/data-warehouse/security#granular-security?azure-portal=true) – For more precise control, you can use T-SQL to grant specific permissions to users. Warehouse supports a range of data protection features that enable administrators to shield sensitive data from unauthorized access. This includes object-level security for database objects, column-level security for table columns, row-level security for table rows using `WHERE` clause filters, and dynamic data masking to obscure sensitive data like email addresses. These features ensure data protection across Warehouses and SQL analytics endpoints without necessitating changes to applications.

In the next units, we'll explore various ways of enabling security in a warehouse, and how they can facilitate the tasks of keeping your data warehouse workload protected.