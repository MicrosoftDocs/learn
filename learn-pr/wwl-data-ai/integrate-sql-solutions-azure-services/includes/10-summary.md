In this module, you learned how to:

- Create Data API Builder configuration files with data source connections and runtime settings
- Define entities for tables with field mappings, caching, pagination, and filtering capabilities
- Configure REST and GraphQL endpoints with customized paths and enabled operations
- Expose views as read-only entities and stored procedures for custom operations
- Explore deployment options for Data API Builder, including Azure Container Apps, App Service, and Static Web Apps
- Set up Azure Monitor with Application Insights for request telemetry and database performance tracking
- Implement change capture patterns using CDC, Change Tracking, Azure Functions triggers, and Change Event Streaming

## Key takeaways

- Data API Builder eliminates custom API code by generating REST and GraphQL endpoints from a single JSON configuration file
- Entity relationships enable GraphQL clients to traverse connections between tables in single queries, reducing round trips
- Azure Container Apps provides serverless hosting with automatic scaling and managed identity support for production deployments
- Application Insights integration gives visibility into request performance, database queries, and error rates
- Change capture mechanisms enable event-driven architectures that respond to database modifications in real time

## Learn more

- [Data API Builder documentation](/azure/data-api-builder/?azure-portal=true)
- [Data API Builder configuration reference](/azure/data-api-builder/reference-configuration?azure-portal=true)
- [Deploy Data API Builder to Azure Container Apps](/azure/data-api-builder/deployment/how-to-host-container-apps?azure-portal=true)
- [Azure Functions SQL trigger binding](/azure/azure-functions/functions-bindings-azure-sql-trigger?azure-portal=true)
- [Change Data Capture in SQL Server](/sql/relational-databases/track-changes/about-change-data-capture-sql-server?azure-portal=true)
- [Application Insights overview](/azure/azure-monitor/app/app-insights-overview?azure-portal=true)
