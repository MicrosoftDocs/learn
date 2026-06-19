In this module, you learned how to analyze data relationships and choose the right modeling strategy for each relationship in your Azure DocumentDB application.

Your e-commerce team started with flat document structures and needed to model the relationships between customers, products, orders, reviews, and categories. You began by identifying entity relationships and analyzing their cardinality, access patterns, read/write ratios, and ownership. You then applied the embed-vs-reference decision framework to make consistent choices: embed for one-to-one and one-to-few relationships, reference for unbounded one-to-many, and use hybrid patterns (extended reference, subset) when the decision isn't clear-cut. For one-to-one relationships like product specifications, you embedded directly. For one-to-many relationships, you chose between full embedding (customer addresses), referencing (customer orders), and the subset pattern (product reviews) based on child count and access patterns. For many-to-many relationships like products and categories, you used two-way references with denormalized display data and managed consistency with transactions.

You can now analyze data relationships and design document schemas that balance query performance with data consistency for your Azure DocumentDB applications.

## Learn more

- [What is Azure DocumentDB?](/azure/documentdb/overview)
- [MongoDB feature compatibility in Azure DocumentDB](/azure/documentdb/compatibility-features)
- [Compute and storage configurations for Azure DocumentDB](/azure/documentdb/compute-storage)
