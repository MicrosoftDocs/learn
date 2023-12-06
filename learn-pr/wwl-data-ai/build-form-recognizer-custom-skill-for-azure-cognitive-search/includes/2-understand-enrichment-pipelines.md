If you integrate Cognitive Search with an Azure AI Document Intelligence solution, you can enrich your index with fields that your Azure AI Document Intelligence models are trained to extract.

In your polling company, users can submit queries to your search service, which is built on Azure AI Services. However, users need to be able to locate a completed polling form by searching for a voter ID. You've already trained an Azure AI Document Intelligence model to extract the voter ID from various polling forms. Now you want to ensure that the voter ID is included in your Cognitive Search index so users can locate the forms they need.

In this unit, you'll learn how to integrate an Azure AI Document Intelligence model by calling it from a Cognitive Search custom skill.

## Indexing content in Cognitive Search

In a search service, a corpus of content is indexed to determine the words it contains and the documents that contain them. When users search for a word, their query is checked against the index to determine the documents that contain that word. In this way, relevant documents can be returned to the user much more quickly than if each document was searched for the word.

Azure Cognitive Search is a search service hosted in Azure that can index content on your premises or in a cloud location.

:::image type="content" source="../media/2-cognitive-search-architecture.png" alt-text="Diagram showing the conceptual architecture of the Azure Cognitive search service.":::

During the indexing process, Cognitive Search crawls your content, processes it, and creates a list of words that will be added to the index, together with their location. There are five stages to the indexing process:

1. **Document Cracking.** In document cracking, the indexer opens the content files and extracts their content.
1. **Field Mappings.** Fields such as titles, names, dates, and more are extracted from the content. You can use field mappings to control how they're stored in the index.
1. **Skillset Execution.** In the optional skillset execution stage, custom AI processing is done on the content to enrich the final index.
1. **Output field mappings.** If you're using a custom skillset, its output is mapped to index fields in this stage.
1. **Push to index.** The results of the indexing process are stored in the index in Azure Cognitive Search.

## What is a Cognitive Search skillset?

You can create a customized list of skills that will be executed as a skillset in the third stage of indexing. Each skill is a call to an AI process that enriches the index. For example, an AI skill might translate words into different languages or extract words from a binary image.

Cognitive Search has a range of built-in skills, that you can include in your pipeline. Built-in skills use pre-trained AI models, provided by Microsoft. These include:

- **Key phrase extraction.** Detects important phrases in text based on the placement of terms, linguistic rules, and proximity to other terms.
- **Language detection.** Detects the predominantly used language in text.
- **Merge.** Merges text from several fields into a single field.
- **Sentiment.** Detects sentiments such as **positive**, **negative**, and **neutral** in text.
- **Translation.** Translates text from the original language into another to create a multilingual index.
- **Image analysis.** Detects the contents of an image and generates a description.
- **Optical character recognition.** Recognizes printed and handwritten text in an image.

> [!NOTE]
> For a complete list of built-in skills, see the link in the **Learn more** section below.

To create a custom skillset, you must call the **Create Skillset REST API**, and send it the appropriate JSON definition code. The call to the API looks like this:

```http
PUT https://[service name].search.windows.net/skillsets/[skillset name]?api-version=[api version]
  Content-Type: application/json  
  api-key: [admin key]
```

In the above call:

- [service name] is the name of your Cognitive Search service in Azure.
- [skillset name] is a name for the skillset you're creating.
- [api version] is the version of the Search REST API.
- [admin key] is the API key for the Search service. You can obtain this key from the Azure portal.

The JSON code that defines the skillset looks like this:

```json
{   
  "name" : "A name for the skillset",  
  "description" : "Optionally, add a descriptive text.",   
  "skills" : [

    ],
  "cognitiveServices": 
      {
        "@odata.type": "#Microsoft.Azure.Search.CognitiveServicesByKey",
        "key": "<admin key>"
      },
  "knowledgeStore": { ... },
  "encryptionKey": { }
}
```

In the above JSON code;

- **cognitiveservices** is required if you're using billable Azure AI Services APIs in your skillset. Provide the API key for your Azure AI Services multiservice resource.
- **knowledgeStore** specifies an Azure Storage Account where the output from skills can be stored
- **encryptionKey** specifies keys from the Azure Key Vault that will be used to encrypt sensitive content in the pipeline.

The **skills** section defines one or more built-in or custom skills that will analyze the content. For example:

```json
"skills":[
  {
    "@odata.type": "#Microsoft.Skills.Text.V3.EntityRecognitionSkill",
    "name": "Entity recognition",
    "context": "/document",
    "categories": [ "Organization" ],
    "inputs": [
      {
        "name": "text",
        "source": "/document/content"
      }
    ],
    "outputs": [
      {
        "name": "organizations",
        "targetName": "orgs"
      }
  },
  {
      "@odata.type": "#Microsoft.Skills.Vision.ImageAnalysisSkill",
      "name": "Image analysis",
      "context": "/document/normalized_images/*",
      "visualFeatures": [
          "brands"
      ],
      "inputs": [
          {
              "name": "image",
              "source": "/document/normalized_images/*"
          }
      ],
      "outputs": [
          {
              "name": "brands"
          }
      ]
  }
]
```

In this example, there are two built-in skills in the skillset: An entity recognition skill that detects organization names in text and an image analysis skill that detects brand logos in image files.

## What is a custom skill?

Custom skills can be used for two reasons:

- The list of built-in skills doesn't include the type of AI enrichment you need.
- You want to train your own model to analyze the data.

There are two types of custom skill that you can create:

- **Azure Machine Learning (AML) custom skills.** You can use this custom skill type to enrich your index by calling an AML model.
- **Custom Web API skills.** You can use this custom skill type to enrich your index by calling a web service. Such web services can include Azure applied AI services, such as Azure AI Document Intelligence.

If you're writing a web service to integrate into a Cognitive Search indexing pipeline, you must conform to certain requirements. For example:

- The service must accept a JSON payload as an input and return a second JSON payload as its results.
- The Output JSON should have a top-level entity named **values** that contains an array of objects.
- The number of objects sent to the service should match the number of objects in the **values** entity.
- Each object in **values** should include a unique **recordId** property, a **data** property with the returned information, a warnings property, and an errors property.

## Integrate Cognitive Search and Azure AI Document Intelligence

If you've developed an Azure AI Document Intelligence solution, you may be using it to accept scanned or photographed forms or documents from users, perhaps from an app on their mobile device. Azure AI Document Intelligence can use either a built-in model or a custom model to analyze the content of these images and return text, structural information, languages used, key-value pairs, and other data.

That's the kind of data that may be useful in a Cognitive Search index. For example, if the content that you index includes scanned sales invoices, Azure AI Document Intelligence can identify field such as currency amounts, retailer names, and tax information by using its prebuilt **Invoice** model. When users search for a retailer, you'd like them to receive a link to invoices from that retailer in their results.

To integrate Azure AI Document Intelligence into the Cognitive Search indexing pipeline, you must:

- Create an Azure AI Document Intelligence resource in your Azure subscription.
- Configure one or more models in Azure AI Document Intelligence. You can either select prebuilt models, such as **Invoice** or **Business Card** or train your own model for unusual or unique form types.
- Develop and deploy a web service that can call your Azure AI Document Intelligence resource. In this module, you'll use an Azure Function to host this service.
- Add a custom web API skill, with the correct configuration to the Cognitive Search skillset. This skill should be configured to send requests to the web service.

In the next units, you'll learn how to complete this integration.

## Learn more

- [What is Azure Cognitive Search?](/azure/search/search-what-is-azure-search)
- [Attach an Azure AI Services resource to a skillset in Azure Cognitive Search](/azure/search/cognitive-search-attach-cognitive-services)
- [Built-in skills for text and image processing during indexing (Azure Cognitive Search)](/azure/search/cognitive-search-predefined-skills)
- [Custom Web API skill in an Azure Cognitive Search enrichment pipeline](/azure/search/cognitive-search-custom-skill-web-api)
- [Example: Create an Azure AI Document Intelligence custom skill](/azure/search/cognitive-search-custom-skill-form)
