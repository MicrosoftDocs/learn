In Azure Cognitive Search, a *skillset* defines an enrichment pipeline that progressively constructs a JSON document by applying a sequence of AI skills that extract fields from documents in a data source. The fields extracted by each skill can be used as the input for a subsequent skill in the pipeline, enabling incremental data enrichment during the indexing process.

Azure Cognitive Search includes a comprehensive collection of built-in skills that are based on Azure Cognitive Services for text and image analysis. You'll use some of these skills to enrich the index for the Margie's Travel search solution.

Choose the language you want to use at the top of this page, and follow the steps to create a skillset.

:::zone pivot="csharp"

1. In the **C-Sharp/create-enriched-index** folder, open the **Program.cs** file.
2. Review the code in the **CreateSkillset** function. There's a lot of code in this function, which defines a list of skills, and then creates a skillset that includes those skills. The skills defined by the code are:
    - A **language detection** skill that identifies the language in which a document is written (for example **en** for English, or **fr** for French.)
    - An **image analysis** skill that analyzes the images in the document and extracts insights from them. The image analysis skill can be used to return a wide range of information from images, including recognized objects in the image, locations and analysis of faces detected in the image, brand logos in the image, and other insights. In this case, the skill is used to extract a *description* of the image (which as you'll see later, consists of a set of suggested *tags* and a set of suggested *captions* for the image.)
    - An **OCR** skill that uses optical character recognition (OCR) to extract areas of text from the images in the document.
    - A **merge** skill that combines the OCR text extracted from images with the original text content in the document.
    - A **sentiment** skill that calculates a sentiment score for the text in the document. Values close to 0 indicate a negative sentiment, while values close to 1 indicate a positive sentiment.
    - An **entity recognition** skill that identifies and extracts entities in the document contents. In this case, the skill specifically extracts locations and URLs that are mentioned in the documents.
    - A **key phrase extraction** skill that extracts a list of key phrases in each document based on an analysis of the text.
3. Observe that for each skill, the code defines the required input and output parameters, and in some cases some additional configuration parameters to specify the data values to be extracted. Each skill runs in a specified *context*, which defines a location within an enriched document structure. The skills take their inputs from locations within the document, and write their outputs as new document fields within their context. In this way, the outputs from one skill are available within the document as inputs for subsequent skills. For example, the **languageCode** output from the language detection skill is used as an input for the sentiment, entity recognition, and key phrase extraction skills later in the pipeline.
4. Observe that after the list of skills has been created, the code creates a skillset, which includes a reference to your Cognitive Services account. Azure Cognitive Search uses Cognitive Services to implement the skills. The key for your Cognitive Services account will be retrieved from the **appsettings.json** file you updated previously.
5. In the **Terminal** pane, select the bash terminal for the **create-enriched-index** folder. If you have closed this terminal, right-click (Ctrl+click if using a Mac) the **C-Sharp/create-enriched-index** folder and select **Open in Integrated Terminal**.
6. In the terminal for the **create-enriched-index** folder, enter the following command:
    ```bash
    dotnet run
    ```
7. When prompted, press **2** to create a skillset. Then wait while the program creates the skillset.
8. When the prompt is redisplayed, press **q** to quit the program.
9. Open your search service in the [Azure portal](https://portal.azure.com?portal=true) and view its **Skillsets** tab to confirm that the skillset has been created.

:::zone-end

:::zone pivot="python"

1. In the **Python/create-enriched-index** folder, open the **skillset.json** file. This contains the JSON definition of a skillset.
2. Review the skillset definition. It includes the following skills:
    - A **language detection** skill that identifies the language in which a document is written (for example **en** for English, or **fr** for French.)
    - An **image analysis** skill that analyzes the images in the document and extracts insights from them. The image analysis skill can be used to return a wide range of information from images, including recognized objects in the image, locations and analysis of faces detected in the image, brand logos in the image, and other insights. In this case, the skill is used to extract a *description* of the image (which as you'll see later, consists of a set of suggested *tags* and a set of suggested *captions* for the image.)
    - An **OCR** skill that uses optical character recognition (OCR) to extract areas of text from the images in the document.
    - A **merge** skill that combines the OCR text extracted from images with the original text content in the document.
    - A **sentiment** skill that calculates a sentiment score for the text in the document. Values close to 0 indicate a negative sentiment, while values close to 1 indicate a positive sentiment.
    - An **entity recognition** skill that identifies and extracts entities in the document contents. In this case, the skill specifically extracts locations and URLs that are mentioned in the documents.
    - A **key phrase extraction** skill that extracts a list of key phrases in each document based on an analysis of the text.
3. Observe that each skill runs in a specified *context*, which defines a location within an enriched document structure. The skills take their inputs from locations within the document, and write their outputs as new document fields within their context. In this way, the outputs from one skill are available within the document as inputs for subsequent skills. For example, the **languageCode** output from the language detection skill is used as an input for the sentiment, entity recognition, and key phrase extraction skills later in the pipeline.
4. Observe that the skillset also includes a reference to your Cognitive Services account. Azure Cognitive Search uses Cognitive Services to implement the skills. The key for your Cognitive Services account will be inserted into the JSON from the environment variable you defined previously.
5. In the **Terminal** pane, select the bash terminal for the **create-enriched-index** folder. If you have closed this terminal, right-click (Ctrl+click if using a Mac) the **Python/create-enriched-index** folder and select **Open in Integrated Terminal**.
6. In the terminal for the **create-enriched-index** folder, enter the following command:
    ```bash
    python3 submit-rest.py 'PUT' 'skillsets/margies-skillset-py' 'skillset.json'
    ```
7. Wait while Python runs the **submit-rest&#46;py** script to create the skillset.
8. Review the JSON response that is returned from the REST interface.
9. Open your search service in the [Azure portal](https://portal.azure.com?portal=true) and view its **Skillsets** tab to confirm that the skillset has been created.

:::zone-end

> [!NOTE]
> For more information about the full set of available built-in skills, see the [Built-in cognitive skills for text and image processing during indexing (Azure Cognitive Search)](https://docs.microsoft.com/azure/search/cognitive-search-predefined-skills) in the Azure Cognitive Search documentation.
