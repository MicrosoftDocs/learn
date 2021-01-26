An index consists of a collection of JSON objects, each with one or more fields, including a unique key. The fields are populated with values extracted from the data source combined with the outputs from the enrichment pipeline defined in the skillset, and can be text, numbers, datetime values, lists, or complex structures.

## Create an index for Margie's Travel

The index for the Margie's Travel solution must contain fields that can be used to search for information in brochures and customer reviews. Choose your preferred language at the top of this page, and then follow the steps below to create an index for the Margie's Travel search solution.

:::zone pivot="csharp"

To create an index using C#, you must implement a class that represents the index, including all of its fields.

1. In the **C-Sharp/create-enriched-index** folder, open the **MargiesIndex.cs** code file and view the code it contains. This code defines the following types:
    - **Caption**: A struct containing **text** and **confidence** properties.
    - **ImageDescription**: A struct containing a **captions** property (which is) collection of **Captions**) and a **tags** property, which is a collection of strings.
    - **MargiesIndex**: A class that defines the structure of the index for the search solution, which includes a complex field based on the **ImageDescription** struct. 
2. Review the definition of the **MargiesIndex** class, which includes the following fields:
   - **id**: A unique identifier for each indexed document.
    - **url**: The URL link for the indexed document.
    - **file_name**: The file name of the document.
    - **author**: The author of the document.
    - **size**: The size (in bytes) of the document file.
    - **last_modified**: The date and time the document was last updated.
    - **language**: The language in which the document is written.
    - **sentiment**: A numeric value between 0 and 1 indicating how positive or negative the sentiment of the document is.
    - **key_phrases**: A list of key phrases in the document, which can be useful for identifying its main points.
    - **locations**: A list of geographical locations mentioned in the document.
    - **links**: A list of URLs mentioned in the document.
    - **image_descriptions**: A complex structure containing AI-generated descriptions of images in the document. The description consists of two elements:
        - **tags**: A list of *tag* words that denote some descriptive attribute of the image.
        - **captions**: A list of suggested textual descriptions of the image, each caption consisting of a **text** value and a **confidence** score.
    - **image_captions**: A list of caption text values (*this is the same data as the **image_descriptions/captions/text** value above - we've duplicated it here to demonstrate multiple ways to deal with complex index field values*).
    - **image_text**: A list of text extracted from images in the document.
    - **content**: The original document text merged with text extracted from images in the document.
3. Observe that each field in the index has several *attributes* that control its usage. These attributes include:
    - **key**: Fields that define a unique key for index records.
    - **searchable**: Fields that can be queried using full-text search.
    - **filterable**: Fields that can be included in filter expressions to return only documents that match specified constraints.
    - **sortable**: Fields that can be used to order the results.
    - **facetable**: Fields that can be used to determine values for *facets* (user interface elements used to filter the results based on a list of known field values).
    - **retrievable**: Fields that can be included in search results (*by default, all fields are retrievable, so even though this attribute is omitted in the JSON, all of the index fields will be implicitly retrievable*.).
4. Open the **Program.cs** code file and review the code in the **CreateIndex** function, which creates an index named **margies-index-cs** based on the **MargiesIndex** class.
5. In the **Terminal** pane, select the bash terminal for the **create-enriched-index** folder. If you have closed this terminal, right-click (Ctrl+click if using a Mac) the **C-Sharp/create-enriched-index** folder and select **Open in Integrated Terminal**.
6. In the terminal for the **create-enriched-index** folder, enter the following command:
    ```bash
    dotnet run
    ```
7. When prompted, press **3** to create an index. Then wait while the program creates the index.
8. When the prompt is redisplayed, press **q** to quit the program.
9. Open your search service in the [Azure portal](https://portal.azure.com?portal=true) and view its **Indexes** tab to confirm that the index has been created.

:::zone-end

:::zone pivot="python"

To create an index using Python, you must use the **indexes** REST endpoint. You can submit an HTTP *PUT* request to create or update an index based on a JSON document that defines the index schema.

1. In the **Python/create-enriched-index** folder, open the **index.json** file. This file contains the JSON definition of an index.
2. Review the index definition. It includes the following fields:
    - **id**: A unique identifier for each indexed document.
    - **url**: The URL link for the indexed document.
    - **file_name**: The file name of the document.
    - **author**: The author of the document.
    - **size**: The size (in bytes) of the document file.
    - **last_modified**: The date and time the document was last updated.
    - **language**: The language in which the document is written.
    - **sentiment**: A numeric value between 0 and 1 indicating how positive or negative the sentiment of the document is.
    - **key_phrases**: A list of key phrases in the document, which can be useful for identifying its main points.
    - **locations**: A list of geographical locations mentioned in the document.
    - **links**: A list of URLs mentioned in the document.
    - **image_descriptions**: A complex structure containing AI-generated descriptions of images in the document. The description consists of two elements:
        - **tags**: A list of *tag* words that denote some descriptive attribute of the image.
        - **captions**: A list of suggested textual descriptions of the image, each caption consisting of a **text** value and a **confidence** score.
    - **image_captions**: A list of caption text values (*this is the same data as the **image_descriptions/captions/text** value above - we've duplicated it here to demonstrate multiple ways to deal with complex index field values*).
    - **image_text**: A list of text extracted from images in the document.
    - **content**: The original document text merged with text extracted from images in the document.
3. Observe that each field in the index has several *attributes* that control its usage. These attributes include:
    - **key**: Fields that define a unique key for index records.
    - **searchable**: Fields that can be queried using full-text search.
    - **filterable**: Fields that can be included in filter expressions to return only documents that match specified constraints.
    - **sortable**: Fields that can be used to order the results.
    - **facetable**: Fields that can be used to determine values for *facets* (user interface elements used to filter the results based on a list of known field values).
    - **retrievable**: Fields that can be included in search results (*by default, all fields are retrievable, so even though this attribute is omitted in the JSON, all of the index fields will be implicitly retrievable*.)
4. In the **Terminal** pane, select the bash terminal for the **create-enriched-index** folder. If you have closed this terminal, right-click (Ctrl+click if using a Mac) the **Python/create-enriched-index** folder and select **Open in Integrated Terminal**.
5. In the terminal for the **create-enriched-index** folder, enter the following command:
    ```bash
    python3 submit-rest.py 'PUT' 'indexes/margies-index-py' 'index.json'
    ```
6. Wait while Python runs the **submit-rest&#46;py** script, causing it to submit an HTTP PUT request to the *indexes* REST endpoint, adding an index named *margies-index-py* based on the JSON body defined in the *index.json* file. The use of a PUT request ensures that if the index already exists, it is updated based on the JSON; otherwise it is created.
7. Review the JSON response that is returned from the REST interface.
8. Open your search service in the [Azure portal](https://portal.azure.com?portal=true) and view its **Indexes** tab to confirm that the index has been created.

:::zone-end
