Now that you have been through the basics of Azure Search and how to create and load data into an index. You need to understand how to query the index, here you'll look at how to query data stored within an index, work with the results and understand basics of Azure Search's query syntax.

## Searching content using Azure Search

Azure search is a search service thereby searching for content contained within Azure Search or an index is a pretty fundamental concept. This concept is one reason why index and query design are closely linked, a crucial component is to understand that the schema of the index (and field attributes) set the scene for the kind of query that can be executed against it.

Azure Search queries work in a similar way to any http, https or REST API call. They are constructed of two key parts a request and a response. Queries are essentially a request specifying a construct in which to determine which fields are returned, how the index is returned or how the index should be filtered or sorted. An unspecified query will execute against all the searchable fields within the index in a full text search operation. This method with return a result set in an arbitrary order and with unscored results.

## Query requests in an Azure Search

Query requests in Azure search are always executed against a single index. As a query request is a rich construct there are several methods to query an index:

- **Using Search Explorer** - Uses a search bar and returns results as JSON objects. Has options for parameters and API version selection.
- **Using PostMan or Fiddler** - These are readily available web testing tools and offer a great alternative for creating REST API calls. They use the Azure Search REST API which supports every operation in Azure Search.
- **Using SearchIndexClient in .Net** - A client within the .NET SDK for querying an Azure Search index.
- **Using SearchDocuments in the REST API** - Supports every every operation in Azure Search through either a GET or POST request, parameters can be added for greater search capability.

The responses returned by Azure Search depend on the type of query request made but also by the parameters you include. For example running a top 10 query will only return the top 10 results in the response, although there will be a count of how many documents match the query overall.

## Query request Elements and Parsing

Azure Search queries are constructed of several components, these components have required elements in order for a query request to be successful. A query request is essentially a hit list of what you would like to be returned in a result set. As queries are only against a single index you are unable to create temporary or custom data structures for a query target or join indexes together in the syntax of the query.

The required elements for a query request are:

- **The service endpoint and index collection:** Usually the URL such as <https://(your-service-name).search.windows.net/indexes/(your-index-name)/docs>.
- **The API version:** This is important as there is always more than one version of the API available.
- **An API Key:** This can either be a key or a query and is used to authenticate the request.
- **A query type:** - One of two choices either simple or full, if the built-in simple syntax is used this is optional.
- **The match criteria:** - This is either search or filter, it can be omitted if you wish to run an empty search.

Azure Search gives you the option to choose between two query parsers for handling query requests, this is because search is layered over Apache Lucene:

**Simple Parser**
A query request using the simple parser method use the simple query syntax. This is usually the default method and gets chosen for its efficiency and speed in free form text queries. A number of common operators are available.

**Full Lucene Parser**
A query request using the full parser method use the Lucene query syntax, this is enabled when the queryType parameter is set to full. This is an expressive and widely adopted syntax bundled with Apache Lucene and extends the simple query syntax. For example you can run a simple query with the full parser method enabled and it will execute under the full Lucene parser.

## Query syntax

Azure search syntax and parsing are closely coupled as such two Lucene based query languages are available. Azure search also supports a wide range of query types:

- Free form text
- Filtered search
- Geo-search
- Range search
- Fuzzy search
- intra-field search
- proximity search
- term boosting
- regular expression search
- wildcard search

## Simple Query Syntax

The simple query syntax in Azure Search excludes fuzzy search options. As simple query syntax is the default setting it only explicitly needs to be invoked if the queryType parameter has been set to full.

As with any query language there are certain anomalies to consider, for example text with one or more terms is valid for executing a query Azure search will attempt to match documents containing all or any of the terms in the request and in most cases include variations. Whilst this may sound simple consideration must be given to erroneous searches increasing search results.

Query language references for the simple syntax can be found [here](https://docs.microsoft.com/en-us/azure/search/query-simple-syntax)

## Full Lucene Query Syntax

The full Lucene query syntax in Azure Search includes rich query forms such as wildcards, fuzzy search, regular expressions and proximity searching. As the query syntax is so rich there are a few fundamentals that apply to all queries:

- **Operator evaluation:** Where an operator is placed in a query string will determine how the symbol is interpreted such as simply another character or as an operator. An example of this would be the tilde (~).
- **Special characters:** Special characters always need additional handling in any language Lucene is no different. Special characters must be escaped to be including as part of the query string by prefixing them with a backslash (\\). Special characters include **+ - && || ! ( ) { } [ ] ^ " ~ * ? : \ /**.
- **Reserved or unsafe characters:** Reserved or unsafe characters need to be encoded in the URL, they are used to define parameters or values in the query string. Reserved characters are **; / ? : @ = + &**. Unsafe characters are **" ` < > # % { } | \ ^ ~ [ ]**.
- **Precedence operators:** These apply to grouping or field grouping and require parentheses to create subqueries.
- **searchMode parameters:** As with the simple syntax the searchMode can have a significant impact of query results. An example would be using NOT with searchMode=any would result in the query executing as an OR statement.

Query language references for the Lucene syntax can be found [here](https://docs.microsoft.com/en-us/azure/search/query-lucene-syntax)

## Filtering and sorting data

Filtering in Azure Search works in the same way as any normal filter mechanism, it provides criteria to the index in order to select documents to be used in the search or on a subset of documents in a scope. For example, a filter could be used to restrict the exercise videos returned in the catalog based on their difficulty level. Using a filter is a fundamental aspect to many search experiences such as a security filter to only display documents the user is able to see.

Sorting is another mechanism in Azure Search that works in a similar way, it is a query construct to provide to the index defining a particular order of documents either by ascending or descending order. The $orderby parameter in Azure Search accepts up to 32 expressions in a comma-separated list. THe default ordering method is ascending.

The Odata expression syntax for filtering and sort orders can be found [here](https://docs.microsoft.com/en-us/azure/search/query-odata-filter-orderby-syntax).

## Result handling

Results returned in any response to a query request in Azure search are formulated based upon the query parameters passed. Typically this requires search results to be implemented in a results page to control layout, sort order, navigation , document retrieval or total counts. Pagination of results for a large index is super important, to help handle the results returned by a request several aspects should be considered:

- **Display the total hits:** Showing the total hits from results and chunking them into smaller pieces is vital to search pages.
- **Results page layout:** The search results page layout is crucial to the user experience i.e. you may wish to display thumbnails of exercise videos as a visual representation of the search results.
- **Sort order:** Providing several sort orders can help users quickly tweak search results such as sorting by popularity, relevance or name.
- **Page filters:** This is another tool to define the search results returned to the page, such as a filter by brand or having dedicated pages for specific types or content.
- **Faceted navigation:** Navigation of search results is a crucial aspect to the user experience (think product filters on an e-commerce website such as color), faceted navigation in Azure search provides user self-directed search on pre-defined filters. For example, having publication date as a selectable filter option on the results page.

Remember results returned when using search explorer do not apply the above concepts. Results are returned in a JSON format and depend on the query parameters entered.

Next you will try out what you have learned by using Search Explorer to query Search index data the portal.