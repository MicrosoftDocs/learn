
Modern applications rarely interact with databases through direct SQL connections. Instead, they consume data through REST and GraphQL APIs that provide flexibility, security, and standardization. Building these API layers traditionally requires significant backend development effort—writing controllers, mapping data models, handling authentication, and managing deployment infrastructure.

Data API Builder solves this challenge by automatically generating REST and GraphQL endpoints from your database schema. With a single configuration file, you can expose tables, views, and stored procedures through secure, scalable APIs without writing backend code.

In this module, you learn how to:

- Create and configure Data API Builder configuration files for SQL databases
- Define entities with field mappings, caching, pagination, and filtering
- Configure REST and GraphQL endpoints for different client needs
- Expose views, stored procedures, and define GraphQL relationships
- Explore deployment options for Data API Builder, including Azure Container Apps, App Service, and Static Web Apps
- Set up Azure Monitor with Application Insights for API observability
- Handle database changes using Change Data Capture, Azure Functions, and Change Event Streaming

## Prerequisites

- Experience with SQL Server, Azure SQL Database, or SQL databases in Microsoft Fabric
- Familiarity with T-SQL for creating tables, views, and stored procedures
- Basic understanding of REST APIs and JSON
- Access to an Azure subscription for deployment exercises
- Docker Desktop installed for local development (optional)
