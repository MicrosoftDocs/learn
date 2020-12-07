Now that you have created a custom skill, you can add it to your skillset and use it to populate a field in your index.

:::zone pivot="csharp"

## Add the function URL to the app configuration

The URL for your function is how the skillset will connect to it, so you need to add it to your app configuration.

1. In the **C-Sharp/create-enriched-index** folder, open the **appsettings.json** file, which contains the configuration settings for your app.
2. Update the **AzureFunctionUri** setting with the URL for your Azure function (which you copied to the clipboard in the previous procedure), replacing ***YOUR-FUNCTION-APP-URL***.

## Modify the skillset definition

Now you need to add your custom skill to the skillset.

1. In the **C-Sharp/create-enriched-index** folder, open **Program.cs** and review the **CreateCustomSkill** function. This function creates a **WebApiSkill** that includes a **uri** property referencing your Azure function.
2. In the **CreateSkillset** function, after all of the built-in skills have been defined, find the comment `//Uncomment below to add custom skill` and uncomment the code beneath it to add the custom skill to the list of skills for the skillset:

    ```C#
    skills.Add(CreateCustomSkill());
    ```

## Modify the index definition

The custom skill returns a list of the top 10 words found in each document, which you can add as a field in your index.

1. In the **C-Sharp/create-enriched-index** folder, open **MargiesIndex.cs** and review the **MargiesIndex** class definition.
2. At the bottom of the class definition, find the comment `// Uncomment below to add custom skill field`, and uncomment the two lines beneath it to define a searchable and filterable field named **top_words**:

    ```C#
    [IsSearchable, IsFilterable]
    public string[] top_words { get; set; }
    ```

## Modify the indexer definition

Now that you've defined a skill to extract the list of top 10 words, and a corresponding field in the index, you must modify the indexer to map the skill output to the index field.

1. In the **C-Sharp/create-enriched-index** folder, open **Program.cs** and review the **CreateIndexer** function.
2. At the bottom of the function, find the comment `// Uncomment below to add custom skill field`, and uncomment the code beneath it to map the custom skill output to the **top_words** index field:

    ```C#
    outputMappings.Add(new FieldMapping(
        sourceFieldName: "/document/topWords",
        targetFieldName: "top_words"
    ));
    ```
3. Review the **ResetIndexer** function. which resets and reruns the indexer. After you update the existing indexer, you'll need to explicitly reset and rerun it to repopulate the index.

## Run the code

Now you're ready to run the modified code and update the index with the output from your custom skill.

1. In the **Terminal** pane, select the bash terminal for the **create-enriched-index** folder. If you have closed this terminal, right-click (Ctrl+click if using a Mac) the **C-Sharp/create-enriched-index** folder and select **Open in Integrated Terminal**.
2. In the terminal for the **create-enriched-index** folder, enter the following command:
    ```bash
    dotnet run
    ```
3. When prompted, press **2** to recreate the skillset.
4. When the prompt is redisplayed, press **3** to recreate the index.
5. When the prompt is redisplayed, press **4** to recreate the indexer.
6. When the prompt is redisplayed, press **5** to reset and rerun the index.
7. When the prompt is redisplayed, press **q** to quit the program.
8. Open your search service in the [Azure portal](https://portal.azure.com?portal=true) and view its **Indexers** tab to confirm that the indexer has run successfully (if it is still in-progress, wait for it to complete - it may initially fail and then rerun).

:::zone-end

:::zone pivot="python"

## Update the skillset and index

First, you need to update the skillset and index to reflect the enriched field you want to add.

1. In the **Python/create-enriched-index** folder, open the **updated_skillset.json** file. This contains the JSON definition of a skillset.
2. Review the skillset definition. It includes the same skills as before, as well as a new **WebApiSkill** skill named **get-top-words**.
3. Edit the **get-top-words** skill definition to set the **uri** value to the URL for your Azure function (which you copied to the clipboard in the previous procedure), replacing ***YOUR-FUNCTION-APP-URL***.
4. In the **Terminal** pane, select the bash terminal for the **create-enriched-index** folder. If you have closed this terminal, right-click (Ctrl+click if using a Mac) the **Python/create-enriched-index** folder and select **Open in Terminal**.
5. In the terminal for the **create-enriched-index** folder, enter the following command:
    ```bash
    python3 submit-rest.py 'PUT' 'skillsets/margies-skillset-py' 'updated_skillset.json'
    ```
6. Wait while Python runs the **submit-rest&#46;py** script to update your skillset.
7. In the **create-enriched-index** folder, open the **updated_index.json** file. This contains the JSON definition of an index.
8. Review the index definition. It includes the same fields as before, as well as a new field named **top_words**, which consists of a list of string values.
9. In the **Terminal** pane, select the bash terminal for the **create-enriched-index** folder. If you have closed this terminal, right-click (CTRL+click if using a Mac) the **create-enriched-index** folder and select **Open in Terminal**.
10. In the terminal for the **create-enriched-index** folder, enter the following command:
    ```bash
    python3 submit-rest.py 'PUT' 'indexes/margies-index-py' 'updated_index.json'
    ```
11. Wait while Python runs the **submit-rest&#46;py** script to update your index.

## Update and rerun the indexer

To map the data extracted by your custom skill to the corresponding field in the index, you need to modify and rerun the indexer.

1. In the **create-enriched-index** folder, open the **updated_indexer.json** file. This contains the JSON definition of an indexer.
2. Review the indexer definition, noting that it includes a mapping between the **/document/topWords** value extracted by your custom skill and the **top_words** field in the index.
3. In the **Terminal** pane, select the bash terminal for the **create-enriched-index** folder. If you have closed this terminal, right-click (Ctrl+click if using a Mac) the **create-enriched-index** folder and select **Open in Terminal**.
4. In the terminal for the **create-enriched-index** folder, enter the following command:
    ```bash
    python3 submit-rest.py 'PUT' 'indexers/margies-indexer-py' 'updated_indexer.json'
    ```
5. Wait while Python runs the **submit-rest&#46;py** script to update the indexer definition.
6. In the terminal for the **create-enriched--index** folder, enter the following command to reset the indexer (so that all documents will be reindexed the next time it runs):
    ```bash
    python3 submit-rest.py 'POST' 'indexers/margies-indexer-py/reset' 'null'
    ```
7. In the terminal for the **create-enriched--index** folder, enter the following command to run the indexer:
    ```bash
    python3 submit-rest.py 'POST' 'indexers/margies-indexer-py/run' 'null'
    ```
8. In the terminal for the **create-enriched--index** folder, enter the following command:
    ```bash
    python3 submit-rest.py 'GET' 'indexers/margies-indexer-py/status' 'null'
    ```
9. Review the JSON response that is returned from the REST interface, which shows the status of the indexer. In particular, check the **status** value in the **lastResult** section of the response. If this is shown as **inProgress**, the indexer is still being applied to the index. You can rerun the previous command to retrieve the status until the last result status is **success**.

:::zone-end
