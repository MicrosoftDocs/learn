In this module, you built the read path for the Contoso product catalog API. You wrote queries that return data in the required structure and access nested data. You also used pagination for long result sets. Pagination avoids the cost of retrieving results that users don't view.

## What you learned

- A query reads JSON through a `FROM` alias, a `WHERE` filter, and a `SELECT` projection; missing properties drop out silently and types don't coerce. Property names and string equality comparisons are case-sensitive, but keywords aren't.
- Parameterized queries separate values from query text, closing the injection path that string concatenation opens; parameters replace values, not identifiers.
- Projection and built-in functions shape results server side, and returning fewer properties can lower request unit (RU) charges. `UPPER` and `LOWER` predicates can't use the index, but other filters in the same query still can. `CONTAINS` uses the index but scans the distinct indexed values for the path.
- Correlated subqueries reach inside an array without changing the result shape: `EXISTS` filters items by what their array holds and returns each item once, and the `ARRAY` expression projects a shaped version of that array alongside it.
- `JOIN` produces a cross-product within a single item, never across items or containers, returning one row per array element and no row at all for an item whose array is empty.
- Results arrive in pages that `MaxItemCount` caps but doesn't guarantee, and continuation tokens resume a query without the growing cost of deep `OFFSET` paging.

## Learn more

- [Query language reference for Azure Cosmos DB for NoSQL](/cosmos-db/query/)
- [Subqueries in Azure Cosmos DB for NoSQL](/cosmos-db/query/subquery)
- [Self-joins in Azure Cosmos DB for NoSQL](/cosmos-db/query/join)
- [Pagination in Azure Cosmos DB for NoSQL](/cosmos-db/query/pagination)
- [Parameterized queries in Azure Cosmos DB for NoSQL](/cosmos-db/query/parameterized-queries)
- [Query items in Azure Cosmos DB for NoSQL using .NET](/azure/cosmos-db/how-to-dotnet-query-items)
- [Get started with Azure Cosmos DB for NoSQL using Python](/azure/cosmos-db/how-to-python-get-started)

## Clean up resources

If you created an Azure Cosmos DB account for the exercise and no longer need it, delete its resource group in the Azure portal to stop incurring charges.
