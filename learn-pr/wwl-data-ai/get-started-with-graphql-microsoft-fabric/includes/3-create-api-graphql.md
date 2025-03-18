---
ms.custom:
  - ignite-2024
---
To create a fully functional API to access your data in Fabric, start from the Fabric portal home page and select **Data Engineering** from the list of workloads. Then, choose **API for GraphQL**. 

Alternatively, you can select **New > API for GraphQL** from any workspace in **Data Engineering**. Enter a name and select **Create** to have a fully functional API to access your data in Fabric.

:::image type="content" source="../media/3-api-page.png" alt-text="Screenshot of the API for GraphQL page in Microsoft Fabric." lightbox="../media/3-api-page.png":::

Next, connect to a data source by selecting **Select data source**. In the **Choose connectivity option** dialog, choose between single sign-on (SSO) or saved credentials. Then, select the data you want to connect.

:::image type="content" source="../media/3-data-source.png" alt-text="Screenshot of the data source selection page for GraphQL in Microsoft Fabric." lightbox="../media/3-data-source.png":::

The data source page shows all the items in your workspace available to connect. Then, you need to select which objects you want expose to the API, then select **Load**.

## Enable or disable operations

Once you load the data, the GraphQL engine automatically creates queries and mutations for each object you expose.

You can enable or disable specific queries and mutations within the GraphQL schema, providing fine-grained control over API access and usage. This means you can manage API functionalities without changing code or redeploying.

This option is useful for temporarily disabling functionalities for maintenance, security, or performance reasons, or for controlling API operations based on user roles or other criteria.

:::image type="content" source="../media/3-disable-query.png" alt-text="Screenshot of the property to disable a query for GraphQL in Microsoft Fabric." lightbox="../media/3-disable-query.png":::

In this example, the `ProductModel` table from `AdventureWorksLT` is the only table exposed. The engine automatically generates the queries and mutations needed for insert, update, and delete operations.

> [!NOTE]
> When a query or mutation is disabled, any attempts to execute it will result in an error.

## Manage relationships

GraphQL offers support for one-to-one (1:1), one-to-many (1:N), and many-to-many (M:N) relationships.

- **One-to-one (1:1):** Each instance of a type is associated with a single instance of another type. For example, a *User* type might have a one-to-one relationship with a *Profile* type, where each user has exactly one profile.

- **One-to-many (1:N):** A single instance of one type is associated with multiple instances of another type. For example, a *User* type might have a one-to-many relationship with a *Post* type, where each user can have multiple posts.

- **Many-to-many (M:N):** Multiple instances of one type are associated with multiple instances of another type. For example, a *Student* type might have a many-to-many relationship with a *Course* type, where each student can enroll in multiple courses, and each course can have multiple students.

These relationships enable developers to create rich, interconnected data models that can be queried efficiently.

:::image type="content" source="../media/3-relationship.png" alt-text="Screenshot of the new relationship dialog for GraphQL in Microsoft Fabric." lightbox="../media/3-relationship.png":::
