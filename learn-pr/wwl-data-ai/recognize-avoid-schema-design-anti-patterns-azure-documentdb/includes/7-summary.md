In this module, you learned to recognize five common schema design anti-patterns and apply targeted fixes to resolve them in Azure DocumentDB.

In our example, your e-commerce team's database had several problems hiding in plain sight. Unbounded review arrays on popular products were growing toward the 16-MB document limit. You applied the subset pattern to keep a bounded set of recent reviews and moved the full history to a separate collection. Hundreds of tenant-specific collections created unnecessary management overhead, and you consolidated them into a single collection with a discriminator field and compound index. Overlapping indexes slowed writes without adding query value, so you consolidated them using the ESR (Equality, Sort, then Range) rule and dropped unused indexes. Over-normalized data forced the application to make multiple round trips for a single page load, and you embedded the related data into the parent document. Inconsistent email and username casing caused duplicate accounts and sign in failures, so you normalized lookup fields to lowercase on write and added unique indexes.

You can now audit your Azure DocumentDB schema for these anti-patterns, prioritize fixes based on their performance impact, and apply the right solution for each problem.

## Learn more

- [What is Azure DocumentDB?](/azure/documentdb/overview)
- [Indexing best practices in Azure DocumentDB](/azure/documentdb/how-to-create-indexes)
- [MongoDB feature compatibility in Azure DocumentDB](/azure/documentdb/compatibility-features)
