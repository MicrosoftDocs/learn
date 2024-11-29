In today's data-driven world, the ability to efficiently access and manipulate data is crucial for businesses and developers alike. [Data API Builder (DAB)](/azure/data-api-builder/overview?azure-portal=true) offers a powerful solution for creating modern REST and GraphQL endpoints for your Azure SQL Database, replacing custom APIs that perform CRUD (Create, Read, Update, Delete) operations against a database.

Azure Data API Builder is an open-source tool, designed for developers, to simplify the process of exposing your database objects as endpoints. It supports many databases, including but not limited to Azure SQL, SQL Server, PostgreSQL, and Azure Cosmos DB. With DAB, you can create secure, scalable, and high-performance APIs at no extra cost, without writing any code.

:::image type="content" source="../media/2-architecture.png" alt-text="Diagram showing the relationship between all of the components of the Data API builder." lightbox="../media/2-architecture.png":::

## Discover key features

Using DAB in your development process offers many benefits. Here are some key advantages that can help you determine how well it aligns with your project requirements.

- **Cross-platform compatibility**: DAB is cross-platform and can run on any cloud or on-premises environment. It supports multiple backend data sources, including relational and NoSQL databases.
- **Security and authentication**: DAB integrates with various authentication methods, including OAuth2, EasyAuth, and Microsoft Entra ID. It also supports role-based authorization and granular security controls. This means you can expose your data while maintaining control over who can access it and what they can do with it.
- **Ease of use**: With a single configuration file, you can define your API endpoints, making the setup process straightforward and efficient.
- **Integration with Azure services**: DAB seamlessly integrates with Azure Static Web Apps, Azure Container Apps, and other Azure services, enhancing its functionality and scalability.

To see a list of feature available for Data API builder, see [Feature availability for Data API builder](/azure/data-api-builder/feature-availability?azure-portal=true).

## Use Data API Builder

To get started with Azure Data API Builder, ensure you have an Azure subscription and the necessary tools installed, such as the [latest .NET 8](/dotnet/framework/install/) and [Azure Developer CLI](/azure/developer/azure-developer-cli/overview?azure-portal=true).

1. **Create a new project:** Use the Azure Developer CLI to create and deploy the required services. For example, use the Azure Developer CLI to deploy an Azure Static Web App that hosts the Data API Builder. Navigate to the directory where you want to create your project and run the following command to create a new Azure Static Web App project.

    ```
    azd init --template staticwebapp
    azd up
    ```

1. **Configure the database connection:** Link your Azure SQL Database to the deployed static web app using the database connections feature.  Navigate to the Azure Static Web App you created, and under **Settings**, link an existing database under the **Database connection** page.

1. **Define API Endpoints**: Create a configuration file to define your REST or GraphQL endpoints. This file specifies the database objects to expose and the operations allowed. For example, you can run the following command to add the database entities to the configuration file.

    ```dos
    dab add "Address" --source "dbo.Address" --permissions "anonymous:*" --config "swa-db-connections/staticwebapp.database.config.json"
    ```

### Review a configuration file

Here’s a simple example of a configuration file for exposing a table in your Azure SQL Database.

```json
{
  "data-source": {
    "database-type": "mssql",
    "connection-string": "Server=tcp:your_server.database.windows.net,1433;Initial Catalog=your_database;Persist Security Info=False;User ID=your_user;Password=your_password;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  },
  "entities": {
    "products": {
      "source": "Address",
      "rest": true,
      "graphql": true,
      "permissions": [
        {
          "role": "anonymous",
          "actions": ["read"]
        }
      ]
    }
  }
}
```

This configuration exposes the **Address** table as both REST and GraphQL endpoints, allowing read access to anonymous users.

