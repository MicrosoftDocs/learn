Azure Cosmos DB for PostgreSQL has the ability to grow with the applications that use it. As data increases, resources - including worker nodes, compute, and storage - can be adjusted. As the database administrator for Woodgrove Bank's contactless payment app's database, you have many tasks to address growing demands for the system. As the demand for analytics increases, read replicas can be made of the cluster. When the application needs to be highly available, the cluster can be enabled with high availability.

## Scenario: Scaling Woodgrove Bank's contactless payment app

:::image type="content" source="../media/woodgrove-bank-logo.png" alt-text="Screenshot of Woodgrove Bank's logo - an icon of a factory with the words 'Woodgrove Bank' to the right of it.":::

In this scenario, you're a database administrator for Woodgrove Bank. They have a contactless payment app that stores its data in an Azure Cosmos DB for PostgreSQL database. Woodgrove Bank decided to expand the app to customers across Europe and the United States after going through a successful trial of the app. As the Woodgrove Bank payment app grows in usage and demand, the cluster needs to grow to handle the load both in resources and in availability.

In this module, you address the issue of a growing user base by adding resources and rebalancing the data. With Woodgrove Bank's expansion to a European audience, they also added a corporate office there. Since the European corporate office has analysts who want to report on the data, you create a read replica in their region. This replica gets them quick performance for their queries without impacting the users of the application. As the users are using the application at all hours of the day and need access to their transactions all the time, you enable high availability for the cluster.

In this module, you learn how to manage Azure Cosmos DB for PostgreSQL for growth.
