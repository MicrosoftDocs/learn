

## Translation in the Azure AI Extension

The [Azure AI Language service](/azure/ai-services/language-service/overview) provides powerful tools and models for working with text data. The integrations in the `azure_cognitive` schema of the `azure_ai` extension offer access to this rich set of natural language understanding and processing features accessible directly from the database. One of these functionalities includes the ability to translate text using the `translate()` function.

## The `azure_cognitive.translate()` function

Language translation is available in the `azure_cognitive.translate()` function. This function accepts input text, as well as one or more languages you would like to translate the text into. The function will use automatic language detection to determine the source language, or you may alternatively assign a source language for your input text.

The function returns a table built on the Azure AI Translator service's [response body](/azure/ai-services/translator/reference/v3-0-translate#response-body). This response includes the following columns:

| Name | Description |
| ---- | ----------- |
| `translations` | A JSON object containing one tuple for each combination of target language and translated text. |
| `detected_language` | The language, based on automatic language detection. If you specify a language using the `source_language` input parameter, this will be NULL. |
| `source_text` | An object containing the input text in the default script of the source language. This will be available only when the input is expressed in a script that is not the usual script for the language, such as if Thai text were written in Latin script. |

## Set the Translation service endpoint, key, and region

You must provide the service's endpoint and a key to successfully make calls against the Language service using the `azure_ai` extension. The commands below demonstrate how the settings can be added to the `azure_ai.settings` configuration table.

```sql
SELECT azure_ai.set_setting('azure_cognitive.endpoint','{endpoint}');
SELECT azure_ai.set_setting('azure_cognitive.subscription_key', '{key}');
SELECT azure_ai.set_setting('azure_cognitive.region', '{region}');
```

## Calling the `azure_cognitive.translate()` function

The following SQL statement will allow you to perform translation of a sample phrase in English into its equivalent in German. This requires the `azure_ai` extension and necessary extension settings already in place.

```sql
SELECT a.translations
FROM azure_cognitive.translate('Congratulations on successfully configuring Azure AI Translation!', 'de') a;
```

Running this command will return a response like the following.

```sql
                                          translations                                          
------------------------------------------------------------------------------------------------
 {"(de,\"Herzlichen Glückwunsch zur erfolgreichen Konfiguration der Azure AI-Übersetzung!\",)"}
(1 row)

```

You may also perform translation into multiple languages in one call by passing in an array of output languages.

```sql
SELECT (unnest(a.translations)).TARGET_LANGUAGE, (unnest(a.translations)).TEXT
FROM azure_cognitive.translate(text=>'Congratulations on successfully configuring Azure AI Translation!', target_language=>array['de', 'fr']) a;
```

This will return one row per language, including separate columns for the target language and the ouptut text.
