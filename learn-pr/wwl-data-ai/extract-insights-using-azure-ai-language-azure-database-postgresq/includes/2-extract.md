Key phrase extraction is a [capability](/azure/ai-services/language-service/key-phrase-extraction/overview) offered by [Azure AI Language](/azure/ai-services/language-service/overview). It identifies the key phrases, or main concepts, in text.

DIAGRAM:

- Input text
- Azure AI Language key phrase extraction
- Sample result table: key phrases + confidence

There are several ways to call the [key phrase extraction API](/azure/ai-services/language-service/key-phrase-extraction/how-to/call-api). Here, we use the `azure_ai` extension to extract key phrases in SQL queries.

## Prerequisites

You need an Azure Database for PostgreSQL flexible server, with the `azure_ai` extension [enabled and configured](/azure/postgresql/flexible-server/generative-ai-azure-overview). You also need to [authorize it](/azure/postgresql/flexible-server/generative-ai-azure-cognitive#configure-azure_ai-extension-with-azure-cognitive-services) with Azure Cognitive Services by setting a Language resource's key and endpoint.

## Scenarios

Key phrase extraction applies to various tasks:

- Summarization: use key phrases to reduce lengthy documents to core topics, for example to identify topics discussed in audio transcripts or meeting notes.
- Content categorization: use key phrases to index documents for search and browsing. Key phrases can be used to visualize documents in word clouds.
- Document clustering: large collections of support tickets, product reviews, and other unstructured input can be clustered and analyzed by key phrases.

## Using key phrase extraction SQL with Azure Cognitive Services

The Azure Database for PostgreSQL flexible server [Azure AI Extension](/azure/postgresql/flexible-server/generative-ai-azure-overview) provides user-defined functions (UDFs) to access AI capabilities from within SQL directly. The key phrase extraction API is accessed with the `azure_cognitive.extract_key_phrases` function:

```postgresql
azure_cognitive.extract_key_phrases(
  text TEXT,
  language TEXT,
  timeout_ms INTEGER DEFAULT 3600000,
  throw_on_error BOOLEAN DEFAULT TRUE,
  disable_service_logs BOOLEAN DEFAULT FALSE
)
```

The required parameters are `text`, the input, and `language`, the language the `text` is written in. For example, `en-us` is US English and `fr` is French. See [language support](/azure/ai-services/language-service/concepts/language-support) for the full list of available languages.

By default, key phrase extraction is stopped if it doesn't finish in 3,600,000 ms = 1 hour. You can customize this delay by changing `timeout_ms`.

If an error occurs, the default behavior is to throw an exception resulting in a transaction rollback. You can disable this behavior by setting `throw_on_error` to false.

See the [Azure Cognitive Services extension documentation](/azure/postgresql/flexible-server/generative-ai-azure-cognitive#azure_cognitiveextract_key_phrases) for full parameter documentation.

For example, invoking this query:

```postgresql
SELECT azure_cognitive.extract_key_phrases('The food was delicious and the staff were wonderful.', 'en-us');
```

Gives this result:

```
 extract_key_phrases 
---------------------
 {food,staff}
```

You can use table columns for the input text:

```postgresql
SELECT description, azure_cognitive.extract_key_phrases(description, 'en-us')
FROM listings LIMIT 1;
```

Which returns (with `\x` on for extended display):

```
description         | Welcome! If you stay here you will be living in a light filled two bedroom upper and ground level apartment (in a two apartment home). During your stay you will be welcome to share in our fresh eggs from the chickens and garden produce in season! Welcome!  Come enjoy your time in Seattle at a lovely urban farmstead.  There are two bedrooms each with a queen bed, full bath, living room and kitchen with wood floors throughout.  During your stay you will be welcome to eat fresh eggs from the chickens and possibly fruit/veggies from the garden if you are in luck!   We are family friendly and have a down to earth atmosphere.  There is a large covered back porch and grill for hanging out especially in summer and a treehouse for up in the trees hammock time! Walking distance to Othello Light Rail Station for easy access to downtown.  Also nearby is the fantastic Seward Park and the Kubota Gardens for outdoorsy loveliness.  New last year is out beautiful Rainier Beach indoor swimming pool comp
extract_key_phrases | {"beautiful Rainier Beach indoor swimming pool","large covered back porch","Othello Light Rail Station","ground level apartment","lovely urban farmstead","fantastic Seward Park","two bedroom upper","two apartment home","two bedrooms","fresh eggs","queen bed","full bath","living room","wood floors","earth atmosphere","Walking distance","easy access","Kubota Gardens","outdoorsy loveliness","garden produce","hammock time",stay,chickens,season,Seattle,kitchen,fruit/veggies,luck,grill,summer,treehouse,trees,downtown,last}
```

## Summary

Key phrase extraction selects the main concepts from text. The Azure Cognitive Services language model is responsible for boiling natural language down into key words or phrases. The `azure_ai` extension for Azure Database for PostgreSQL provides the `azure_cognitive.extract_key_phrases` API to access key phrase extraction from directly within SQL queries.
