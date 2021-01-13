To create a knowledge store, you must define the skills that extract enriched data and the projections in which it is to be stored in a *skillset*.

Choose the language you want to use at the top of this page, and follow the steps to create a skillset.

:::zone pivot="csharp"

At the time of writing, the .NET SDK for Azure Cognitive Search does not support creating skillsets that include a knowledge store definition. However, you can create a skillset by submitting its JSON definition to the Azure Cognitive Search REST interface. In this task, you'll use C# to create an HTTP request to the REST interface.

1. In the **C-Sharp/create-knowledge-store** folder, open the **skillset.json** file. This file contains the JSON definition of a skillset.
2. Review the skillset definition. It includes the following skills:
    - A **language detection** skill that identifies the language in which a document is written.
    - An **image analysis** skill that analyzes the images in the document and extracts insights from them.
    - An **OCR** skill that uses optical character recognition (OCR) to extract areas of text from the images in the document.
    - A **merge** skill that combines the OCR text extracted from images with the original text content in the document.
    - A **sentiment** skill that calculates a sentiment score for the text in the document.
    - An **entity recognition** skill that identifies and extracts locations and URLs that are mentioned in the documents.
    - A **key phrase extraction** skill that extracts a list of key phrases in each document based on an analysis of the text.
    - A **shaper** skill that defines a JSON structure for the enriched data. This object definition will be used for the *projections* that the pipeline will persist on the knowledge store for each document processed by the indexer.
3. Observe that the skillset also includes a **knowledgeStore** definition, which includes a connection string for the Azure Storage account where the knowledge store is to be created, and a collection of **projections**. This skillset includes three *projection groups*:
    - A group containing an *object* projection based on the **knowledge_projection** output of the shaper skill in the skillset.
    - A group containing a *file* projection based on the **normalized_images** collection of image data extracted from the documents.
    - A group containing the following *table* projections:
        - **KeyPhrases**: Contains an automatically generated key column and a **keyPhrase** column mapped to the **knowledge_projection/key_phrases/** collection output of the shaper skill.
        - **Locations**: Contains an automatically generated key column and a **location** column mapped to the **knowledge_projection/key_phrases/** collection output of the shaper skill.
        - **ImageTags**: Contains an automatically generated key column and a **tag** column mapped to the **knowledge_projection/image_tags/** collection output of the shaper skill.
        - **Docs**: Contains an automatically generated key column and all of the **knowledge_projection** output values from the shaper skill that are not already assigned to a table.
4. In the **C-Sharp/create-knowledge-store** folder, open the **Program.cs** file and review the **CreateSkillset** function. This function:
    - Reads the JSON skillset definition.
    - Updates the skillset definition with your cognitive services key and blob store connection string.
    - Submits an HTTP PUT request to the REST service that creates a skillset named **margies-skillset-cs**.
5. In the **Terminal** pane, select the bash terminal for the **create-knowledge-store** folder. If you have closed this terminal, right-click (Ctrl+click if using a Mac) the **C-Sharp/create-knowledge-store** folder and select **Open in Integrated Terminal**.
6. In the terminal for the **create-knowledge-store** folder, enter the following command:
    ```bash
    dotnet run
    ```
7. When prompted, press **2** to create a skillset. Then wait while the program creates the skillset.
8. When the prompt is redisplayed, press **q** to quit the program.
9. Open your search service in the [Azure portal](https://portal.azure.com?portal=true) and view its **Skillsets** tab to confirm that the skillset has been created.

:::zone-end

:::zone pivot="python"

1. In the **Python/create-knowledge-store** folder, open the **skillset.json** file. This file contains the JSON definition of a skillset.
2. Review the skillset definition. It includes the following skills:
    - A **language detection** skill that identifies the language in which a document is written.
    - An **image analysis** skill that analyzes the images in the document and extracts insights from them.
    - An **OCR** skill that uses optical character recognition (OCR) to extract areas of text from the images in the document.
    - A **merge** skill that combines the OCR text extracted from images with the original text content in the document.
    - A **sentiment** skill that calculates a sentiment score for the text in the document.
    - An **entity recognition** skill that identifies and extracts locations and URLs that are mentioned in the documents.
    - A **key phrase extraction** skill that extracts a list of key phrases in each document based on an analysis of the text.
    - A **shaper** skill that defines a JSON structure for the enriched data. This object definition will be used for the *projections* that the pipeline will persist on the knowledge store for each document processed by the indexer.
3. Observe that the skillset also includes a **knowledgeStore** definition, which includes a connection string for the Azure Storage account where the knowledge store is to be created, and a collection of **projections**. This skillset includes three *projection groups*:
    - A group containing an *object* projection based on the **knowledge_projection** output of the shaper skill in the skillset.
    - A group containing a *file* projection based on the **normalized_images** collection of image data extracted from the documents.
    - A group containing the following *table* projections:
        - **KeyPhrases**: Contains an automatically generated key column and a **keyPhrase** column mapped to the **knowledge_projection/key_phrases/** collection output of the shaper skill.
        - **Locations**: Contains an automatically generated key column and a **location** column mapped to the **knowledge_projection/key_phrases/** collection output of the shaper skill.
        - **ImageTags**: Contains an automatically generated key column and a **tag** column mapped to the **knowledge_projection/image_tags/** collection output of the shaper skill.
        - **Docs**: Contains an automatically generated key column and all of the **knowledge_projection** output values from the shaper skill that are not already assigned to a table.
4. In the **Terminal** pane, select the bash terminal for the **create-knowledge-store** folder. If you have closed this terminal, right-click (Ctrl+click if using a Mac) the **Python/create-knowledge-store** folder and select **Open in Integrated Terminal**.
5. In the terminal for the **create-knowledge-store** folder, enter the following command:
    ```bash
    python3 submit-rest.py 'PUT' 'skillsets/margies-skillset-py' 'skillset.json'
    ```
6. Wait while Python runs the **submit-rest&#46;py** script to create the skillset.
7. Review the JSON response that is returned from the REST interface.
8. Open your search service in the [Azure portal](https://portal.azure.com?portal=true) and view its **Skillsets** tab to confirm that the skillset has been created.

:::zone-end

> [!NOTE]
> To learn more about the **shaper** skill, see [Shaper cognitive skill](https://docs.microsoft.com/azure/search/cognitive-search-skill-shaper) in the Azure Cognitive Search documentation.
>
> To learn more about knowledge stores and projections, see [Knowledge store in Azure Cognitive Search](https://docs.microsoft.com/azure/search/knowledge-store-concept-intro) and [Knowledge store "projections" in Azure Cognitive Search](https://docs.microsoft.com/azure/search/knowledge-store-projection-overview).
