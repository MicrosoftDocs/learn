Migrating unstructured and semi-structured data to Azure involves more than copying files. You need to assess your current storage estate, choose the right Azure storage service for each workload, set up security and identity controls, and select the tools and strategy that fit your scenario. After the data moves, you still need to validate integrity, execute a cutover with minimal downtime, and optimize your environment.

This module walks you through each phase of that journey. It covers assessment, AI readiness, target service selection, security, migration tools (both Microsoft and ISV), network planning, data validation, cutover execution, and post-migration optimization. The guidance applies to file shares, object stores, and archival data — anything that lives outside a database.

This isn't a step-by-step migration guide. It provides the high-level framework and links to detailed documentation so you can plan and execute a structured migration to Azure storage.

> [!NOTE]
> Plan carefully for cost — access patterns can drive it. Azure Files comes with two billing models. While pay-as-you-go might appear cheaper at first glance, the Provisioned V2 model offers more predictable costs, though your workload might experience throttling if the capacity is sized incorrectly. It can look more expensive, but the predictability is worth considering. Learn more: [Azure Files billing models](/azure/storage/files/understanding-billing).

> [!TIP]
> Watch the [Storage Migrations overview video](https://youtu.be/P6xFQexqHjM) on YouTube.

