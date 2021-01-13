After you have created and populated an index, you can query it to search for information in the indexed document content. While you could retrieve index entries based on simple field value matching, most search solutions use *full text search* semantics to query an index.

## Full text search

Full text search describes search solutions that parse text-based document contents to find query terms. Full text search queries in Azure Cognitive Search are based on the *Lucene* query syntax, which provides a rich set of query operations for searching, filtering, and sorting data in indexes. Azure Cognitive Search supports two variants of the Lucene syntax:

- **Simple** - An intuitive syntax that makes it easy to perform basic searches that match literal query terms submitted by a user.
- **Full** - An extended syntax that supports complex filtering, regular expressions, and other more sophisticated queries.

Client applications submit queries to Azure Cognitive Search by specifying a search expression along with other parameters that determine how the expression is evaluated and the results returned. Some common parameters submitted with a query include:

- **search** - A search expression that includes the terms to be found.
- **queryType** - The Lucene syntax to be evaluated (*simple* or *full*).
- **searchFields** - The index fields to be searched.
- **select** - The fields to be included in the results.
- **searchMode** - Criteria for including results based on multiple search terms. For example, suppose you search for *comfortable hotel*. A searchMode value of *Any* will return documents that contain "comfortable", "hotel", or both; while a searchMode value of *All* will restrict results to documents that contain both "comfortable" and "hotel".

Query processing consists of four stages:

1. *Query parsing*. The search expression is evaluated and reconstructed as a tree of appropriate subqueries. Subqueries might include *term queries* (finding specific individual words in the search expression - for example *hotel*), *phrase queries* (finding multi-term phrases specified in quotation marks in the search expression - for example, *"free parking"*), and *prefix queries* (finding terms with a specified prefix - for example *air\**, which would match *aircon*, *air-conditioning*, and *airport*).
2. *Lexical analysis* - The query terms are analyzed and refined based on linguistic rules. For example, text is converted to lower case, non-essential *stopwords* (such as "the", "a", "is", and so on) are removed, words are converted to their *root* form (for example, "comfortable" may be simplified to "comfort"), and composite words are split into their constituent terms.
3. *Document retrieval* - The query terns are matched against the indexed terms, and the set of matching documents is identified.
4. *Scoring* - A relevance score is assigned to each result based on a term frequency/inverse document frequency (TF/IDF) calculation.

## Search the Margie's Travel index

To search the Margie's Travel index, you will use a web application that includes a form in which users can submit search expressions. Select your preferred language at the top of this page, and then follow the steps below to query the Margie's Travel search solution.

:::zone pivot="csharp"

1. In the **01-Create-a-search-solution/C-Sharp** folder, expand the **search-client** folder. This folder contains a simple ASP&#46;NET Core web application for the Margie's Travel web site.
2. Open the **appsettings.json** file in the **search-client** folder. This file contains configuration values for the web application.
3. Modify the values in the **appsettings.json** file to reflect the service name (<u>without</u> the .*search&#46;windows&#46;net* suffix) and query key for your Azure Cognitive Search service) and the (be sure to specify the *query* key, and not the *admin* key!). Then save the **appsettings.json** file.
4. In the **Pages** folder for the web application, open the **Index.cshtml** code file. This file defines the main page of the web application. The page contains a form in which users can submit search terms, and code to render the search results.
5. Open the **Index.cshtml.cs** code file, which contains C# code to support the web page. Review the **OnGet** function, which is called when the page is requested. It extracts parameters passed in the request, and then uses a **SearchServiceClient** object to submit a query to Azure Cognitive Search. The query includes the following parameters:
    - **Select**: The index fields to be included in the query results.
    - **SearchMode**: This value determines how the search query is applied. A value of **All** means that all of the specified search terms must be present for the document to be included in the results. A value of **Any** means that only one or more of the terms must be present.
    - **HighlightFields**: Fields that can be used to display a snippet of the document data with the search term highlighted. In this case, the results include extracts from the **content** field with up to three instances of the search term shown in context.
    - **Facets**: Fields that can be used to provide filters in the user interface, enabling users to "drill-down" into the results. In this case, the **author** field is specified, so the results can include navigation elements that enable users to further refine the query by selecting individual author values.
6. In the **Models** folder, open the **SearchResults.cs** code file. This defines a class for the search results - the query returns a list of these.
7. Right-click (Ctrl+click if using a Mac) the **C-Sharp/search-client** folder and select **Open in Integrated Terminal** to open a new bash terminal in this folder.
8. In the terminal for the **search-client** folder, enter the following command:
    ```bash
    dotnet run
    ```
9. When the following message is displayed, follow the `https://localhost:5000/` link to open the web application in a new browser tab:
    ```text
    info: Microsoft.Hosting.Lifetime[0]
    Now listening on: http://localhost:5000
    info: Microsoft.Hosting.Lifetime[0]
    Application started. Press Ctrl+C to shut down.
    info: Microsoft.Hosting.Lifetime[0]
    Hosting environment: Development
    info: Microsoft.Hosting.Lifetime[0]
    Content root path: /root/workspace/km/01-Create-a-search-solution/C-Sharp/search-client
   ```
10. Wait for the web site to open (the web site is being run in the development container, and port forwarding is used to make it available as a locally hosted site in your browser session - you may need to allow access through your firewall).
11. In the Margie's Travel website, enter **London hotel** into the search box and click **Search**.
12. Review the search results. They include the file name (with a hyperlink to the file URL), author, size, last modified date, and an extract of the file content with the search terms (*London* and *hotel*) emphasized.
13. Observe that the **author** facets have been used to create user interface elements for filtering based on the author (the documents in the Margie's Travel data source have two possible author values: **Margies Travel** and **Reviewer**). You'll explore this feature in a later exercise.
14. Try another search by entering **"New York"** (including the quotation marks) in the search box at the top of the page and clicking **Search**. This time the results reflect a search for the complete phrase "New York".
15. Try another search by entering new search terms (for example **Luxury hotel in Las Vegas**) in the search box at the top of the page and clicking **Search**.
16. Close the browser tab containing the Margie's Travel web site and return to Visual Studio Code. Then in the terminal for the **search-client** folder (where the dotnet process is running), enter Ctrl+C to stop the app.

:::zone-end

:::zone pivot="python"

1. In the **01-Create-a-search-solution/Python** folder, expand the **search-client** folder. This folder contains a simple Flask-based web application for the Margie's Travel web site.
2. Open the **.env** file in the **search-client** folder. This file contains environment variables for the web application.
3. Modify the values in the **.env** file to reflect the endpoint and query key for your Azure Cognitive Search resources (be sure to specify the *query* key, and not the *admin* key!). Then save the **.env** file.
4. Open the **app&#46;py** code file. This file contains the code for the Flask web application. The code:
    - Loads the required Azure Cognitive Search credentials from environment variables.
    - Defines a function named **azsearch_query** that submits a query as a REST request to an Azure Cognitive Search endpoint.
    - Defines a route for the web site's home page (*/*) that displays a web page based on the **default.html** template. This template includes a basic search form.
    - Defines a route for the search results page (*/search*) that retrieves the query text from the search form, constructs parameters for the REST request, submits the query, and renders the results in the **search.html** template.
    - Defines a route for a more advanced search page (*/filter*) that includes filtering and sorting.
5. Examine the code in the **search** function (for the **/search** route), and review the **searchParams** definition. This configures the search query performed by Azure Cognitive Search, and includes the following parameters:
    - **search**: The text to be searched for. In this case, the search terms are passed to the function from the search form on the web page.
    - **searchMode**: This value determines how the search query is applied. A value of **All** means that all of the specified search terms must be present for the document to be included in the results. A value of **Any** means that only one or more of the terms must be present.
    - **$count**: Determines whether a value indicating the number of matching results (sometimes known as "search hits") is included in the results.
    - **queryType**: Indicates the query parser to be used. Azure Cognitive Search supports two query types: **simple**, which is optimized for basic full-text search queries; and **full**, which uses the Lucene query syntax to apply complex filters and other query expressions.
    - **$select**: The index fields to be included in the query results.
    - **facet**: Fields that can be used to provide filters in the user interface, enabling users to "drill-down" into the results. In this case, the **author** field is specified, so the results can include navigation elements that enable users to further refine the query by selecting individual author values.
    - **highlight**: Fields that can be used to display a snippet of the document data with the search term highlighted. In this case, the results include extracts from the **content** field with up to three instances of the search term shown in context.
    - **api-version**: The version of the Azure Cognitive Search REST API to be used.
6. Observe that the **search** function goes on to submit the query, extract the following data from the JSON response that is returned, and render it in the **search.html** template page:
    - **@odata.count**: The number of results, as returned by the **$count** parameter.
    - The **author** fields in the **@search.facets** collection, which is a list of the discrete **author** vales in the results returned by the **facet** parameter.
    - **value**: The collection of search results returned by the query.
7. Right-click (Ctrl+click if using a Mac) the **Python/search-client** folder and select **Open in Integrated Terminal** to open a new bash terminal in this folder.
8. In the terminal for the **search-client** folder, enter the following command:
    ```bash
    flask run
    ```
9. When the following message is displayed, follow the `https://127.0.0.1:5000/` link to open the web application in a new browser tab:
    ```text
    * Environment: production
      WARNING: This is a development server. Do not use it in a production deployment.
      Use a production WSGI server instead.
   * Debug mode: off
   * Running on http://127.0.0.1:5000/ (Press CTRL+C to quit)
   ```
10. Wait for the web site to open (the web site is being run in the development container, and port forwarding is used to make it available as a locally hosted site in your browser session - you may need to allow access through your firewall).
11. In the Margie's Travel website, enter **London hotel** into the search box and click **Search**.
12. Review the search results. They include the file name (with a hyperlink to the file URL), author, size, last modified date, and an extract of the file content with the search terms (*London* and *hotel*) emphasized.
13. Observe that the **author** facets have been used to create user interface elements for filtering based on the author (the documents in the Margie's Travel data source have two possible author values: **Margies Travel** and **Reviewer**). You'll explore this feature in a later exercise.
14. Try another search by entering **"New York"** (including the quotation marks) in the search box at the top of the page and clicking **Search**. This time the results reflect a search for the complete phrase "New York".
15. Try another search by entering new search terms (for example **Luxury hotel in Las Vegas**) in the search box at the top of the page and clicking **Search**.
16. Close the browser tab containing the Margie's Travel web site and return to Visual Studio Code. Then in the Python terminal for the **search-client** folder (where the flask application is running), enter Ctrl+C to stop the app.

:::zone-end

> [!NOTE]
> For more information about querying an index, and details about **simple** and **full** syntax, see [Query types and composition in Azure Cognitive Search](https://docs.microsoft.com/azure/search/search-query-overview) in the Azure Cognitive Search documentation.
