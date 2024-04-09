Azure AI Language is a cloud-based Natural Language Processing (NLP) service, providing text insights such as: key phrase extraction, entity recognition, personally identifiable information (PII) detection, and more. The service is available to the Azure Database for PostgreSQL flexible server via the `azure_ai` extension, which provides user-defined functions to access the language APIs within SQL.

Key phrase extraction recognizes the key topics, or main concepts, from input text. Use it to summarize a document into topics, rather than prose or sentences.

Entity recognition identifies places, people, quantities, and more. Use it to index documents by entities discussed, or identify form input fields such as address or name from unstructured text.

Personally Identifiable Information (PII) detection identifies and redacts PII from input text. Use it to scrub sensitive information like credit card numbers, social security numbers, phone numbers, and so forth from text.

Without these tools, businesses need to process text by keyword or pattern matching. This is error-prone and requires manual effort to list identifiable topics and patterns. This logic is typically not implemented in SQL, so it must be repeated across client applications introducing further risk.

By deferring the text processing to Azure AI Language, businesses automate gathering insights from text. The language services encapsulate complex natural language processing algorithms, which are maintained and debugged by Azure developers. This enables the business's developers to focus on the insights obtained from text: not the process of obtaining the insights.

## References

* [Azure Database for PostgreSQL flexible server Azure AI Extension](/azure/postgresql/flexible-server/generative-ai-azure-overview)
* [What is key phrase extraction in Azure AI Language?](/azure/ai-services/language-service/key-phrase-extraction/overview)
* [What is Named Entity Recognition (NER) in Azure AI Language?](/azure/ai-services/language-service/named-entity-recognition/overview)
* [What is Personally Identifiable Information (PII) detection in Azure AI Language?](/azure/ai-services/language-service/personally-identifiable-information/overview)
* [Transparency Note for Azure AI Language](/legal/cognitive-services/language-service/transparency-note)
