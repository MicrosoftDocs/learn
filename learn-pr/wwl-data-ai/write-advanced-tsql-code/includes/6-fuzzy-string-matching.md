Real-world data rarely matches perfectly. Customer names might be misspelled, addresses abbreviated differently, or product descriptions entered inconsistently. Fuzzy string matching functions help you find records that are similar but not identical, enabling data quality improvements, duplicate detection, and more flexible search capabilities.

## Understand string similarity concepts

Fuzzy matching algorithms measure how similar two strings are by calculating the differences between them. Two primary approaches are commonly used:

**Edit distance (Levenshtein distance)** counts the minimum number of single-character operations (insertions, deletions, substitutions) needed to transform one string into another. Lower values indicate more similar strings.

**Similarity scores** express the relationship between strings as a percentage or ratio, where higher values indicate greater similarity.

Consider these examples:

- "color" → "colour": edit distance = 1 (insert 'u')
- "database" → "databaes": edit distance = 2 (swap 'e' and 's')
- "Microsoft" → "Microsft": edit distance = 1 (delete 'o')

> [!NOTE]
> Fuzzy matching is computationally expensive compared to exact matching. Use it strategically, typically on candidate sets that have been pre-filtered using other criteria.

## Calculate edit distance with `EDIT_DISTANCE`

The `EDIT_DISTANCE` function returns the Levenshtein distance between two strings, which is the minimum number of edits required to transform one string into the other. The goal is to find strings that are similar based on a defined threshold.

The following example demonstrates how to use `EDIT_DISTANCE`:

```sql
SELECT 
    EDIT_DISTANCE('color', 'colour') AS ColorVariant,     -- Returns 1
    EDIT_DISTANCE('database', 'databaes') AS Typo,        -- Returns 2
    EDIT_DISTANCE('SQL Server', 'SQL Server') AS Exact,   -- Returns 0
    EDIT_DISTANCE('hello', 'world') AS Different;         -- Returns 4
```

You can use `EDIT_DISTANCE` to find records that might be duplicates or matches despite slight variations:

```sql
-- Find customers with similar names to a search term
DECLARE @searchName NVARCHAR(100) = 'Jon Smith';

SELECT 
    CustomerID,
    FirstName,
    LastName,
    FirstName + ' ' + LastName AS FullName,
    EDIT_DISTANCE(@searchName, FirstName + ' ' + LastName) AS EditDistance
FROM SalesLT.Customer
WHERE EDIT_DISTANCE(@searchName, FirstName + ' ' + LastName) <= 3
ORDER BY EDIT_DISTANCE(@searchName, FirstName + ' ' + LastName);
```

Also, you can find potential duplicate products:

```sql
-- Find product pairs with similar names
SELECT 
    p1.ProductID AS Product1ID,
    p1.Name AS Product1Name,
    p2.ProductID AS Product2ID,
    p2.Name AS Product2Name,
    EDIT_DISTANCE(p1.Name, p2.Name) AS EditDistance
FROM SalesLT.Product AS p1
INNER JOIN SalesLT.Product AS p2
    ON p1.ProductID < p2.ProductID
WHERE EDIT_DISTANCE(p1.Name, p2.Name) <= 5
ORDER BY EDIT_DISTANCE(p1.Name, p2.Name);
```

> [!TIP]
> The maximum meaningful edit distance depends on string length. For short strings (5-10 characters), an edit distance of 1-2 indicates similarity. For longer strings, you might allow distances of 3-5.

## Measure similarity with `EDIT_DISTANCE_SIMILARITY`

`EDIT_DISTANCE_SIMILARITY` returns a normalized similarity score between 0 and 100, where 100 represents identical strings. This percentage-based metric is easier to interpret than raw edit distance, especially when comparing strings of different lengths:

```sql
SELECT 
    EDIT_DISTANCE_SIMILARITY('color', 'colour') AS ColorSimilarity,     -- ~85
    EDIT_DISTANCE_SIMILARITY('database', 'databaes') AS TypoSimilarity, -- ~75
    EDIT_DISTANCE_SIMILARITY('SQL', 'SQL Server') AS PartialMatch,      -- ~30
    EDIT_DISTANCE_SIMILARITY('hello', 'hello') AS Exact;                -- 100
```

You can use similarity scores to find approximate matches with a threshold like the following example:

```sql
-- Find products similar to a search term (at least 70% similar)
DECLARE @searchTerm NVARCHAR(100) = 'Mountain Bike Frame';

SELECT 
    ProductID,
    Name,
    EDIT_DISTANCE_SIMILARITY(@searchTerm, Name) AS SimilarityScore
FROM SalesLT.Product
WHERE EDIT_DISTANCE_SIMILARITY(@searchTerm, Name) >= 70
ORDER BY EDIT_DISTANCE_SIMILARITY(@searchTerm, Name) DESC;
```

## Calculate phonetic similarity with `JARO_WINKLER_DISTANCE`

The Jaro-Winkler algorithm is specifically designed for comparing names and short strings. It gives higher scores to strings that match from the beginning, making it particularly effective for person names where prefixes are more significant:

```sql
SELECT 
    JARO_WINKLER_DISTANCE('MARTHA', 'MARHTA') AS NameTypo,      -- ~0.96
    JARO_WINKLER_DISTANCE('JONES', 'JOHNSON') AS SimilarNames,  -- ~0.83
    JARO_WINKLER_DISTANCE('JOHN', 'JON') AS NameVariant,        -- ~0.93
    JARO_WINKLER_DISTANCE('SMITH', 'SMYTH') AS SpellingVar;     -- ~0.96
```

The Jaro-Winkler score ranges from 0 to 1, where 1 indicates identical strings. A score above 0.9 typically indicates a strong match for names.

The following example finds customers with names similar to a search input:

```sql
-- Find customers with names similar to a search
DECLARE @searchFirst NVARCHAR(50) = 'John';
DECLARE @searchLast NVARCHAR(50) = 'Smythe';

SELECT 
    CustomerID,
    FirstName,
    LastName,
    JARO_WINKLER_DISTANCE(@searchFirst, FirstName) AS FirstNameScore,
    JARO_WINKLER_DISTANCE(@searchLast, LastName) AS LastNameScore,
    (JARO_WINKLER_DISTANCE(@searchFirst, FirstName) + 
     JARO_WINKLER_DISTANCE(@searchLast, LastName)) / 2 AS CombinedScore
FROM SalesLT.Customer
WHERE JARO_WINKLER_DISTANCE(@searchFirst, FirstName) > 0.85
  AND JARO_WINKLER_DISTANCE(@searchLast, LastName) > 0.85
ORDER BY CombinedScore DESC;
```

> [!NOTE]
> Jaro-Winkler is optimized for short strings like names. For longer strings like addresses or descriptions, `EDIT_DISTANCE_SIMILARITY` often provides better results.

## Performance considerations

Fuzzy matching functions examine every character in both strings, making them computationally intensive. Exact string comparison can stop as soon as characters differ, and indexed lookups use efficient B-tree traversal. In contrast, fuzzy algorithms must calculate similarity scores character by character. For a table with one million rows, an unoptimized fuzzy search might perform one million similarity calculations, each involving dozens of character comparisons.

The key to efficient fuzzy matching is reducing the candidate set before applying the expensive fuzzy functions. Use indexed columns with `LIKE` patterns, exact matches on related fields, or range filters to narrow results first. Only then apply fuzzy matching to the smaller candidate set.

The following examples show this progressive filtering approach:

```sql
-- Not good: Fuzzy match against entire table
SELECT * FROM LargeCustomerTable
WHERE EDIT_DISTANCE_SIMILARITY('John Smith', FullName) > 70;

-- Better: Pre-filter before fuzzy matching
SELECT * FROM LargeCustomerTable
WHERE FullName LIKE 'J%'  -- First letter filter
  AND EDIT_DISTANCE_SIMILARITY('John Smith', FullName) > 70;

-- Best: Use multiple pre-filters
SELECT * FROM LargeCustomerTable
WHERE FirstName LIKE 'Jo%'
  AND LastName LIKE 'Sm%'
  AND JARO_WINKLER_DISTANCE('John', FirstName) > 0.85
  AND JARO_WINKLER_DISTANCE('Smith', LastName) > 0.85;
```

> [!IMPORTANT]
> Fuzzy string matching functions like `EDIT_DISTANCE`, `EDIT_DISTANCE_SIMILARITY`, and `JARO_WINKLER_DISTANCE` are available in SQL Server 2025 and later, Azure SQL Database, and SQL databases in Microsoft Fabric. Check your platform's documentation for specific feature availability.

For more information about fuzzy string matching, see [String Functions](/sql/t-sql/functions/string-functions-transact-sql?azure-portal=true).
