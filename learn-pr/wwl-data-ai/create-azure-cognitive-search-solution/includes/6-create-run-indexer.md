An *indexer* is used to populate the fields in an index with values extracted from a data source. The indexer defines field mappings and functions that determine the index field values, and configuration settings for the indexing process that govern the maximum number of errors, timeouts, and so on.

![An indexer.](../media/indexer.png)

You can think of the indexer as the orchestration engine for a *pipeline* that extracts data from the source and incrementally builds the index records. When used with blob data sources, the pipeline performs the following steps:

- *Document cracking* - Extracting the text content from files such as portable document format (PDF) or Microsoft Word documents.
- *Metadata extraction* - Extracting metadata values, such as author name, modified date, file size, and so on.
- *Field mapping* - mapping the extracted contents and metadata values to index fields.

> [!NOTE]
> The steps above describe a basic indexing pipeline. Azure Cognitive Search also enables you to include a set of *AI enrichment* skills in the pipeline to extend the data extraction and mapping capabilities of the indexer and generate new insights that can be mapped to fields in the index. In this module, we'll focus on building a basic search index.

## Create and run an indexer for Margie's Travel

The indexer for the Margie's Travel search solution must map the metadata fields and content from the documents in the data store to the fields in the index. Select your preferred language at the top of this page, and then follow the steps below to create and run an indexer for the Margie's Travel search solution.

:::zone pivot="csharp"

To create an indexer, you can use the **Create** method of the **SearchServiceClient**'s **Indexers** member. When you initially create an indexer, it runs to populate the index. Alternatively, you can include a **schedule** in the indexer definition that will cause the indexer to run periodically.

Indexing is an asynchronous operation. To check the status of an indexer, you use the **GetStatus** method of the **SearchServiceClient**'s **Indexers** member.

1. In the **C-Sharp/create-index** folder, open the **Program.cs** file and review the code in the **CreateIndexer** function, which creates an indexer that maps the metadata fields from the documents in the data source to the index fields.
2. Review the code in the **CheckIndexerOverallStatus** function, which retrieves the indexer status.
3. In the **Terminal** pane, select the bash terminal for the **create-index** folder. If you have closed this terminal, right-click (Ctrl+click if using a Mac) the **C-Sharp/create-index** folder and select **Open in Integrated Terminal**.
4. In the terminal for the **create-index** folder, enter the following command:
    ```bash
    dotnet run
    ```
5. When prompted, press **3** to create and run an indexer. Then wait while the program creates the indexer and then retrieves it status.
6. When the prompt is redisplayed, press **q** to quit the program.
7. Open your search service in the [Azure portal](https://portal.azure.com?portal=true) and view its **Indexers** tab to confirm that the indexer has been created and has processed 72 documents.

:::zone-end

:::zone pivot="python"

To create an indexer with Python, you need to submit a request to the **indexers** REST endpoint with the name of the indexer. The body of the request must be a JSON document that defines the indexer.

The first time you submit a *PUT* request with an indexer definition, the index is created and run automatically to initialize the index. Subsequent *PUT* requests will update the indexer without running it. You must explicitly submit a request to the indexer's **run** endpoint to rerun the indexer. Alternatively, you can include a **schedule** in the indexer definition that will cause the indexer to run periodically.

Indexing is an asynchronous operation. To check the status of an indexer, you can submit a *GET* request to the indexer's **status** endpoint.

1. In the **Python/create-index** folder, open the **indexer.json** file. This file contains the JSON definition of an indexer.
2. Review the indexer definition. It defines an indexer that maps fields from the *margies-docs-py* data source to the *margies-index-py* index. The source fields are standard fields that are extracted from blob data sources based on file metadata and the file contents after Azure Cognitive Search has performed the required document cracking to the PDF files to extract their content.
3. In the **Terminal** pane, select the bash terminal for the **create-index** folder. If you have closed this terminal, right-click (CTRL+click if using a Mac) the **Python/create-index** folder and select **Open in Integrated Terminal**.
4. In the terminal for the **create-index** folder, enter the following command:
    ```bash
    python3 submit-rest.py 'PUT' 'indexers/margies-indexer-py' 'indexer.json'
    ```
5. Wait while Python runs the **submit-rest&#46;py** script, causing it to submit an HTTP PUT request to the *indexers* REST endpoint, adding an indexer named *margies-indexer-py* based on the JSON body defined in the *indexer.json* file. The use of a PUT request ensures that if the indexer already exists, it is updated based on the JSON; otherwise it is created.
6. Review the JSON response that is returned from the REST interface. The indexer is created and automatically run to initialize the index.
7. In the terminal for the **create-index** folder, enter the following command:
    ```bash
    python3 submit-rest.py 'GET' 'indexers/margies-indexer-py/status' 'null'
    ```
8. Review the JSON response that is returned from the REST interface, which shows the status of the indexer. In particular, check the **status** value in the **lastResult** section of the response. If this is shown as **inProgress**, the indexer is still being applied to the index. You can rerun the previous command to retrieve the status until the last result status is **success**.
9. Open your search service in the [Azure portal](https://portal.azure.com?portal=true) and view its **Indexers** tab to confirm that the indexer has been created and has processed 72 documents.

:::zone-end
