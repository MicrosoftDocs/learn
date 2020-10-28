In the Margie's Travel scenario, the source data consists of unstructured documents in Azure Storage, so you must create a data source for the blob container where the documents are stored.

Choose the language you want to use at the top of this page, and follow the steps to create a data source.

> [!NOTE]
> The exercises in this module assume you will use the same language for each task to incrementally build a search solution. If you wish, you can repeat each task in both languages, but doing so will create two search solutions - you can't use a mix of language-specific instructions to create a single solution.

:::zone pivot="csharp"

Azure Cognitive Search provides a software development kit (SDK) for Microsoft .NET, which you can use to write C# code that works with your search resources.

1. In  Visual Studio Code, expand the **02-Create-an-enrichment-pipeline** folder and the **C-Sharp** folder it contains.
2. Expand the **create-enriched-index** folder and open the **appsettings.json** file. This file contains configuration values for your C# code.
3. Modify the following values in the **appsettings.json** file to reflect your Azure resources, and then save the updated file:
    - **SearchServiceName**: Your Azure Cognitive Search service name (<u>without</u> the .*search&#46;windows&#46;net* suffix)
    - **SearchServiceAdminApiKey**: Your Azure Cognitive Search ***admin*** key
    - **CognitiveServicesApiKey**: Your Azure Cognitive Services key
    - **AzureBlobConnectionString**: Your Azure Storage blob container connection string.

    *Ignore the **AzureFunctionUri** setting for now - you'll update this setting later!*

4. Open the **Program.cs** file, and view the code it contains. The **Main** function:
    - Gets the configuration settings from the **appsettings.json** file.
    - Creates a **SearchServiceClient** object for your Azure Cognitive Search service.
    - Prompts the user for input, calling the appropriate functions to create Azure Cognitive Search components.
5. View the **CreateOrUpdateDataSource** function, which creates a data source named **margies-docs-cs** that references the Azure Storage blob container where the PDF documents are stored.
6. Right-click (Ctrl+click if using a Mac) the **C-Sharp/create-enriched-index** folder and select **Open in Integrated Terminal**. This will open a new bash terminal in this folder.
7. In the terminal for the **create-enriched-index** folder, enter the following command:
    ```bash
    dotnet run
    ```
8. When prompted, press **1** to create a data source. Then wait while the program creates the data source.
9. When the prompt is redisplayed, press **q** to quit the program.
10. Open your search service in the [Azure portal](https://portal.azure.com?portal=true) and view its **Data sources** tab to confirm that the data source has been created.

:::zone-end

:::zone pivot="python"

There is no Python SDK for creating Azure Cognitive Search objects, but you can use Python to submit requests to the Azure Cognitive Search REST API. In the case of a data source, the body of the REST request takes the form of a JSON document defining the data source to be created.

1. In Visual Studio Code, expand the **02-Create-an-enrichment-pipeline** folder and the **Python** folder it contains.
2. Expand the **create-enriched-index** folder and open the **data_source.json** file. This contains the JSON definition for a data source that can be submitted to the Azure Cognitive Search REST interface.
3. Review the JSON code, which defines an Azure blob data source named **margies-docs-py** that references the **margies** container in an Azure Storage account. The connection string for the blob container is null - you will address this in your code later.
4. Open the **submit-rest&#46;py** code file and review the Python code it contains. This code is used to submit REST requests to your Azure Cognitive Search service.
5. Open the **.env** file, which contains environment variables for your Python code.
6. Modify the values in the **.env** file to reflect the Azure Cognitive Search endpoint, Azure Cognitive Search admin key, Azure Cognitive Services key, and Azure Storage blob container connection string for the Azure resources you created previously. Then save the updated file.
7. Right-click (Ctrl+click if using a Mac) the **Python/create-enriched-index** folder and select **Open in Integrated Terminal**. This will open a new bash terminal in this folder.
8. In the terminal for the **create-enriched-index** folder, enter the following command:
    ```bash
    python3 submit-rest.py 'POST' 'datasources' 'data_source.json'
    ```
9. Wait while Python runs the **submit-rest&#46;py** script to create the data store.
10. Review the JSON response that is returned from the REST interface, noting that the data source connection string is null to avoid returning sensitive data.
11. Open your search service in the [Azure portal](https://portal.azure.com?portal=true) and view its **Data sources** tab to confirm that the data source has been created.

:::zone-end