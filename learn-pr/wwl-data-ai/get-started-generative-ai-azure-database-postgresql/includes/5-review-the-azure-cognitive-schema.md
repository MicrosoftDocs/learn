The [Azure AI Language service](/azure/ai-services/language-service/overview) provides powerful tools and models for working with text data. The integrations in the `azure_cognitive` schema of the `azure_ai` extension offer access to this rich set of natural language understanding and processing features accessible directly from the database. The functionalities include sentiment analysis, language detection and translation, key phrase extraction, entity recognition, and text summarization. Here are the key aspects:

**Sentiment analysis** predicts a given text's sentiment (positive, negative, or neutral). It assigns confidence scores to each sentiment label, helping you understand the emotional tone of user-generated content, reviews, or social media posts.

**Language detection** identifies the language in which a text is written. It's helpful for scenarios like multilingual applications or content filtering.

**Summarization** generates concise summaries of longer texts. It's valuable for extracting essential information from articles, documents, or lengthy paragraphs.

**Key phrase extraction** identifies significant terms or phrases within a document. It aids in content categorization, search indexing, and topic modeling.

**Entity extraction** involves identifying entities within the text, such as names, places, dates, email addresses, etc. Entity extraction encompasses several capabilities, including entity linking and PII (Personally Identifiable Information) detection.

## The `azure_cognitive` schema

The `azure_cognitive` schema within the Azure AI extension is designed to facilitate interactions with the Azure AI Language service directly from a PostgreSQL database. The schema includes numerous user-defined functions (UDFs) and composite types.

### Functions

The available functions enable sentiment analysis, language detection and translation, key phrase and entity extraction, and text summarization.

| Name | Description |
| ---- | ----------- |
| `analyze_sentiment` | Performs sentiment analysis by mining text for positive or negative sentiment clues. |
| `detect_language` | Detects the language of the provided text. |
| `extract_key_phrases` | Extracts the main concepts in text. |
| `linked_entities` | Identifies and disambiguates the identity of an entity found in text.  |
| `recognize_entities` | Identifies entities within the text. |
| `recognize_pii_entities` | Identifies, categorizes, and redacts sensitive information in unstructured text. |
| `summarize_abstractive` | Generates a summary by creating new original content that represents the key concepts found within the text. |
| `summarize_extractive` | Generates a summary by identifying key sentences within the text and using those sentences to represent the essential concepts. |
| `translate` | Translates text into the specified language. |

### Composite types

The composite types within the `azure_cognitive` schema handle the return values from the various functions. These types provide the structures required to handle the objects returned by the Language service and include:

- azure_cognitive.detected_language
- azure_cognitive.entity
- azure_cognitive.language_detection_result
- azure_cognitive.linked_entity
- azure_cognitive.linked_entity_match
- azure_cognitive.pii_entity_recognition_result
- azure_cognitive.sentence
- azure_cognitive.sentiment_analysis_result
- azure_cognitive.translated_text_result
- azure_cognitive.translation
- azure_cognitive.transliterated_text

## Set the Language service endpoint and key

As with the `azure_openai` functions, you must provide the service's endpoint and a key to successfully make calls against the Language service using the `azure_ai` extension. The following commands demonstrate how the settings can be added to the `azure_ai.settings` configuration table.

```sql
SELECT azure_ai.set_setting('azure_cognitive.endpoint', '{endpoint}');
SELECT azure_ai.set_setting('azure_cognitive.subscription_key', '{api-key}');
```
