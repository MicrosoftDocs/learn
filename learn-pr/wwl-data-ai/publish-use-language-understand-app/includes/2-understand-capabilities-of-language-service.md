The Azure AI Language service provides various features for understanding human language. A client application can use each feature to better communicate with users, or use them together to provide more insight into what the user is saying, intending, and asking about.

Azure AI Language service features fall into two categories: Pre-configured features, and Learned features. Learned features require building and training a model to correctly predict appropriate labels.

This unit covers most of the capabilities of the Azure AI Language service, but head over to the [Azure AI Language service documentation](/azure/cognitive-services/language-service/overview) for a full list, including quickstarts and a full explanation of everything available.

The endpoint used to query a specific feature varies, but all of them are prefixed with the Azure AI Language resource you created in your Azure account. The endpoint will look something like this:

```http
https://{ENDPOINT}/text/analytics/{VERSION}/{FEATURE}
```

|Placeholder  |Value  |
|---------|---------|
|`{ENDPOINT}`     | The endpoint for authenticating your API request. For example, `myLanguageService.cognitiveservices.azure.com`   |
|`{VERSION}`     | The version number of the service you want to call. For example, `v3.0`   |
|`{FEATURE}`     | The feature you're submitting the query to. For example, `keyPhrases` for key phrase detection   |

Along with the POST query to the appropriate endpoint, a JSON body will be included that specifies the input documents, specifies the task(s), and provides other metadata to the service. The JSON response structure, headers, and fields that are returned depend on which services you query.

## Pre-configured features

The Azure AI Language service provides certain features without any model labeling or training. Once you create your resource, you can send your data and use the returned results within your app.

The following features are all pre-configured.

### Summarization

Summarization is available for both documents and conversations, and will summarize the text into key sentences that are predicted to encapsulate the input's meaning.

A summarization query will be sent to an endpoint similar to the following, with the task specified as `extractiveSummarizationTasks` or `ConversationalSummarizationTask`, depending on which summarization task you want.

```http
/{ENDPOINT}/text/analytics/{VERSION}/analyze
```

|Placeholder  |Value  |
|---------|---------|
|`{ENDPOINT}`     | The endpoint for authenticating your API request. For example, `myLanguageService.cognitiveservices.azure.com`   |
|`{VERSION}`     | The version number of the service you want to call. For example, `v3.0`   |

### Named entity recognition

Named entity recognition can extract and identify entities, such as people, places, or companies, allowing your app to recognize different types of entities for improved natural language responses. For example, given the text "The waterfront pier is my favorite Seattle attraction", *Seattle* would be identified and categorized as a location.

An entity recognition query will be sent to an endpoint similar to the following, with the task specified as `EntityRecognition`.

```http
/{ENDPOINT}/language/:analyze-text?api-version={VERSION}
```

|Placeholder  |Value  |
|---------|---------|
|`{ENDPOINT}`     | The endpoint for authenticating your API request. For example, `myLanguageService.cognitiveservices.azure.com`   |
|`{VERSION}`     | The api version number of the service you want to call. For example, `2022-05-01`   |

### Personally identifiable information (PII) detection

PII detection allows you to identify, categorize, and redact information that could be considered sensitive, such as email addresses, home addresses, IP addresses, names, and protected health information. For example, if the text "email@contoso.com" was included in the query, the entire email address can be identified and redacted.

A PII query will be sent to an endpoint similar to the following, with the task specified as `PiiEntityRecognition`.

```http
/{ENDPOINT}/language/:analyze-text?api-version={VERSION}
```

|Placeholder  |Value  |
|---------|---------|
|`{ENDPOINT}`     | The endpoint for authenticating your API request. For example, `myLanguageService.cognitiveservices.azure.com`   |
|`{VERSION}`     | The api version number of the service you want to call. For example, `2022-05-01`   |

### Key phrase extraction

Key phrase extraction is a feature that quickly pulls the main concepts out of the provided text. For example, given the text "Text Analytics is one of the features in Azure AI Services.", the service would extract *"Azure AI Services"* and *"Text Analytics"*.

A key phrase extraction query will be sent to an endpoint similar to the following, with the task specified as `KeyPhraseExtraction`.

```http
/{ENDPOINT}/language/:analyze-text?api-version={VERSION}
```

|Placeholder  |Value  |
|---------|---------|
|`{ENDPOINT}`     | The endpoint for authenticating your API request. For example, `myLanguageService.cognitiveservices.azure.com`   |
|`{VERSION}`     | The api version number of the service you want to call. For example, `2022-05-01`   |

### Sentiment analysis

Sentiment analysis identifies how positive or negative a string or document is. For example, given the text "Great hotel. Close to plenty of food and attractions we could walk to", the service would identify that as *positive* with a relatively high confidence score.

A sentiment analysis query will be sent to an endpoint similar to the following, with the task specified as `SentimentAnalysis`.

```http
/{ENDPOINT}/language/:analyze-text?api-version={VERSION}
```

|Placeholder  |Value  |
|---------|---------|
|`{ENDPOINT}`     | The endpoint for authenticating your API request. For example, `myLanguageService.cognitiveservices.azure.com`   |
|`{VERSION}`     | The api version number of the service you want to call. For example, `2022-05-01`   |

### Language detection

Language detection takes one or more documents, and identifies the language for each. For example, if the text of one of the documents was "Bonjour", the service would identify that as *French*.

A language detection query will be sent to an endpoint similar to the following, with the task specified as `LanguageDetection`.

```http
/{ENDPOINT}/language/:analyze-text?api-version={VERSION}
```

|Placeholder  |Value  |
|---------|---------|
|`{ENDPOINT}`     | The endpoint for authenticating your API request. For example, `myLanguageService.cognitiveservices.azure.com`   |
|`{VERSION}`     | The api version number of the service you want to call. For example, `2022-05-01`   |

## Learned features

Learned features require you to label data, train, and deploy your model to make it available to use in your application. These features allow you to customize what information is predicted or extracted.

> [!NOTE]
> Quality of data greatly impacts the model's accuracy. Be intentional about what data is used, how well it is tagged or labeled, and how varied the training data is. For details, see [recommendations for labeling data](/azure/cognitive-services/language-service/conversational-language-understanding/how-to/tag-utterances), which includes valuable guidelines for tagging data. Also see the [evaluation metrics](/azure/cognitive-services/language-service/custom-text-classification/concepts/evaluation-metrics) that can assist in learning where your model needs improvement.

### Conversational language understanding (CLU)

CLU is one of the core custom features offered by Azure AI Language. CLU helps users to build custom natural language understanding models to predict overall intent and extract important information from incoming utterances. CLU does require data to be tagged by the user to teach it how to predict intents and entities accurately.

A language detection query will be sent to an endpoint similar to the following, with the task specified as `Conversation`. These custom features require extra parameters in the JSON body, including the `projectName` and `deploymentName` of your model.

```http
/{ENDPOINT}/language/:analyze-conversations?api-version={VERSION}
```

|Placeholder  |Value  |
|---------|---------|
|`{ENDPOINT}`     | The endpoint for authenticating your API request. For example, `myLanguageService.cognitiveservices.azure.com`   |
|`{VERSION}`     | The api version number of the service you want to call. For example, `2022-05-01`   |

### Custom named entity recognition

Custom entity recognition takes custom labeled data and extracts specified entities from unstructured text. For example, if you have various contract documents that you want to extract involved parties from, you can train a model to recognize how to predict them.

A custom entity recognition query will be sent to an endpoint similar to the following, with the task specified as `CustomEntityRecognition`. This custom feature also require extra parameters in the JSON body, including the `projectName` and `deploymentName` of your model.

```http
/{ENDPOINT}/language/analyze-text/jobs?api-version={VERSION}
```

|Placeholder  |Value  |
|---------|---------|
|`{ENDPOINT}`     | The endpoint for authenticating your API request. For example, `myLanguageService.cognitiveservices.azure.com`   |
|`{VERSION}`     | The api version number of the service you want to call. For example, `2022-05-01`   |

### Custom text classification

Custom text classification enables users to classify text or documents as custom defined groups. For example, you can train a model to look at news articles and identify the category they should fall into, such as *News* or *Entertainment*.

A custom text classification query will be sent to an endpoint similar to the following, with the task specified as `CustomMultiLabelClassification` or `CustomSingleLabelClassification` depending on if you need single or multi label classification. This custom feature also require extra parameters in the JSON body, including the `projectName` and `deploymentName` of your model.

```http
/{ENDPOINT}/language/analyze-text/jobs?api-version={VERSION}
```

|Placeholder  |Value  |
|---------|---------|
|`{ENDPOINT}`     | The endpoint for authenticating your API request. For example, `myLanguageService.cognitiveservices.azure.com`   |
|`{VERSION}`     | The api version number of the service you want to call. For example, `2022-05-01`   |

### Question answering

Question answering is a mostly pre-configured feature that provides answers to questions provided as input. The data to answer these questions comes from documents like FAQs or manuals.

For example, say you want to make a virtual chat assistant on your company website to answer common questions. You could use a company FAQ as the input document to create the question and answer pairs. Once deployed, your chat assistant can pass input questions to the service, and get the answers as a result.

The endpoint to query looks similar to the following.

```http
{ENDPOINT}/language/:query-knowledgebases?projectName={PROJECTNAME}&deploymentName={DEPLOYMENTNAME}&api-version={VERSION}
```

|Placeholder  |Value  |
|---------|---------|
|`{ENDPOINT}`     | The endpoint for authenticating your API request. For example, `myLanguageService.cognitiveservices.azure.com`   |
|`{PROJECTNAME}`     | The name of your project where you provided documents as data to answer questions   |
|`{DEPLOYMENTNAME}`     | The name of your deployment |
|`{VERSION}`     | The api version number of the service you want to call. For example, `2022-05-01`   |

For a complete list of capabilities and how to use them, see the Azure AI Language [documentation](/azure/cognitive-services/language-service/overview).
