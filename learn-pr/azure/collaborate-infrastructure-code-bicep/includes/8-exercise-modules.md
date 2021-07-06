TODO

## Identify clusters of resources

Do you see any resources that belong together and where it would make sense to put them into separate modules?

The template could be divided into two main parts:

- a _web frontend_ with Azure Web App and related components hosting your application
- a _database backend_ with Azure SQL components, where you store your relational data

:::image type="content" source="../media/3-visualize-parts.png" alt-text="A diagram showing two clusters of resources in Bicep Visualizer.":::

## TODO
Move SQL and App Service into their own modules
Make SQL module optionally deploy the firewall rule
Adjust config map to use different firewall rules for test and prod
