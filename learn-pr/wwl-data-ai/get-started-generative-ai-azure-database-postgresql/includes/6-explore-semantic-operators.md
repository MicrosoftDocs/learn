The `azure_ai` extension includes a small set of semantic operators that allow you to work with generative AI models directly in SQL. These operators help you generate text, evaluate statements, extract structured information, and rank documents. Each operator calls a model you configured in the `azure_ai.settings` table.

The semantic operators are:

- `azure_ai.generate` – generates text and can return structured JSON when a schema is supplied.
- `azure_ai.is_true` – evaluates a statement and returns whether it's likely to be true.
- `azure_ai.extract` – pulls specific fields or values from unstructured text.
- `azure_ai.rank` – returns a relevance-ranked list of documents for a given query.

## The `generate` operator

`azure_ai.generate` sends a prompt to a model and returns the generated text. If you provide a JSON schema, the model attempts to return structured data that conforms to that schema. This method is useful when you need output that IS consumed by subsequent SQL logic.

Example:

```sql
SELECT azure_ai.generate(
  prompt => 'Summarize the following review: ' || review_text
)
FROM product_reviews;
```

If a schema is provided, the result is returned as `jsonb`.

## The `is_true` operator

`azure_ai.is_true` evaluates a statement and returns `true`, `false`, or `NULL` if the model can't determine the answer. This operator is helpful when you need to check whether a piece of text satisfies a condition or refers to a specific concept.

Example:

```sql
SELECT azure_ai.is_true(
  'This review describes the product as durable: ' || review_text
) AS durability_claim
FROM product_reviews;
```

## The `extract` operator

`azure_ai.extract` identifies specific fields inside a document. You specify an array of labels, and the model returns a `jsonb` object containing the extracted values. This operator is well-suited for pulling structured details from longer text.

Example:

```sql
SELECT azure_ai.extract(
  'The headphones have clear sound but the battery life is short.',
  ARRAY['sound_quality', 'battery_life']
);
```

The result is a JSON document containing the requested fields.

## The `rank` operator

`azure_ai.rank` returns documents ordered by relevance to a query. You supply the query text and an array of documents. The operator returns a rowset that includes each document, its rank, and a score. This rowset is useful when you want the model to help determine which items are most relevant to a user’s search.

Example:

```sql
SELECT *
FROM azure_ai.rank(
  'Lightweight travel headphones',
  ARRAY[
    'These foldable headphones are easy to pack.',
    'Battery life is average.',
    'Sound quality is very detailed.'
  ]
);
```

The operator returns one row per document with ranking information.

## Configuration

All semantic operators rely on the model configuration stored in `azure_ai.settings`. Before calling the operators, ensure that you set the endpoint and key for the model you intend to use.

Example:

```sql
SELECT azure_ai.set_setting('azure_openai.endpoint', '{endpoint}');
SELECT azure_ai.set_setting('azure_openai.api_key', '{api_key}');
```

Once the settings are in place, the semantic operators can be used in standard SQL queries, views, or stored procedures.

## Takeaways

Semantic operators in the `azure_ai` extension provide powerful capabilities to integrate generative AI directly into your SQL workflows. By using these operators, you can enhance your applications with text generation, truth evaluation, information extraction, and document ranking, all within the familiar context of a PostgreSQL database.