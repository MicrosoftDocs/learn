The serverless compute tier for Azure SQL Database is a solution designed to optimize cost and performance by automatically scaling compute resources based on workload demand.

This tier is beneficial for development and testing environments, where workloads can be unpredictable. With serverless, you can configure minimum and maximum vCores, allowing the database to dynamically adjust its resources. Despite its name, the serverless compute tier does require a server to host your database.

:::image type="content" source="../media/4-serverless-pricing.png" alt-text="Screenshot showing how the billing works when the database in paused.":::

As we can see, the auto-pause feature helps reduce costs by pausing the database during periods of inactivity, with the ability to resume automatically upon the next access attempt. This ensures that you only pay for the compute resources you actually use, making it a cost-effective and efficient option for managing your SQL databases.

:::image type="content" source="../media/4-serverless.png" alt-text="Screenshot of the serverless compute tier properties from Azure portal." lightbox="../media/4-serverless.png":::

The auto-pause delay feature allows you to specify the period of inactivity before the database is automatically paused. This delay can be set from as short as 1 hour to as long as seven days. Alternatively, you can disable the auto-pause feature if desired.

> [!NOTE]
> When the database is paused, you are only charged for storage.

To learn more about serverless for Azure SQL Database, see [Serverless compute tier for Azure SQL Database](/azure/azure-sql/database/serverless-tier-overview).
