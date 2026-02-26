You now understand what RAG is and when to use it. In the following units, you learn how to implement each step of the RAG workflow in T-SQL. 

Consider the following scenario: A customer asks "Which pedals fit the mountain bike I bought last month?" You query the database, find their order, identify the bike model, and locate compatible components. That step represents the "R" in RAG: retrieval. Let's retrieve and prepare that data for the language model. There are many ways to retrieve data from SQL, but for RAG, the goal is to provide the model with structured context it can actually use.

## Convert relational data to JSON

Language models process text, not relational structures. If you pass raw query results, the model has no way to interpret column names, data types, or relationships. JSON solves this issue by preserving structure in a text format. Field names stay attached to values. Nested objects represent relationships. The model can read "ProductName": "Mountain-500" and reference that specific product in its response.

JSON also keeps things predictable. When the model returns an answer, you know the answer came from fields you explicitly provided. If you dumped unstructured text instead, you'd have less control over what the model uses to formulate its response.

## Format query results with FOR JSON

No need to build JSON strings by hand. Just add `FOR JSON` to the end of your SELECT and SQL does the work:

- `FOR JSON AUTO` formats output based on your query structure. Column names become field names automatically.

    ```sql
    SELECT Name, ListPrice, Color
    FROM Production.Product
    WHERE ProductID = @ProductID
    FOR JSON AUTO;
    ```

    This query returns something like: `[{"Name":"Mountain-500 Black, 48","ListPrice":564.99,"Color":"Black"}]`

- `FOR JSON PATH` gives you explicit control over the JSON structure. You define the field names and nesting using column aliases.

    ```sql
    SELECT 
        Name AS 'product.name',
        ListPrice AS 'product.price',
        Size AS 'product.size'
    FROM Production.Product
    WHERE ProductID = @ProductID
    FOR JSON PATH;
    ```

    This query returns something like: `[{"product":{"name":"Mountain-500 Black, 48","price":564.99,"size":"48"}}]`

## Control JSON output options

A few options let you shape the output:

- `WITHOUT_ARRAY_WRAPPER` removes the square brackets when you're retrieving a single record. This option is useful for RAG because you often retrieve one customer, one product, or one order at a time.

    ```sql
    SELECT Name, Description, Size, Weight
    FROM Production.Product
    WHERE ProductID = @ProductID
    FOR JSON PATH, WITHOUT_ARRAY_WRAPPER;
    ```

- `INCLUDE_NULL_VALUES` keeps null fields in the output instead of omitting them. Use this parameter when the absence of a value is meaningful.

- `ROOT('name')` wraps the entire output in a named root element, which can help the model understand what kind of data it's receiving.

## Choose what to include

Not every column belongs in your context. For example, internal IDs, audit timestamps, and warehouse codes don't help the model answer customer questions. They just consume tokens and add noise.

For a product question, include the product name, description, specifications, and pricing. Skip the rowguid, modified date, and discontinued flag unless they're directly relevant.

Token limits matter too. Every token you send costs money and counts against the model's context window. If you're retrieving multiple products, keep each one lean. The model performs better with focused context than with everything you could possibly include.

## Combine multiple sources

RAG context often comes from multiple tables. A pedal compatibility question needs product details, specifications, and related components. You might start by finding relevant products with vector search, then join other tables to build out the full picture.

Here's what that looks like in practice. First, convert the user's question into an embedding. Then use `VECTOR_DISTANCE` to find the closest matches, join the related tables, and format everything as JSON:

```sql
DECLARE @userQuestion NVARCHAR(1000) = 'Which pedals are compatible with the Mountain-500?';
DECLARE @questionVector VECTOR(1536);
DECLARE @context NVARCHAR(MAX);

-- Generate embedding for the question
SELECT @questionVector = AI_GENERATE_EMBEDDINGS(@userQuestion USE MODEL my_embedding_model);

-- Find relevant products and format as JSON
SET @context = (
    SELECT TOP 3
        p.Name AS ProductName,
        p.Color,
        p.Size,
        pc.Name AS Category,
        pm.Name AS Model
    FROM Production.Product p
    INNER JOIN Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
    INNER JOIN Production.ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID
    INNER JOIN Production.ProductModel pm ON p.ProductModelID = pm.ProductModelID
    ORDER BY VECTOR_DISTANCE('cosine', p.DescriptionVector, @questionVector)
    FOR JSON PATH
);
```

The variable `@context` now holds a JSON string ready for the prompt. This JSON string is your retrieval result formatted for augmentation.

## Key takeaways

The goal is to give the language model structured context it can actually use. JSON preserves the meaning of your data while keeping it readable as text. Use `FOR JSON AUTO` when you want quick results and `FOR JSON PATH` when you need control over field names and nesting. Add `WITHOUT_ARRAY_WRAPPER` for single-record queries. Keep your JSON lean by including only the columns the model needs. Less noise means better answers and lower token costs.
