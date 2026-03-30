Azure Content Understanding is a Foundry Tool that uses generative AI to process and extract insights from many types of content, including documents, images, videos, and audio. It transforms unstructured data into structured, actionable output that you can integrate into automation and analytical workflows.

## Why use Content Understanding?

Content Understanding accelerates time to value by enabling straight-through processing of unstructured data. Key benefits include:

- **Simplified workflows**: Standardizes extraction and classification of content from various content types into a unified process
- **Easy field extraction**: Define a schema to extract, classify, or generate field values without complex prompt engineering
- **Enhanced accuracy**: Uses multiple AI models to analyze and cross-validate information simultaneously
- **Confidence scores and grounding**: Ensures accuracy of extracted values while minimizing the cost of human review
- **Content classification**: Categorize document types to streamline processing and route content to appropriate analyzers

## Content Understanding components

The Content Understanding framework processes unstructured content through multiple stages:

| Component | Description |
|-----------|-------------|
| **Inputs** | Source content including documents, images, video, and audio |
| **Analyzer** | Defines how content is processed, including extraction settings and field schema |
| **Content extraction** | Transforms unstructured input into normalized text and metadata using OCR, speech transcription, and layout detection |
| **Field extraction** | Generates structured key-value pairs based on your defined schema |
| **Confidence scores** | Provides reliability estimates from 0 to 1 for each extracted field value |
| **Grounding** | Identifies specific regions in content where each value was extracted |
| **Structured output** | Final result as Markdown for search scenarios or JSON for automation workflows |

## Analyzers

Analyzers are the core component that defines how your content is processed. Content Understanding offers two types:

- **Prebuilt analyzers**: Ready-to-use analyzers designed for common scenarios like invoice processing, receipt extraction, and call center analytics
- **Custom analyzers**: Tailored analyzers you create with your own field schema for specific business needs

When you create an analyzer, you configure:

- The base analyzer type (document, image, audio, or video)
- The AI models to use for processing
- The field schema that defines what data to extract
- Options like confidence scoring and content segmentation

## Use cases

Content Understanding supports many business scenarios:

| Use case | Description |
|----------|-------------|
| **Intelligent document processing** | Convert unstructured documents into structured data for invoice processing, contract analysis, and claims management |
| **Search and RAG** | Ingest multimodal content into search indexes with figure descriptions and layout analysis |
| **Agentic applications** | Transform messy file inputs into predictable, standardized inputs for AI agents |
| **Analytics and reporting** | Extract field outputs to gain insights and make informed decisions |

## Content restrictions

Content Understanding includes built-in Responsible AI protections. The service integrates Azure AI Content Safety to detect and prevent harmful content. When processing content, be aware of these guidelines:

- Content is filtered for harmful material including violence, hate speech, and exploitation
- Face description capabilities can identify facial attributes in video and image content
- Biometric data processing requires appropriate notice and consent from data subjects

With Content Understanding, you can build solutions that extract meaningful insights from diverse content types while maintaining data quality and compliance.
