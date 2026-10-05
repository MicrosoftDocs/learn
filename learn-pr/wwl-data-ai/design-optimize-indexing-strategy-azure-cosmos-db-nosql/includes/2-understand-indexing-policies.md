An indexing policy is a JSON document attached to a container. It decides which property paths get indexed, what kind of index each path gets, and whether indexing happens at all. Everything you tune later in this module is a change to that document, so it helps to understand what the service does with it before you start editing it.

The Contoso catalog is a good example of why the default doesn't always fit. Its `product` items carry a long `description` string and a `tags` array that no query filters on, and both are indexed because the default policy indexes everything.

## How the index is built

When you write an item, Azure Cosmos DB projects it as a JSON document and converts that document into a tree. Every property becomes a node, and every scalar value sits at a leaf. The service then walks the tree from the root to each leaf and concatenates the labels along the way to produce a path, so `categoryName` in a product item becomes the path `/categoryName`, and a property nested inside an array element carries the array position in its path.

The index itself is an inverted index. For each path, it stores the values that appear at that path and the items each value belongs to. Two properties of that structure explain most of what follows. Values for a given path are stored in ascending order, so the engine can serve an `ORDER BY` straight from the index. And because the engine can scan the distinct set of values for a path, it can find the pages that hold matching items without reading the items themselves.

Three index types cover the query shapes in this module. A **range** index handles equality filters, range comparisons, `IS_DEFINED`, string system functions, `ORDER BY` on a single property, and `JOIN`. A **spatial** index handles geospatial functions such as `ST_DISTANCE` and `ST_WITHIN`. A **composite** index handles ordering and filtering across several properties at once. Vector and full-text indexes exist as well, and they support search scenarios rather than the catalog queries here.

## The default indexing policy

A newly created container indexes every property of every item and applies a range index to every string and number. Two details of the default matter more than they look:

- The system properties `id` and `_ts` are always indexed when the indexing mode is `consistent`, and you can't disable indexing for those properties. They don't appear in the policy's path lists, which is why you never see them there.
- The system property `_etag` is excluded by default.

The **indexing mode** controls whether indexing happens at all. `Consistent` updates the index synchronously as items are created, replaced, or deleted, so query results reflect the account's configured consistency level. `None` turns off indexing, which suits a container used purely as a key-value store, and can speed up a bulk load if you set the mode back to `consistent` afterward. Time to live (TTL) depends on indexing, so you can't turn on TTL for a container whose mode is `none`, and you can't set the mode to `none` on a container that has TTL active.

> [!IMPORTANT]
> The partition key path isn't indexed automatically unless it's also `/id`. Leaving it out of the policy forces a full scan on any query that filters on the partition key, which is the opposite of what partitioning is for. Include it explicitly, and for a hierarchical partition key, include each level.

## Included and excluded paths

A custom policy lists property paths to include or exclude, using three notations:

| Notation | Meaning |
| :--- | :--- |
| `/?` | The scalar value at this path, for example `/description/?` |
| `/[]` | Every element of an array, for example `/tags/[]/name/?` |
| `/*` | Everything below this node |

Every policy has to place the root path `/*` in either the included list or the excluded list, and that choice defines the strategy. Including the root and then excluding specific paths is the recommended approach, because Azure Cosmos DB keeps indexing any new property that appears in your model later. Excluding the root and including specific paths gives you the smallest index, at the cost of remembering to add each new queried property by hand.

When an included path and an excluded path overlap, the more precise path wins. A deeper path is more precise than a shallower one, and `/?` is more precise than `/*`. So a policy that excludes `/tags/*` while including `/tags/[]/name/?` indexes the tag names and nothing else under `tags`.

> [!NOTE]
> Every explicitly included path gets a value written into the index for every item, even when the path is undefined in that item. That behavior is what makes `IS_DEFINED` queryable from the index.

## How queries use the index

Not every indexed query costs the same. The engine has five ways to evaluate a filter, and the difference between the cheapest and the most expensive is large enough to change how you write a query:

| Lookup | Typical filter | Cost behavior |
| :--- | :--- | :--- |
| Index seek | Equality, `IN` | Constant per equality filter |
| Precise index scan | `>`, `<`, `>=`, `<=`, `STARTSWITH` | Close to a seek, rises slightly with the number of distinct values |
| Expanded index scan | Case-insensitive `STARTSWITH` and `STRINGEQUALS` | Higher than a precise scan, still avoids most index pages |
| Full index scan | `CONTAINS`, `ENDSWITH`, `RegexMatch`, `LIKE` | Rises linearly with the number of distinct values at the path |
| Full scan | `UPPER`, `LOWER` | Reads every item, so the charge rises with container size |

:::image type="content" source="../media/index-lookup-ladder.png" alt-text="Diagram of a ladder of the five index lookup types, from index seek down to full scan, with cost increasing at each step." lightbox="../media/index-lookup-ladder.png":::

A query's total charge combines the index lookup with the cost of loading the matching items. For a query with a single filter, matching fewer items reduces document loading but doesn't necessarily reduce index lookup work. Another selective indexed filter can reduce that work: the engine can apply an equality filter first, then evaluate `CONTAINS` on the index pages for those matches. The practical rule is to prefer the filter that sits higher in this table. If `STARTSWITH` answers the question, don't reach for `CONTAINS`.

Aggregates behave differently and deserve their own warning. `COUNT`, `SUM`, `AVG`, `MIN`, and `MAX` can use indexes, but some filters require the engine to load items to compute the aggregate. An aggregate query with only a `CONTAINS` filter can require a full scan. Adding a selective equality or range filter can let the engine use the index first and reduce the number of items it loads.

Learn more about [how Azure Cosmos DB indexes data](/azure/cosmos-db/index-overview) and [indexing policies](/azure/cosmos-db/index-policy).
