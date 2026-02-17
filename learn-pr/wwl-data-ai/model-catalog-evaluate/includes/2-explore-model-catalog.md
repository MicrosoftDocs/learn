The model catalog in Microsoft Foundry portal serves as your central hub for discovering and comparing AI models. With over 1,900 models available from various providers, you need effective ways to filter and find models that match your specific requirements.

## Access the model catalog

You access the model catalog from the Microsoft Foundry portal at [ai.azure.com](https://ai.azure.com). After signing in and selecting your project, choose **Discover** from the top navigation. The catalog displays model cards showing key information about each model, including the provider, capabilities, and deployment options.

:::image type="content" source="../media/model-catalog.png" alt-text="Screenshot of the model catalog in Microsoft Foundry portal.":::

## Filter models by key attributes

The model catalog provides several filters to help you narrow your search:

**Collection** filters let you browse models by provider, such as Azure OpenAI, Meta, Mistral, Cohere, or Hugging Face. This helps when you have preferences or requirements for specific model families.

**Industry** filters show models trained on industry-specific datasets. These specialized models often outperform general-purpose models in their respective domains.

**Capabilities** filters highlight unique model features. You can filter for reasoning capabilities (complex problem-solving), tool calling (API and function integration), or multimodal processing (text, images, audio).

**Inference tasks** and **Fine-tune tasks** filters let you find models suited for specific activities like text generation, summarization, translation, or entity extraction.

## Understand model types

As you explore the catalog, you encounter different categories of models designed for various use cases.

### Large Language Models and Small Language Models

**Large Language Models (LLMs)** like GPT-4, Mistral Large, and Llama 3 70B are powerful models designed for tasks requiring deep reasoning, complex content generation, and extensive context understanding. These models excel at sophisticated applications but require more computational resources.

**Small Language Models (SLMs)** like Phi-3, Mistral OSS models, and Llama 3 8B offer efficiency and cost-effectiveness while handling common natural language processing tasks. They're ideal for scenarios where speed and cost matter more than handling the most complex reasoning tasks. SLMs can run on lower-end hardware or edge devices.

### Chat completion and reasoning models

Most language models in the catalog are **chat completion** models designed to generate coherent, contextually appropriate text responses. These models power conversational interfaces and content generation applications.

For scenarios requiring higher performance in complex tasks like mathematics, coding, science, strategy, and logistics, **reasoning models** like Claude Opus 4.6 provide enhanced problem-solving capabilities. These models can break down complex problems and show their reasoning process.

### Multimodal models

Beyond text-only processing, **multimodal models** like GPT-4o and Phi-3-vision can handle multiple data types including images, audio, and text. Use these models when your application needs to analyze visual content, such as document understanding, image description, or chart explanation.

### Specialized models

The catalog also includes task-specific models:

**Image generation models** like DALL·E 3 create visual content from text descriptions. Use these for generating marketing materials, illustrations, or design mockups.

**Embedding models** like Ada and Cohere convert text into numerical representations. These models enable semantic search, recommendation systems, and Retrieval Augmented Generation (RAG) scenarios where you need to find relevant information based on meaning rather than exact keyword matches.

### Regional and domain-specific models

Some models are optimized for specific languages, regions, or industries. When you need specialized performance in a particular domain or language, these models often outperform general-purpose alternatives. Examples include models trained on medical literature, legal documents, or specific language corpora.

## Use the search and compare features

Beyond filters, the model catalog offers search functionality to find models by name or keywords. You can open multiple model cards to compare their specifications, benchmarks, and capabilities side by side. This comparison helps you make informed decisions about which model best fits your use case, budget, and performance requirements.

When you identify promising candidates, you can view detailed benchmark results, test models in the playground, or proceed directly to deployment. The structured approach of filtering, comparing, and testing helps ensure you select the right model for your generative AI application.
