Azure AI Language is a cloud-based Natural Language Processing (NLP) service. Use this service to understand and analyze text with features such as: key phrase extraction, entity recognition, personally identifiable information (PII) detection, and more. Learn more here: [What is Azure AI Language?](/azure/ai-services/language-service/overview)

The Azure Database for PostgreSQL flexible server `azure_ai` extension integrates the database with the Azure AI Language services. It provides user-defined functions to access the language APIs within SQL. This allows you to extract insights from text directly from the database, without writing natural language processing code in client applications.

DIAGRAM:

* Show Azure DB for PostgreSQL flexible server
* Show `azure_ai` extension icon
* Show Azure AI Language icon
* Show key phrase + entity recognition + PII recognition APIs
* Show text going into each, with abstract result of each

## Example scenario

Consider a company that provides vacation listings. The company's marketing team wants to better understand customer preferences by identifying the key phrases used in the most popular listings, as well as which businesses, attractions, and places are highlighted. Also, the company's information security team wants to scan listings for personally identifiable information (PII) to ensure safety and privacy.

## What will we be doing?

We'll use the `azure_ai` extension to integrate an Azure Database for PostgreSQL flexible server with Azure AI Language to accomplish our three tasks. First, we'll extract the key phrases from listing descriptions and store them in the database, enabling the data science team to analyze which appear the most in popular listings. Then, we'll extract & store named entities for the same purpose. Lastly, we'll flag all listings that contain PII and store the redacted text.

## What is the main goal?

The main goal is to understand using the `azure_ai` PostgreSQL extension to access these Azure AI Language services: key phrase extraction, entity recognition, and PII detection. We'll see how to access these APIs in SQL as well as store the result data in columns.

## Setup: enable and authorize `azure_ai`

This learning path uses the `azure_ai` extension. There are a few steps to install and configure it. You need to add it to your allowlist as described in [how to use PostgreSQL extensions](/azure/postgresql/flexible-server/concepts-extensions#how-to-use-postgresql-extensions). Then, install the extension by running this SQL query:

```postgresql
CREATE EXTENSION azure_ai;
```

If you want to remove the extension, use:

```postgresql
DROP EXTENSION azure_ai;
```

Installing the extension creates these three schemas:

- `azure_ai`: the main schema storing configuration data & functions.
- `azure_openai`: functions and composite types related to OpenAI.
- `azure_cognitive`: functions and composite types related to Cognitive Services.

Our tasks use Azure Cognitive Services. After [enabling](/azure/postgresql/flexible-server/generative-ai-azure-overview#enable-the-azure_ai-extension) and [configuring](/azure/postgresql/flexible-server/generative-ai-azure-overview#configure-the-azure_ai-extension) the `azure_ai` extension, you can integrate it with Azure Cognitive Services to access key phrase extraction from SQL.

If you don't already have one, [create a Language resource](https://portal.azure.com/#create/Microsoft.CognitiveServicesTextAnalytics) in the Azure portal. Once you have a Language resource, go to **Resource Management > Keys and Endpoint** to get your key and endpoint for Azure Cognitive Services.

Next, authorize the Azure Database for PostgreSQL flexible server's `azure_ai` extension by running this SQL:

```postgresql
select azure_ai.set_setting('azure_cognitive.endpoint','https://<endpoint>.cognitiveservices.azure.com');
select azure_ai.set_setting('azure_cognitive.subscription_key', '<API Key>');
-- the region setting is only required for the translate function
select azure_ai.set_setting('azure_cognitive.region', '<API Key>');
```

More information is available in the [Azure Cognitive Services documentation](/azure/postgresql/flexible-server/generative-ai-azure-cognitive#configure-azure_ai-extension-with-azure-cognitive-services).
