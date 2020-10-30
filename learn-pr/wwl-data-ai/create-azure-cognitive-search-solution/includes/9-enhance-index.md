With a basic index and a client that can submit queries and display results, you can achieve an effective search solution. However, Azure Cognitive Search supports several ways to enhance an index to provide a better user experience. This topic describes some of the ways in which you can extend your search solution.

## Search-as-you-type

By adding a *suggester* to an index, you can enable two forms of search-as-you-type experience to help users find relevant results more easily:

- *Suggestions* - retrieve and display a list of suggested results as the user types into the search box, without needing to submit the search query.
- *Autocomplete* - complete partially typed search terms based on values in index fields.

To implement one or both of these capabilities, create or update an index, defining a suggester for one or more fields.

After you've added a suggester, you can use the **suggestion** and **autocomplete** REST API endpoints or the .NET **DocumentsOperationsExtensions.Suggest** and **DocumentsOperationsExtensions.Autocomplete** methods to submit a partial search term and retrieve a list of suggested results or autocompleted terms to display in the user interface.

> [!NOTE]
> For more information about suggesters, see [Add autocomplete and suggestions to client apps](https://docs.microsoft.com/azure/search/search-autocomplete-tutorial) in the Azure Cognitive Search documentation.

## Custom scoring and result boosting

By default, search results are sorted by a relevance score that is calculated based on a term-frequency/inverse-document-frequency (TF/IDF) algorithm. You can customize the way this score is calculated by defining a *scoring profile* that applies a weighting value to specific fields - essentially increasing the search score for documents when the search term is found in those fields. Additionally, you can *boost* results based on field values - for example, increasing the relevancy score for documents based on how recently they were modified or their file size.

After you've defined a scoring profile, you can specify its use in an individual search, or you can modify an index definition so that it uses your custom scoring profile by default.

> [!NOTE]
> For more information about scoring profiles, see [Scoring Profiles](https://docs.microsoft.com/azure/search/index-add-scoring-profiles) in the Azure Cognitive Search documentation.

## Synonyms

Often, the same thing can be referred to in multiple ways. For example, someone searching for information about the United Kingdom might use any of the following terms:

- United Kingdom
- UK
- Great Britain\*
- GB\*

*\*To be accurate, the UK and Great Britain are different entities - but they're commonly confused with one another; so it's reasonable to assume that someone searching for "United Kingdom" might be interested in results that reference "Great Britain".*

To help users find the information they need, you can define *synonym maps* that link related terms together. You can then apply those synonym maps to individual fields in an index, so that when a user searches for a particular term, documents with fields that contain the term or any of its synonyms will be included in the results.

> [!NOTE]
> For more information about synonym maps, see [Synonyms in Azure Cognitive Search](https://docs.microsoft.com/azure/search/search-synonyms) in the Azure Cognitive Search documentation.

## Enhancing the Margie's Travel index

Let's enhance the Margie's Travel index by adding synonyms for common geographic entities.

Select your preferred language at the top of this page, and then follow the steps below to enhance your search solution.

:::zone pivot="csharp"

1. In the **Terminal** pane, select the bash terminal for the **C-Sharp/search-client** folder. If you have closed this terminal, right-click (CTRL+click if using a Mac) the **search-client** folder and select **Open in Terminal**.
2. In the terminal for the **search-client** folder, enter the following command:
    ```bash
    dotnet run
    ```
3. Follow the link for the `https://localhost:5000/` address to open the web site in a new browser tab. Then in the Margie's Travel website, enter **"United Kingdom"** into the search box and click **Search**. Then review the results.
4. Enter **UK** into the search box and click **Search** and review the results. The results are different, even though a user might commonly use *UK* as an alternative term for *United Kingdom*. To address this issue, you will add a synonym map to your index.
5. Leaving the Margie's Travel website running, switch back to Visual Studio Code and in the **C-Sharp/create-index** folder, open the **Program.cs** file and review the code in the **AddSynonyms** function, which creates a synonym map and applies it to the **content** field of the index.
6. In the **Terminal** pane, select the bash terminal for the **C-Sharp/create-index** folder. If you have closed this terminal, right-click (Ctrl+click if using a Mac) the **C-Sharp/create-index** folder and select **Open in Integrated Terminal**.
7. In the terminal for the **create-index** folder, enter the following command:
    ```bash
    dotnet run
    ```
8. When prompted, press **4** to add a synonym map. Then wait while the program creates the synonym map and updates the index.
9. When the prompt is redisplayed, press **q** to quit the program.
10. After the index has been updated, switch back to the Margie's Travel website tab and search for **UK**. The results this time should include documents in which the term *United Kingdom* is highlighted.
11. Close the browser tab containing the Margie's Travel web site and return to Visual Studio Code. Then in the *dotnet* terminal for the **search-client** folder (where the web application is running), enter CTRL+C to stop the app.

:::zone-end

:::zone pivot="python"

1. In the **Terminal** pane, select the bash terminal for the **Python/search-client** folder. If you have closed this terminal, right-click (CTRL+click if using a Mac) the **search-client** folder and select **Open in Terminal**.
2. In the terminal for the **search-client** folder, enter the following command:
    ```bash
    flask run
    ```
3. Follow the link for the `https://127.0.0.1:5000/` address to open the web site in a new browser tab. Then in the Margie's Travel website, enter **"United Kingdom"** into the search box and click **Search**. Then review the results.
4. Enter **UK** into the search box and click **Search** and review the results. The results are different, even though a user might commonly use *UK* as an alternative term for *United Kingdom*. To address this issue, you will add a synonym map to your index.
5. Leaving the Margie's Travel website running, switch back to Visual Studio Code and in the **create-index** folder, open the **synonyms.json** file. This file contains a JSON definition for a synonym map that includes alternative terms for the United States, United Kingdom, and United Arab Emirates.
6. in the **create-index** folder, open the **updated_index.json** file. This file contains a JSON definition for the index in which the synonym map has been added to the **content** field.
7. In the **Terminal** pane, select the bash terminal for the **Python/create-index** folder. If you have closed this terminal, right-click (CTRL+click if using a Mac) the **Python/create-index** folder and select **Open in Integrated Terminal**.
8. In the terminal for the **create-index** folder, enter the following command to create the synonym map:
    ```bash
    python3 submit-rest.py 'PUT' 'synonymmaps/margies-synonyms-py' 'synonyms.json'
    ```
9. After the synonym map has been created, enter the following command to update the index:
    ```bash
    python3 submit-rest.py 'PUT' 'indexes/margies-index-py' 'updated_index.json'
    ```
10. After the index has been updated, switch back to the Margie's Travel website tab and search for **UK**. The results this time should include documents in which the term *United Kingdom* is highlighted.
11. Close the browser tab containing the Margie's Travel web site and return to Visual Studio Code. Then in the *Python3* terminal for the **search-client** folder (where the flask web application is running), enter CTRL+C to stop the app.

:::zone-end

You've now completed all of the exercises in this module. If you want to remove the Azure resources you created, in the *bash* terminal for the **01-Create-a-search-solution** folder, enter the following command to run the reset script that was created when you provisioned your Azure resources, signing in when prompted:

```bash
bash reset.sh
```

When your resources have been deleted, continue to the next unit to check your learning.
