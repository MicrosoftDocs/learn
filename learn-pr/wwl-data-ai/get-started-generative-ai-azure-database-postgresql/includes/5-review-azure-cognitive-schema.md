The [Azure AI Language service](/azure/ai-services/language-service/overview) provides powerful tools and generative AI language models for working with text data. The integrations in the `azure_cognitive` schema of the `azure_ai` extension offer access to this rich set of natural language understanding and processing features accessible directly from the database. The functionalities include sentiment analysis, language detection and translation, key phrase extraction, entity recognition, and text summarization. Here are the key aspects:

**Sentiment analysis** predicts a given text's sentiment (positive, negative, or neutral). It assigns confidence scores to each sentiment label, helping you understand the emotional tone of user-generated content, reviews, or social media posts.

**Language detection** identifies the language in which a text is written. It's helpful for scenarios like multilingual applications or content filtering.

**Summarization** generates concise summaries of longer texts. It's valuable for extracting essential information from articles, documents, or lengthy paragraphs.

**Key phrase extraction** identifies significant terms or phrases within a document. It aids in content categorization, search indexing, and topic modeling.

Entity extraction involves identifying entities within the text, such as names, places, dates, email addresses, etc. It encompasses several capabilities, including entity linking and PII (Personally Identifiable Information) detection.

**Text translation** executes text translation between supported source and target languages.

## The `azure_cognitive` schema

The `azure_cognitive` schema within the `azure_ai` extension is designed to facilitate interactions with the Azure AI Language service directly from a PostgreSQL database. The schema includes numerous user-defined functions (UDFs).

### Functions

The available functions enable sentiment analysis, language detection and translation, key phrase and entity extraction, and text summarization.

| Name | Description |
| ---- | ----------- |
| `analyze_sentiment` | Performs sentiment analysis by mining text for positive or negative sentiment clues. |
| `detect_language` | Detects the language of the provided text. |
| `extract_key_phrases` | Extracts the main concepts in text. |
| `linked_entities` | Identifies and disambiguates the identity of an entity found in text. |
| `recognize_entities` | Identifies entities within the text. |
| `recognize_pii_entities` | Identifies, categorizes, and redacts sensitive information in unstructured text. |
| `summarize_abstractive` | Generates a summary by creating new original content that represents the key concepts found within the text. |
| `summarize_extractive` | Generates a summary by identifying key sentences within the text and using those sentences to represent the essential concepts. |
| `translate` | Translates text into the specified language. |

### Example: Sentiment analysis

The following example demonstrates how to call the `analyze_sentiment` function:

```sql
SELECT *
FROM azure_cognitive.analyze_sentiment(
  'The service was fantastic and the experience was wonderful!'
);
```

A result similar to the following one is returned. Notice that the output uses **composite types**, which structure sentiment, confidence scores, and sentence-level details:

```
 sentiment_analysis_result
---------------------------------------------------------
 (positive,"{(positive,0.98,0.01,0.01)}","The service...")
```

## Set the Language service endpoint and key

As with the `azure_openai` functions, you must provide the service's endpoint and a key to successfully make calls against the Language service using the `azure_ai` extension. The following commands demonstrate how the settings can be added to the `azure_ai.settings` configuration table.

```sql
SELECT azure_ai.set_setting('azure_cognitive.endpoint', '{endpoint}');
SELECT azure_ai.set_setting('azure_cognitive.subscription_key', '{api-key}');
```

If performing text translation using the `translate` function, you must also provide a region when configuring the extension's connection to your Azure AI service:

```sql
-- the region setting is only required for the translate function
SELECT azure_ai.set_setting('azure_cognitive.region', '{region}');
```
