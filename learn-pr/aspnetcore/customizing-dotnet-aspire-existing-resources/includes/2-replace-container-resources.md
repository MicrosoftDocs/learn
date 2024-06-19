Azure includes many Platform-as-a-Service (PaaS) solutions that you can use without taking charge of the underlying infrastructure. When you deploy a .NET Aspire solution to Azure, you can choose to use these services instead of running your backing services as containers within Azure Container Apps or Azure Kubernetes Service. This approach can reduce your administrative load.

In your outdoor equipment retailer, your deployed eShop is running well and responding quickly to user requests. However, at times of high demand, administrators must manually increase the number of containers that run databases and the output cache. You want to investigate whether Azure database and cache services can avoid this administration.

In this unit, you'll learn how to use Azure SQL Database, Azure Database for PostgreSQL and Azure Cache for Redis to host backing services for a deployed .NET Aspire solution.

## Why use Azure services to host backing services?

When you develop a .NET Aspire solution, you often use Docker to host containers on your local computer for debugging. When you deploy the solution to Azure, you need a service to host those containers in the cloud. Azure has two services you can choose from:

- **Azure Container Apps (ACA)**: Use this service when you want a deployment that is simple to configure and highly scalable.
- **Azure Kubernetes Service (AKS)** Use this service when you want a deployment that is highly customizable and scalable.

You can deploy to these services easily by using Visual Studio or the Azure Developer CLI. In the default configuration for such a deployment, all the backing services are provisioned as containers within ACA or AKS.

This default configuration may suit your needs. It keeps all the resources in a single location and administrators with good ACA or AKS skills are familiar with the environment. However, it also requires you to manage containers for those backing services.

If you want to reduce your administrative load for those backing services, you can deploy some of those services to an Azure Platform-as-a-Service (PaaF) solution. For example, instead of running a PostgreSQL database in a container in AKS, you can choose to deploy that database to the Azure Database for PostgreSQL service.

## Using Azure PaaS database services with a .NET Aspire solution

In cloud-native solutions, many microservices need to persist data and use relational database systems to do it. .NET Aspire makes database operations simple by providing .NET Aspire components for SQL Server, PostgreSQL, and other popular systems. For deployment, you can choose to use these services instead of hosting your database in a container:

- **Azure SQL Database**: This PaaS service hosts SQL Server databases in this cloud.
- **Azure Database for PostgreSQL**: This PaaS services hosts PostgreSQL databases in the cloud.

# [Azure SQL Database](#tab/sql)

To configure your .NET Aspire solution to deploy a database in Azure SQL Database, open the _Program.cs_ file in your app host project. The code that adds the database backing service looks similar to this line:

```csharp
var sqlServer = builder.AddSqlServer("sqlserver")
                       .AddDatabase("sqldb");
```

If you want to deploy the database to Azure SQL Database, modify that code to resemble this line:

```csharp
var sqlServer = builder.AddSqlServer("sqlserver")
                       .PublishAsAzureSqlDatabase()
                       .AddDatabase("sqldb");
```

Now, when you debug the solution locally, .NET runs the database as a container within Docker. However, when you deploy the solution using Visual Studio or Azure Developer CLI, the tools create new SQL server and SQL database resources in Azure SQL Database. The tools also automatically configure the deployed microservices to connect to those new resources.

# [Azure Database for PostgreSQL](#tab/postgresql)

To configure your .NET Aspire solution to deploy a database in Azure Database for PostgreSQL, open the _Program.cs_ file in your app host project. The code that adds the database backing service looks similar to this line:

```csharp
var postgres = builder.AddPostgres("postgres");
                      .AddDatabase("postgresdb");
```

If you want to deploy the database to Azure Database for PostgreSQL, modify that code to resemble this line:

```csharp
var sqlServer = builder.AddSqlServer("sqlserver")
                       .PublishAsAzurePostgresFlexibleServer()
                       .AddDatabase("postgresdb");
```

Now, when you debug the solution locally, .NET runs the database as a container within Docker or Podman. However, when you deploy the solution using Visual Studio or Azure Developer CLI, the tools create new PostgreSQL server and database resources in Azure Database for PostgreSQL. The tools also automatically configure the deployed microservices to connect to those new resources.

---

## Using Azure Redis with a .NET Aspire app

In cloud-native solutions, it's popular to use Redis either to provide a high-performance database service or to cache content to accelerate responses to users. .NET Aspire includes three Redis components:

- **.NET Aspire Stack Exchange Redis component**: Use this component to create and call Redis databases in your solution.
- **.NET Aspire Stack Exchange Redis output caching component**: Use this component to use Redis to cache entire web responses.
- **.NET Aspire Stack Exchange Redis distributed caching component**: Use this component to use Redis to cache data across multiple instances of containers and multiple microservices.

During development, .NET Aspire creates containers in your local container host (Docker or Podman) for the Redis service. During deployment, the default configuration is similar: the tools create a container in ACA or AKS to host the Redis service.

However, you may prefer to use the PaaS Azure Cache for Redis service after your deployment. This approach frees you from managing a Redis container. Instead, an extra Azure Cache for Redis resource hosts the service.

To configure your .NET Aspire solution to deploy a cache in Azure Cache for Redis, open the _Program.cs_ file in your app host project. The code that adds the Redis backing service looks similar to this line:

```csharp
var cache = builder.AddRedis("cache");
```

If you want to deploy the cache to Azure Cache for Redis, modify that code to resemble this line:

```csharp
var cache = builder.AddRedis("cache")
                   .PublishAsAzureRedis();
```

Now, when you debug the solution locally, .NET runs Redis as a container within Docker or Podman. However, when you deploy the solution using Visual Studio or Azure Developer CLI, the tools createa new Azure Cache for Redis resource. The tools also automatically configure the deployed microservices to connect to the new resource.

## Learn more

- [Tutorial: Deploy a .NET Aspire app with a SQL Server Database to Azure](/dotnet/aspire/database/sql-server-component-deployment)
- [Tutorial: Deploy a .NET Aspire app with a Redis Cache to Azure](/dotnet/aspire/caching/caching-components-deployment)
