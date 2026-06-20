In this module, you learned how to design and implement an indexing strategy that balances read performance with write cost in Azure DocumentDB.

Your e-commerce team's queries were slow because the database performed collection scans on every request. You addressed this issue by learning how B-tree indexes eliminate full-collection scans, using single-field and compound indexes with the ESR (Equality, Sort, Range) rule to optimize field ordering. You explored specialized index types: multi-key indexes for arrays, wildcard indexes for dynamic schemas, partial indexes for conditional indexing, and text and vector indexes for search scenarios. You used the `explain()` command to diagnose query performance by comparing examined entries to returned documents, identifying collection scans and in-memory sorts. Finally, you built a monitoring workflow using `$indexStats` to track usage, identify unused indexes, and maintain an efficient indexing strategy as query patterns evolve.

You can now analyze query patterns, create targeted indexes, and verify their effectiveness for your Azure DocumentDB application.

## Learn more

- [Manage indexing in Azure DocumentDB](/azure/documentdb/indexing)
- [Indexing best practices in Azure DocumentDB](/azure/documentdb/how-to-create-indexes)
- [Create wildcard indexes in Azure DocumentDB](/azure/documentdb/how-to-create-wildcard-indexes)
