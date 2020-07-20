To provide information through search, you must define an index that contains the fields that users can use to query, filter, and sort data.

![An index.](../media/index.png)

An index consists of a collection of JSON objects, each with one or more fields, including a unique key. The fields are populated with values extracted from a data source or pushed in using the API, and can be text, numbers, datetime values, lists, or complex structures.

## Create an index for Margie's Travel

The index for the Margie's Travel solution must fields that can be used to search for information in brochures and customer reviews. Follow the steps for your preferred language to create an index for the Margie's Travel search solution.

:::zone pivot="csharp"

To create an index using C#, you must implement a class that represents the index, including all of its fields.

1. In the **C-Sharp/create-index** folder, open the **MargiesIndex.cs** code file and view the code it contains. This code defines a class for the index, including the following fields:
    - **id**: A unique identifier for each indexed document.
    - **url**: The URL link for the indexed document.
    - **file_name**: The file name of the document.
    - **author**: The author of the document.
    - **content**: The text content of the document.
    - **size**: The size (in bytes) of the document file.
    - **last_modified**: The date and time the document was last updated.
2. Observe that each field in the index has several *attributes* that control its usage. These include:
    - **key**: Fields that define a unique key for index records.
    - **searchable**: Fields that can be queried using full-text search.
    - **filterable**: Fields that can be included in filter expressions to return only documents that match specified constraints.
    - **sortable**: Fields that can be used to order the results.
    - **facetable**: Fields that can be used to determine values for *facets* (user interface elements used to filter the results based on a list of known field values).
    - **retrievable**: Fields that can be included in search results (by default, all fields are retrievable).
3. Open the **Program.cs** code file and in the **Main** function, uncomment the following lines of code (under the comment `// Create the index`):
    ```C#
    Console.WriteLine("Creating the index...");
    Index index = CreateIndex(searchClient);
    ```
4. Review the code in the **CreateIndex** function, which creates an index named **margies-index** based on the **MargiesIndex** class.
5. In the **Terminal** pane, select the bash terminal for the **create-index** folder. If you have closed this terminal, right-click (Ctrl+click if using a Mac) the **create-index** folder and select **Open in Terminal**.
6. In the terminal for the **create-index** folder, enter the following command:
    ```bash
    dotnet run
    ```
7. Wait while the program runs, updating the data source and creating the index.
8. Open your search service in the [Azure portal](https://portal.azure.com?portal=true) and view its **Indexes** tab to confirm that the index has been created.

:::zone-end

:::zone pivot="python"

To create an index using Python, you must use the **indexes** REST endpoint. You can submit a HTTP *PUT* request to create or update an index based on a JSON document that defines the index schema.

1. In the **Python/create-index** folder, open the **index.json** file. This contains the JSON definition of an index.
2. Review the index definition. It includes the following fields:
    - **id**: A unique identifier for each indexed document.
    - **url**: The URL link for the indexed document.
    - **file_name**: The file name of the document.
    - **author**: The author of the document.
    - **content**: The text content of the document.
    - **size**: The size (in bytes) of the document file.
    - **last_modified**: The date and time the document was last updated.
3. Observe that each field in the index has several *attributes* that control its usage. These include:
    - **key**: Fields that define a unique key for index records.
    - **searchable**: Fields that can be queried using full-text search.
    - **filterable**: Fields that can be included in filter expressions to return only documents that match specified constraints.
    - **sortable**: Fields that can be used to order the results.
    - **facetable**: Fields that can be used to determine values for *facets* (user interface elements used to filter the results based on a list of known field values).
    - **retrievable**: Fields that can be included in search results (by default, all fields are retrievable)
4. In the **Terminal** pane, select the bash terminal for the **create-index** folder. If you have closed this terminal, right-click (Ctrl+click if using a Mac) the **create-index** folder and select **Open in Terminal**.
5. In the terminal for the **create-index** folder, enter the following command:
    ```bash
    python3 submit-rest.py 'PUT' 'indexes/margies-index' 'index.json'
    ```
6. Wait while Python runs the **submit-rest&#46;py** script, causing it to submit an HTTP PUT request to the *indexes* REST endpoint, adding an index named *margies-index* based on the JSON body defined in the *index.json* file. The use of a PUT request ensures that if the index already exists, it is updated based on the JSON; otherwise it is created.
7. Review the JSON response that is returned from the REST interface.
8. Open your search service in the [Azure portal](https://portal.azure.com?portal=true) and view its **Indexes** tab to confirm that the index has been created.

:::zone-end
