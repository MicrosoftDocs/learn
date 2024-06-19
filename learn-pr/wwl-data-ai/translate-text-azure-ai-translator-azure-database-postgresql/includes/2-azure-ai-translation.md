

## What is the Azure AI Translator?

The Azure AI Translator Service is a cloud-based neural machine translation service that is part of the [Azure AI services](/azure/ai-services/what-are-ai-services) family and can be used with any operating system. Translator powers many Microsoft products and services that thousands of businesses worldwide use for language translation and other language-related operations. In this overview, you learn how Translator can enable you to build intelligent, multi-language solutions for your applications across all supported languages.

## Supported languages

The Azure AI Translator service supports translating text and documents between [more than 100 languages and dialects](/azure/ai-services/translator/language-support) using the cloud-based REST API. The service also supports translating scanned PDF documents and transliteration between languages using different scripts.

## Document translation with the Azure AI Translator

Document Translation is a cloud-based machine translation feature of the [Azure AI Translator](/azure/ai-services/translator/translator-overview) service. You can translate multiple and complex documents across all supported languages and dialects while preserving the original document structure and data format. The Document translation API supports two translation operations:

- Asynchronous batch document translation supports asynchronous processing of multiple documents and large files. The batch translation process requires an Azure Blob storage account with containers for your source and translated documents.
- Synchronous document translation supports synchronous processing of single file translations. The file translation process doesn't require an Azure Blob storage account. The final response contains the translated document and is returned directly to the calling client.

For the upcoming exercise, you use synchronous document translation.
