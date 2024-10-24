
The API for GraphQL in Microsoft Fabric supports two types of operations: queries (read) and mutations (write). 

- **Queries:** Allow you to retrieve data from your data sources, making them ideal for read-only operations. This is relevant for data sources exposed via SQL Analytics Endpoints, which are inherently read-only in nature.

- **Mutations:** Enable you to modify data, making them suitable for write operations. 

> [!NOTE]
> When you work with warehouses and SQL Databases, you must define a primary key for mutations to be automatically generated. This step ensures that the data is accurately identified and modified.

## GraphQL schema

A GraphQL schema is essential for defining the types of data that can be queried or mutated and how they're related. It provides a clear and concise way to describe an API's capabilities.

- **Objects:** Objects represent data types in a GraphQL schema. They help organize related data and define the fields that can be queried on each type.
- **Fields:** Fields specify the data that can be queried on an object type. They can be scalar values or other object types and might include arguments to filter or modify the data.

## Secure API access

To use the API for GraphQL, your applications must authenticate through Microsoft Entra. This means your client application needs to be registered and properly configured to make API calls against Fabric. 

Additionally, the authenticated user in the app calling the GraphQL API must be a workspace member with a **contributor** role in the workspace where both the API and data source items are located. 

> [!NOTE]
> Service Principals are not supported at this time.

To learn more, see [Create a Microsoft Entra ID app](/rest/api/fabric/articles/get-started/create-entra-app?azure-portal=true).
