PII detection is a [feature](/azure/ai-services/language-service/personally-identifiable-information/overview) offered by [Azure AI Language](). It identifies, categorizes, and redacts personally identifiable information (PII) in unstructured text. PII includes email addresses, phone numbers, payment information, and so on.

DIAGRAM:

- Input text
- Azure AI Language PII recognition
- Sample result table: redacted text + recognized PII

There are several ways to call the [PII detection API](/azure/ai-services/language-service/personally-identifiable-information/how-to-call). Here, we'll use the `azure_ai` extension to process PII from text in SQL queries.

## Prerequisites

You'll need an Azure Database for PostgreSQL flexible server, with the `azure_ai` extension [enabled and configured](/azure/postgresql/flexible-server/generative-ai-azure-overview). You'll also need to [authorize it](/azure/postgresql/flexible-server/generative-ai-azure-cognitive#configure-azure_ai-extension-with-azure-cognitive-services) with Azure Cognitive Services by setting a Language resource's key and endpoint.

## Scenarios

Use PII detection for several applications including:

- Sensitivity labels: categorize documents or emails by sensitivity according to types of PII. Text with phone numbers might be marked confidential whereas credit card or bank account numbers would be marked highly secret.
- Redaction for support and operations: many operational tasks such as incident triage or support routing don't require knowing personal information. Companies can use PII redaction to filter customer information when unnecessary to an employee's task.
- Reduce personal information to reduce unconscious bias: a company could remove name, address, and other information to help reduce unconscious gender or other biases.

## Detecting PII in SQL with Azure Cognitive Services

The Azure Database for PostgreSQL flexible server [Azure AI Extension](/azure/postgresql/flexible-server/generative-ai-azure-overview) provides user-defined functions (UDFs) to access AI capabilities from within SQL directly. The PII detection API is accessed with the `azure_cognitive.recognize_pii_entities` function provided by `azure_ai`:

```postgresql
azure_cognitive.recognize_pii_entities(
  text text,
  language text,
  timeout_ms integer DEFAULT 3600000,
  throw_on_error boolean DEFAULT true,
  domain text DEFAULT 'none'::text,
  disable_service_logs boolean DEFAULT false
)
```

The required parameters are `text`, the input, and `language`, the language the `text` is written in. For example, `en-us` is US English and `fr` is French. See [language support](/azure/ai-services/language-service/concepts/language-support) for the full list of available languages.

By default, entity recognition is stopped if it doesn't finish in 3600000 ms = 1 hour. You can customize this delay by changing `timeout_ms`.

If an error occurs, the default behavior is to throw an exception resulting in a transaction rollback. You can disable this by setting `throw_on_error` to false.

The `domain` parameter may be used to customize the kind of personal data identified. Currently, the default `none` uses general PII, and the domain `phi` identifies Personal Health Information.

See the [Azure Cognitive Services extension documentation](/azure/postgresql/flexible-server/generative-ai-azure-cognitive#personally-identifiable-data-pii-detection) for full parameter documentation.

For example, invoking this query:

```postgresql
SELECT azure_cognitive.recognize_pii_entities('My phone number is +1555555555, and the address of my office is 16255 NE 36th Way, Redmond, WA 98052.', 'en-us');
```

gives this result:

```json
("My phone number is ***********, and the address of my office is ************************************.","{""(+1555555555,PhoneNumber,\\""\\"",0.8)"",""(\\""16255 NE 36th Way, Redmond, WA 98052\\"",Address,\\""\\"",1)""}")
```

The PII service detected the phone number witth a confidence score of 0.8, and the address with a confidence score of 1. It also returned the input with the two PII data points redacted.

You can use table columns for the input text:

```postgresql
SELECT description, azure_cognitive.recognize_pii_entities(description, 'en-us')
FROM listings LIMIT 1;
```

which returns (with `\x` enabled for extended display):

```
recognize_pii_entities | ("New modern house built in 2013.  Spectacular sunset/water views and light, rooftop deck and lounge area, hot tub, 5 bedrooms, gourmet kitchen.  Perfect for 2-3 families, walk to downtown.  Located in highly desirable Queen Anne neighborhood. Our house is modern, light and fresh with a warm simple palette accented with barnwood, steel and concrete.  Open living spaces for entertaining, gourmet kitchen, deck off the kitchen, reading nook, half bath and smaller tv room off kitchen.  Fireplace with sofa and sitting area. Basement room is great for ****...this room has patio access and a garage door that opens into the space with basketball hoop right outside.  A queen bedroom and full bath are in the basement with concrete heated floors.  A queen sleeper sofa is in the tv area in the basement.  This room has a door if privacy is needed.  Great for a second ****** with ****.  The 2nd floor has 4 bedrooms (one queen in master, one twin bedroom, another bedroom has twin bunk beds and the last","{""(kids,PersonType,\\""\\"",0.73)"",""(family,PersonType,\\""\\"",0.71)"",""(kids,PersonType,\\""\\"",0.65)""}")
```

## Summary

PII detection identifies and categorizes personally identifiable information in unstructured input text. The Azure Cognitive Services language model does the heavy lifting, and the `azure_ai` extension for Azure Database for PostgreSQL provides the `azure_cognitive.recognize_pii_entities` API to detect & redact PII from directly within SQL queries.
