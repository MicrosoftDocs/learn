Key phrase extraction is a [capability](/azure/ai-services/language-service/key-phrase-extraction/overview) offered by [Azure AI Language](/azure/ai-services/language-service/overview). It identifies the key phrases, or main concepts, in the text.

There are several ways to call the [key phrase extraction API](/azure/ai-services/language-service/key-phrase-extraction/how-to/call-api). Here, you use the `azure_ai` extension to extract key phrases in SQL queries.

## Prerequisites

You need an Azure Database for PostgreSQL flexible server, with the `azure_ai` extension [enabled and configured](/azure/postgresql/flexible-server/generative-ai-azure-overview). You also need to [authorize it](/azure/postgresql/flexible-server/generative-ai-azure-cognitive#configure-azure_ai-extension-with-azure-cognitive-services) with Azure Cognitive Services by setting a Language resource's key and endpoint.

## Scenarios

Key phrase extraction applies to various tasks:

- Summarization: Use key phrases to reduce lengthy documents to core topics, such as identifying topics discussed in audio transcripts or meeting notes.
- Content categorization: Use key phrases to index documents for search and browsing. Key phrases can also be used to visualize documents in word clouds.
- Document clustering: Extensive collections of support tickets, product reviews, and other unstructured input can be clustered and analyzed using key phrases.

## Using key phrase extraction SQL with Azure Cognitive Services

The [azure_ai extension](/azure/postgresql/flexible-server/generative-ai-azure-overview) for Azure Database for PostgreSQL flexible server provides user-defined functions (UDFs) to access AI capabilities from within SQL directly. The key phrase extraction API is accessed with the `azure_cognitive.extract_key_phrases` function:

```sql
azure_cognitive.extract_key_phrases(
 text TEXT,
 language TEXT,
 timeout_ms INTEGER DEFAULT 3600000,
 throw_on_error BOOLEAN DEFAULT TRUE,
 disable_service_logs BOOLEAN DEFAULT FALSE
)
```

The required parameters are `text`, the input, and `language`, the language in which the `text` is written. For example, `en-us` is US English, and `fr` is French. See [language support](/azure/ai-services/language-service/concepts/language-support) for the complete list of available languages.

By default, key phrase extraction is stopped if it doesn't finish in 3,600,000 ms, which is 1 hour. You can customize this delay by changing `timeout_ms`.

If an error occurs, the default behavior is to throw an exception, resulting in a transaction rollback. You can disable this behavior by setting `throw_on_error` to false.

See the [Azure Cognitive Services extension documentation](/azure/postgresql/flexible-server/generative-ai-azure-cognitive#azure_cognitiveextract_key_phrases) for complete parameter documentation.

For example, invoking this query:

```sql
SELECT azure_cognitive.extract_key_phrases('The food was delicious and the staff were wonderful.', 'en-us');
```

Gives this result:

```sql
 extract_key_phrases 
---------------------
 {food,staff}
```

You can use table columns for the input text:

```sql
SELECT description, azure_cognitive.extract_key_phrases(description, 'en-us')
FROM listings LIMIT 1;
```

Which returns (with `\x` on for extended display):

```sql
description    | Welcome! If you stay here you will be living in a light filled two bedroom upper and ground level apartment (in a two apartment home). During your stay you will be welcome to share in our fresh eggs from the chickens and garden produce in season! Welcome! Come enjoy your time in Seattle at a lovely urban farmstead. There are two bedrooms each with a queen bed, full bath, living room and kitchen with wood floors throughout. During your stay you will be welcome to eat fresh eggs from the chickens and possibly fruit/veggies from the garden if you are in luck! We are family friendly and have a down to earth atmosphere. There is a large covered back porch and grill for hanging out especially in summer and a treehouse for up in the trees hammock time! Walking distance to Othello Light Rail Station for easy access to downtown. Also nearby is the fantastic Seward Park and the Kubota Gardens for outdoorsy loveliness. New last year is out beautiful Rainier Beach indoor swimming pool comp
extract_key_phrases | {"beautiful Rainier Beach indoor swimming pool","large covered back porch","Othello Light Rail Station","ground level apartment","lovely urban farmstead","fantastic Seward Park","two bedroom upper","two apartment home","two bedrooms","fresh eggs","queen bed","full bath","living room","wood floors","earth atmosphere","Walking distance","easy access","Kubota Gardens","outdoorsy loveliness","garden produce","hammock time",stay,chickens,season,Seattle,kitchen,fruit/veggies,luck,grill,summer,treehouse,trees,downtown,last}
```

## Summary

Key phrase extraction selects the main concepts from the text. The Azure Cognitive Services language model is responsible for boiling natural language down into keywords or phrases. The `azure_ai` extension for Azure Database for PostgreSQL provides the `azure_cognitive.extract_key_phrases` API to access key phrase extraction directly within SQL queries.
