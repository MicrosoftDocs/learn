Content Understanding can analyze images to extract structured data, identify visual elements, and generate descriptions. You can use prebuilt analyzers for common scenarios or create custom analyzers tailored to your specific needs.

## Supported image formats

Content Understanding supports the following image input types:

| Format | Description |
|--------|-------------|
| **JPEG** | Standard photographic images |
| **PNG** | Images with transparency support |
| **BMP** | Bitmap images |
| **TIFF** | High-quality scanned documents |
| **HEIF** | High-efficiency image format |
| **PDF** | Single or multi-page documents with embedded images |

## Prebuilt image analyzers

Content Understanding includes prebuilt analyzers optimized for common image analysis scenarios:

- **prebuilt-image**: General-purpose image analysis with content extraction and figure description
- **prebuilt-receipt**: Extract vendor names, items, totals, and dates from receipt images
- **prebuilt-invoice**: Extract invoice details including line items, amounts, and vendor information
- **prebuilt-idDocument**: Extract information from identity documents like driver's licenses and passports

## Define a field schema for images

To extract specific information from images, define a field schema that describes the data you want. Each field can use one of three extraction methods:

| Method | Description | Example |
|--------|-------------|---------|
| **extract** | Pull values directly as they appear in the image | Extract text from a label or sign |
| **classify** | Categorize content from predefined options | Classify image as "damaged" or "undamaged" |
| **generate** | Create values based on image analysis | Generate a description of the scene |

Here's an example schema for analyzing product images:

```json
{
  "description": "Product image analyzer",
  "baseAnalyzerId": "prebuilt-image",
  "fieldSchema": {
    "fields": {
      "ProductName": {
        "type": "string",
        "method": "extract",
        "description": "Name of the product visible in the image"
      },
      "Condition": {
        "type": "string",
        "method": "classify",
        "description": "Condition of the product",
        "enum": ["new", "used", "damaged"]
      },
      "Description": {
        "type": "string",
        "method": "generate",
        "description": "Brief description of what the image shows"
      }
    }
  }
}
```

## Analyze an image

To analyze an image using Content Understanding, you can use the Python SDK, which you can install using `pip` like this:

```bash
pip install azure-ai-contentunderstanding
```

To submit a request to the analyze endpoint with your analyzer ID and the image URL or file, you can use code similar to this example:

```python
from azure.ai.contentunderstanding import ContentUnderstandingClient
from azure.ai.contentunderstanding.models import AnalysisInput, AnalysisResult
from azure.core.credentials import AzureKeyCredential # for key-based authentication
from azure.identity import DefaultAzureCredential # for Entra ID authentication

# Get a client
credential = AzureKeyCredential(key)
client = ContentUnderstandingClient(endpoint={FOUNDRY_ENDPOINT},
                                    credential={KEY_OR_IDENTITY},
                                    api_version="2025-11-01")

# Analyze an image file
with open("my_image.png", "rb") as f:
            file_bytes = f.read()

try:
    poller = client.begin_analyze(
        analyzer_id={ANALYSER_ID},
        inputs=[AnalysisInput(data=file_bytes)],
    )
    # Get results asynchronously from poller
    result: AnalysisResult = poller.result()

    # Display results
    result_str = json.dumps(result.as_dict(), indent=2)
    ret_lines = result_str.splitlines()

except Exception as ex:
    print(f"[Unexpected Error]: {ex}")
    sys.exit(1)
```

When analysis completes, the results include the extracted content:

- **markdown**: A text representation of the image content, useful for search and RAG scenarios
- **fields**: Extracted field values matching your schema, each with a confidence score
- **source**: Grounding information showing where in the image each value was found

Example response for a product image:

```json
{
  "contents": [
    {
      "markdown": "Product label showing 'Contoso Widget Pro' with serial number...",
      "fields": {
        "ProductName": {
          "type": "string",
          "valueString": "Contoso Widget Pro",
          "confidence": 0.95,
          "source": "D(1,100,50,300,50,300,80,100,80)"
        },
        "Condition": {
          "type": "string",
          "valueString": "new",
          "confidence": 0.89
        },
        "Description": {
          "type": "string",
          "valueString": "A silver electronic device in retail packaging with product label visible"
        }
      }
    }
  ]
}
```

## Use confidence scores

Each extracted field includes a confidence score from 0 to 1:

- **High confidence (0.9+)**: Value can be trusted for automated processing
- **Medium confidence (0.7-0.9)**: Consider human review for critical applications
- **Low confidence (<0.7)**: Recommend manual verification

Use confidence scores to build automation workflows that route low-confidence extractions to human reviewers while processing high-confidence results automatically.

## Tips for better image analysis

- **Image quality matters**: Higher resolution images produce more accurate extractions
- **Lighting and contrast**: Ensure text and visual elements are clearly visible
- **Single focus**: Images with one clear subject yield better results than cluttered scenes
- **Consistent orientation**: Upright images are processed more reliably than rotated ones

Content Understanding's image analysis capabilities enable you to transform visual content into structured, actionable data for document processing, inventory management, quality inspection, and many other business scenarios.
