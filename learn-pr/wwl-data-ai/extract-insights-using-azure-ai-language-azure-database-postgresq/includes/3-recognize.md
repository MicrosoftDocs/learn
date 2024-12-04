Named entity recognition is a [capability](/azure/ai-services/language-service/named-entity-recognition/overview) offered by [Azure AI Language](/azure/ai-services/language-service/overview). It identifies and categorizes entities in unstructured text. It supports several [categories](/azure/ai-services/language-service/personally-identifiable-information/concepts/entity-categories) of entity, including people, locations, events, products, organizations, etc.

There are several ways to call the [named entity recognition API](/azure/ai-services/language-service/named-entity-recognition/how-to-call). Here, you use the `azure_ai` extension to recognize entities from the text in SQL queries.

## Prerequisites

You need an Azure Database for PostgreSQL flexible server, with the `azure_ai` extension [enabled and configured](/azure/postgresql/flexible-server/generative-ai-azure-overview). You also need to [authorize it](/azure/postgresql/flexible-server/generative-ai-azure-cognitive#configure-azure_ai-extension-with-azure-cognitive-services) with Azure Cognitive Services by setting a Language resource's key and endpoint.

## Scenarios

Entity recognition is helpful in several domains, such as:

- Search and indexing: Automatically build knowledge graphs and tag directories with identified entities.
- Process automation: Automatically recognizes products and locations in unstructured text and routes them to customer support requests.
- Market analysis: Measures most frequent entities and entity clusters from social media, customer reviews, support tickets, etc., to determine relevant topics and anticipate trends.

## Using named entity recognition in SQL with Azure Cognitive Services

The Azure Database for PostgreSQL flexible server [azure_ai extension](/azure/postgresql/flexible-server/generative-ai-azure-overview) provides user-defined functions (UDFs) to access AI capabilities from within SQL directly. The named entity recognition API is accessed with the `azure_cognitive.recognize_entities` function provided by `azure_ai`:

```sql
azure_cognitive.recognize_entities(
 text text,
 language text,
 timeout_ms integer DEFAULT 3600000,
 throw_on_error boolean DEFAULT true,
 disable_service_logs boolean DEFAULT false
)
```

The required parameters are `text`, the input, and `language`, the language in which the `text` is written. For example, `en-us` is US English, and `fr` is French. See [language support](/azure/ai-services/language-service/concepts/language-support) for the complete list of available languages.

By default, entity recognition is stopped if it doesn't finish in 3,600,000 ms = 1 hour. You can customize this delay by changing `timeout_ms`.

If an error occurs, the default behavior is to throw an exception, resulting in a transaction rollback. You can disable this behavior by setting `throw_on_error` to false.

See the [Azure Cognitive Services extension documentation](/azure/postgresql/flexible-server/generative-ai-azure-cognitive#azure_cognitiverecognize_entities) for complete parameter documentation.

For example, invoking this query:

```sql
SELECT azure_cognitive.recognize_entities('For more information, see Cognitive Services Compliance and Privacy notes.', 'en-us');
```

Gives this result:

```sql
{"(\"Cognitive Services\",Skill,\"\",0.94)"}
```

Indicating the entity's name is "Cognitive Services," it's identified as a skill with a confidence score of 0.94.

You can use table columns for the input text:

```sql
SELECT description, azure_cognitive.recognize_entities(description, 'en-us')
FROM listings LIMIT 1;
```

Which returns:

```sql
 {"(house,Location,\"\",0.77)","(2013.,DateTime,DateRange,1)","(\"rooftop deck\",Location,\"\",0.88)","(\"lounge area\",Location,Structural,0.97)","(tub,Product,\"\",0.52)","
(5,Quantity,Number,0.8)","(bedrooms,Location,\"\",0.92)","(\"gourmet kitchen\",Location,\"\",0.87)","(2-3,Quantity,NumberRange,0.87)","(downtown,Location,Structural,0.8)","(\
"Queen Anne neighborhood\",Location,\"\",0.74)","(house,Location,\"\",0.96)","(barnwood,Product,\"\",0.61)","(steel,Product,\"\",0.73)","(concrete,Product,\"\",0.7)","(living
,Location,Structural,0.53)","(\"gourmet kitchen\",Location,\"\",0.7)","(kitchen,Location,\"\",0.77)","(reading,Skill,\"\",0.54)","(half,Quantity,Number,0.8)","(\"tv room\",Lo
cation,\"\",0.89)","(kitchen,Location,\"\",0.64)","(Fireplace,Product,\"\",0.91)","(sofa,Product,\"\",0.98)","(\"sitting area\",Location,\"\",0.93)","(\"Basement room\",Locat
ion,\"\",0.98)","(kids,PersonType,\"\",0.73)","(room,Location,Structural,0.78)","(patio,Location,Structural,0.75)","(basketball,Product,\"\",0.57)","(bedroom,Location,\"\",0.
8)","(basement,Location,\"\",0.94)","(\"concrete heated floors\",Product,\"\",0.95)","(\"queen sleeper sofa\",Product,\"\",0.86)","(tv,Location,\"\",0.54)","(basement,Locatio
n,\"\",0.92)","(room,Location,Structural,0.9)","(\"a second\",DateTime,Duration,0.85)","(family,PersonType,\"\",0.71)","(kids,PersonType,\"\",0.65)","(\"2nd floor\",Location,
Structural,0.56)","(4,Quantity,Number,0.8)","(bedrooms,Location,\"\",0.66)","(one,Quantity,Number,0.8)","(one,Quantity,Number,0.8)","(bedroom,Location,\"\",0.54)","(\"twin bu
nk beds\",Product,\"\",0.67)"}
```

## Summary

Named entity recognition identifies and categorizes entities in input text. The Azure Cognitive Services language model does the heavy natural language processing. The `azure_ai` extension for Azure Database for PostgreSQL provides the `azure_cognitive.recognize_entities` API to access named entity recognition directly within SQL queries.
