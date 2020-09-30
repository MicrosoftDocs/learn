An *indexer* is used to create or update the index by extracting the values from the data source and running the enrichment pipeline to populate the fields in the index. When the skillset for the enrichment pipeline includes a knowledge store definition, running the indexer also creates the projections it defines.

Select your preferred language at the top of this page, and then follow the steps below to create and run an indexer for the Margie's Travel search solution.

:::zone pivot="csharp"

1. In the **C-Sharp/create-knowledge-store** folder, open the **Program.cs** file and review the code in the **CreateIndexer** function, which creates an indexer. The When a new indexer is initially created, it is run automatically.
2. Review the code in the **CheckIndexerOverallStatus** function, which retrieves the indexer status.
3. In the **Terminal** pane, select the bash terminal for the **create-knowledge-store** folder. If you have closed this terminal, right-click (Ctrl+click if using a Mac) the **C-Sharp/create-knowledge-store** folder and select **Open in Integrated Terminal**.
4. In the terminal for the **create-knowledge-store** folder, enter the following command:
    ```bash
    dotnet run
    ```
5. When prompted, press **4** to create and run an indexer. Then wait while the program creates the indexer and then retrieves it status.
6. When the prompt is redisplayed, press **q** to quit the program.
7. In another browser tab, open your search service in the [Azure portal](https://portal.azure.com?portal=true) and view its **Indexers** tab to confirm that the indexer has been created and has processed 72 documents (if it is still in-progress, wait for it to complete).

    > [!NOTE]
    > There may be some warnings indicating that some documents were too large for the sentiment skill to analyze fully, and only the first 1000 characters of these documents were processed. You can ignore these warnings.

:::zone-end

:::zone pivot="python"

1. In the **Python/create-knowledge-store** folder, open the **indexer.json** file. This file contains the JSON definition of an indexer.
2. Review the indexer definition and observe that it maps fields from the **margies-docs-py** data source to the **margies-index-py** index, and uses the **margies-skillset-py** skillset to generate enriched fields.
3. In the **Terminal** pane, select the bash terminal for the **create-knowledge-store** folder. If you have closed this terminal, right-click (CTRL+click if using a Mac) the **Python/create-knowledge-store** folder and select **Open in Integrated Terminal**.
4. In the terminal for the **create-knowledge-store** folder, enter the following command:
    ```bash
    python3 submit-rest.py 'PUT' 'indexers/margies-indexer-py' 'indexer.json'
    ```
5. Wait while Python runs the **submit-rest&#46;py** script, causing it to submit an HTTP PUT request to the *indexers* REST endpoint, adding an indexer named *margies-indexer-py* based on the JSON body defined in the *indexer.json* file. The use of a PUT request ensures that if the indexer already exists, it is updated based on the JSON; otherwise it is created.
6. Review the JSON response that is returned from the REST interface. The indexer is created and automatically run to initialize the index.
7. In the terminal for the **create-knowledge-store** folder, enter the following command:
    ```bash
    python3 submit-rest.py 'GET' 'indexers/margies-indexer-py/status' 'null'
    ```
8. Review the JSON response that is returned from the REST interface, which shows the status of the indexer. In particular, check the **status** value in the **lastResult** section of the response. If the status is shown as **inProgress**, the indexer is still being applied to the index. You can rerun the previous command to retrieve the status until the last result status is **success**.
9. In another browser tab, open your search service in the [Azure portal](https://portal.azure.com?portal=true) and view its **Indexers** tab to confirm that the indexer has been created and has processed 72 documents.

    > [!NOTE]
    > There may be some warnings indicating that some documents were too large for the sentiment skill to analyze fully, and only the first 1000 characters of these documents were processed. You can ignore these warnings.

:::zone-end
