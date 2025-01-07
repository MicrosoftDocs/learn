

## Translation in the azure_ai extension

The [Azure AI Language service](/azure/ai-services/language-service/overview) provides powerful tools and models for working with text data. The integrations in the `azure_cognitive` schema of the `azure_ai` extension offer access to this rich set of natural language understanding and processing features accessible directly from the database. One of these functionalities includes the ability to translate text using the `translate()` function.

## The `azure_cognitive.translate()` function

Language translation is available in the `azure_cognitive.translate()` function. This function accepts input text and one or more languages you would like to translate it into. The function automatically detects the source language, or you can assign a source language for your input text.

The function returns a table built on the Azure AI Translator service's [response body](/azure/ai-services/translator/reference/v3-0-translate#response-body). This response includes the following columns:

| Name | Description |
| ---- | ----------- |
| `translations` | A JSON object containing one tuple for each target language and translated text combination. |
| `detected_language` | The language is based on automatic language detection. If you specify a language using the `source_language` input parameter, this parameter is set to NULL. |
| `source_text` | An object containing the input text in the default script of the source language. This option is available only when the input is expressed in a script that isn't the usual script for the language. Such as if Thai text were written in Latin script. |

## Set the translation service endpoint, key, and region

To successfully make calls against the Language service using the `azure_ai` extension, you must provide the service's endpoint and a key. The following commands demonstrate how the settings can be added to the `azure_ai.settings` configuration table.

```sql
SELECT azure_ai.set_setting('azure_cognitive.endpoint','{endpoint}');
SELECT azure_ai.set_setting('azure_cognitive.subscription_key', '{key}');
SELECT azure_ai.set_setting('azure_cognitive.region', '{region}');
```

## Calling the `azure_cognitive.translate()` function

The following SQL statement allows you to translate a sample phrase in English into its equivalent in German. This translation requires the `azure_ai` extension and the necessary extension settings already in place.

```sql
SELECT a.translations
FROM azure_cognitive.translate('Congratulations on successfully configuring Azure AI Translation!', 'de') a;
```

Running this command returns a response like the following.

```sql
                     translations                     
------------------------------------------------------------------------------------------------
 {"(de,\"Herzlichen Glückwunsch zur erfolgreichen Konfiguration der Azure AI-Übersetzung!\",)"}
(1 row)

```

You can also perform translation into multiple languages in one call by passing in an array of output languages.

```sql
SELECT (unnest(a.translations)).TARGET_LANGUAGE, (unnest(a.translations)).TEXT
FROM azure_cognitive.translate(text=>'Congratulations on successfully configuring Azure AI Translation!', target_language=>array['de', 'fr']) a;
```

This command returns one row per language, including separate columns for the target language and the output text.
