Full-text search lets you run linguistic searches against text data in SQL Server and Azure SQL Database. Unlike the `LIKE` operator, which only matches character patterns, full-text search understands words, phrases, and language rules.

When a customer searches your product catalog for "ride," they expect to find results that say "riding," "rides," or "rode." Full-text search handles these scenarios by working with language-aware indexes that understand word forms. It doesn't automatically match synonyms or abbreviations (like "MTB" for "mountain bike") unless you configure a thesaurus, but it handles inflections out of the box.

## When to use full-text search

Full-text search works best when your users search using specific words or phrases. Consider these scenarios where full-text search is the right choice:

- A customer types a product name or part number
- A support agent searches for tickets containing specific error messages
- A user looks for documents with exact technical terms

If users instead describe what they need without using specific terms, vector search might be more appropriate. But when users know the words they want, full-text search delivers fast, precise results.

## Understand full-text indexes and predicates

Full-text search requires two things: a full-text index on your text columns, and predicates to query that index.

A full-text index stores information about words and their locations within your text columns. SQL Server breaks down the text into individual tokens, removes common words like "the" and "is" (called stopwords), and builds an inverted index that maps words to the rows containing them. This structure allows fast lookups without scanning every row.

To query a full-text index, you use predicates in your `WHERE` clause. SQL Server provides two main predicates:

- **CONTAINS** searches for exact matches of words and phrases. Use it when you need precise control over what matches.
- **FREETEXT** searches for meaning rather than exact words. It automatically looks for inflectional forms of your search terms.

SQL Server also provides table-valued functions **CONTAINSTABLE** and **FREETEXTTABLE** that return ranked results with relevance scores, which is useful when you want to sort results by how well they match.

## Query a full-text index

The following example shows how to search a product catalog using both `CONTAINS` and `FREETEXT`. Assume the `Production.Product` table has a full-text index on the `Name` column.

Use `CONTAINS` when you need exact word matching:

```sql
SELECT ProductID, Name, ListPrice
FROM Production.Product
WHERE CONTAINS(Name, 'mountain')
  AND ListPrice < 500;
```

This query returns products with "mountain" in the name under $500. The `CONTAINS` predicate checks the full-text index while the `ListPrice` filter uses the regular column.

Use `FREETEXT` when you want SQL Server to find related word forms automatically:

```sql
SELECT ProductID, Name
FROM Production.Product
WHERE FREETEXT(Name, 'riding bikes');
```

This query finds products related to "riding bikes," including matches for "ride," "rides," and "biking." `FREETEXT` handles inflections automatically without requiring you to specify them.

When you need ranked results, use `CONTAINSTABLE` to get full-text relevance scores. Full-text search assigns a rank to each result based on how well it matches the query. This rank is useful for sorting results by relevance:

```sql
SELECT p.ProductID, p.Name, ft.RANK
FROM Production.Product AS p
INNER JOIN CONTAINSTABLE(Production.Product, Name, 
    'NEAR((mountain, bike))') AS ft
  ON p.ProductID = ft.[KEY]
ORDER BY ft.RANK DESC;
```

This query finds products where "mountain" and "bike" appear near each other, sorted by full-text relevance. The `RANK` column indicates how well each row matches the search criteria. Later, when you combine full-text search with vector search, you use these full-text ranks alongside vector similarity scores to produce merged results.

## Common query patterns

Full-text search supports several query patterns. Each addresses a different search need.

**Term search** finds rows containing a specific word. A search for `CONTAINS(Description, 'aluminum')` returns all products with "aluminum" in the description.

**Phrase search** finds rows containing words in a specific order. Wrapping the search in quotes like `CONTAINS(Description, '"mountain bike"')` matches only that exact phrase, not rows where "mountain" and "bike" appear separately.

**Prefix search** finds words that start with specific characters. Searching for `CONTAINS(Description, '"light*"')` matches "light," "lights," "lighter," "lightweight," and any other word beginning with "light."

**Inflectional search** finds different forms of a word. Using `CONTAINS(Description, 'FORMSOF(INFLECTIONAL, "ride")')` matches "ride," "rides," "riding," and "rode."

**Proximity search** finds words that appear near each other. Searching for `CONTAINS(Description, 'NEAR((light, aluminum))')` finds products where "light" and "aluminum" appear close together, which often indicates a lightweight aluminum product.

## Evaluate full-text search results

After implementing full-text search, evaluate whether it meets your users' needs. Watch for these signals:

**Precision problems** occur when results include irrelevant items. If searching for "brake" returns results about "brake-resistant" coatings when users want bicycle brakes, your search is too broad. Consider using phrase searches or more specific terms.

**Noise** happens when common words dilute results. Full-text search uses stoplists to filter out words like "the" and "and," but domain-specific noise might require custom stoplists. If searching for "the mountain" returns too many results because "mountain" appears everywhere, you might need to adjust your approach.

**Query intent mismatch** appears when users search for concepts rather than words. If customers search for "something for rainy commutes" and expect to find waterproof gear, full-text search doesn't help because it matches words, not meaning. This signal suggests you might need vector search or hybrid search instead.

## Key takeaways

Full-text search excels when users search with specific words and phrases. It uses full-text indexes to enable fast linguistic searches and provides predicates like `CONTAINS` and `FREETEXT` to query those indexes. Different query patterns (term, phrase, prefix, inflectional, and proximity) address different search needs. When full-text search returns too many irrelevant results, or when users search for concepts instead of specific words, the next search method to consider is vector search.
