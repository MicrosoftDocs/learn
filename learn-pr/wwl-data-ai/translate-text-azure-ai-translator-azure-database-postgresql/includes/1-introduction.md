

The `azure_ai` Extension for Azure Database for PostgreSQL includes access to the Azure AI Translator, a service that detects the language of text and translates it into other languages. With it, you can translate text between [more than 100 languages](/azure/ai-services/translator/language-support#translation).

## Azure AI Services

Azure AI services are a set of advanced cloud-based tools and technologies created by Microsoft to enable developers to build intelligent apps and systems without requiring specialized AI or data science skills. These services allow the incorporation of powerful AI capabilities into a wide range of applications, such as natural language processing, machine learning, computer vision, and more. Using Azure AI services, developers can create innovative solutions that enhance user experiences, automate workflows, and improve business operations across various industries.

## Azure AI Translator

The Azure AI Translator service is a cloud-based service that uses neural machine translation technology to enable quick and accurate source-to-target text translation in real-time across [all supported languages](/azure/ai-services/translator/language-support).

## Scenario: Translating rental property descriptions

Suppose you're the lead developer for Margie's Travel. Your company is embarking on a plan to market short-term rental properties for an international clientele. Your rental property descriptions are all in English, and you would like to translate these listings into various languages. You're hosting the data in an Azure Database for PostgreSQL flexible server and would like to take advantage of other Azure services to perform translation.

## Learning objectives

This module shows how to use the Azure AI Translator service with Azure Database for PostgreSQL - Flexible Server. In this module, you will:

- Install the `azure_ai` Extension on an existing Azure Database for PostgreSQL flexible server instance.
- Load rental listing data into a table.
- Provision an Azure AI Translator service.
- Translate rental listings into multiple languages.
- Store the translations in a table.

By the end of this module, you're able to use the `azure_ai` Extension to translate text and store the results in an Azure Database for PostgreSQL flexible server.
