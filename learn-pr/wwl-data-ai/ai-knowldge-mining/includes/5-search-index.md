The index is the searchable result of the indexing process. It consists of a collection of JSON documents, with fields that contain the values extracted during indexing. Client applications can query the index to retrieve, filter, and sort information.

![Diagram of a client searching an Azure AI Search index.](../media/search-index.png)

Each index field can be configured with the following attributes:

- **key**: Fields that define a unique key for index records.
- **searchable**: Fields that can be queried using full-text search.
- **filterable**: Fields that can be included in filter expressions to return only documents that match specified constraints.
- **sortable**: Fields that can be used to order the results.
- **facetable**: Fields that can be used to determine values for *facets* (user interface elements used to filter the results based on a list of known field values).
- **retrievable**: Fields that can be included in search results (*by default, all fields are retrievable unless this attribute is explicitly removed*).

## Full-text search

While you could retrieve index entries based on simple field value matching, most search solutions use *full-text search* semantics to query an index.

Full-text search describes search solutions that parse text-based document contents to find query terms. Full-text search queries in Azure AI Search are based on the *Lucene* query syntax, which provides a rich set of query operations for searching, filtering, and sorting data in indexes. Azure AI Search supports two variants of the Lucene syntax:

- **Simple** - An intuitive syntax that makes it easy to perform basic searches that match literal query terms submitted by a user.
- **Full** - An extended syntax that supports complex filtering, regular expressions, and other more sophisticated queries.

Client applications submit queries to Azure AI Search by specifying a search expression along with other parameters that determine how the expression is evaluated and the results returned. Some common parameters submitted with a query include:

- **search** - A search expression that includes the terms to be found.
- **queryType** - The Lucene syntax to be evaluated (*simple* or *full*).
- **searchFields** - The index fields to be searched.
- **select** - The fields to be included in the results.
- **searchMode** - Criteria for including results based on multiple search terms. For example, suppose you search an index of travel-related documents for *comfortable hotel*. A searchMode value of *Any* returns documents that contain "comfortable", "hotel", or both; while a searchMode value of *All* restricts results to documents that contain both "comfortable" and "hotel".

Query processing consists of four stages:

1. *Query parsing*. The search expression is evaluated and reconstructed as a tree of appropriate subqueries. Subqueries might include *term queries* (finding specific individual words in the search expression - for example *hotel*), *phrase queries* (finding multi-term phrases specified in quotation marks in the search expression - for example, *"free parking"*), and *prefix queries* (finding terms with a specified prefix - for example *air\**, which would match *airway*, *air-conditioning*, and *airport*).
2. *Lexical analysis* - The query terms are analyzed and refined based on linguistic rules. For example, text is converted to lower case and nonessential *stopwords* (such as "the", "a", "is", and so on) are removed. Then words are converted to their *root* form (for example, "comfortable" might be simplified to "comfort") and composite words are split into their constituent terms.
3. *Document retrieval* - The query terms are matched against the indexed terms, and the set of matching documents is identified.
4. *Scoring* - A relevance score is assigned to each result based on a term frequency/inverse document frequency (TF/IDF) calculation.

> [!TIP]
> For more information about querying an index, and details about simple and full syntax, see **[Query types and composition in Azure AI Search](/azure/search/search-query-overview)** in the Azure AI Search documentation.

It's common in a search solution for users to want to refine query results by filtering and sorting based on field values. Azure AI Search supports both of these capabilities through the search query API.

## Filtering results

You can apply filters to queries in two ways:

- By including filter criteria in a *simple* **search** expression.
- By providing an OData filter expression as a **$filter** parameter with a *full* syntax search expression.

You can apply a filter to any *filterable* field in the index. 

For example, suppose you want to find documents containing the text *London* that have an **author** field value of *Reviewer*.

You can achieve this result by submitting the following *simple* **search** expression:

```
search=London+author='Reviewer'
queryType=Simple
```

Alternatively, you can use an OData filter in a **$filter** parameter with a *full* Lucene search expression like this:

```
search=London
$filter=author eq 'Reviewer'
queryType=Full
```

> [!NOTE]
> OData **$filter** expressions are case-sensitive!

### Filtering with facets

*Facets* are a useful way to present users with filtering criteria based on field values in a result set. They work best when a field has a small number of discrete values that can be displayed as links or options in the user interface.

To use facets, you must specify *facetable* fields for which you want to retrieve the possible values in an initial query. For example, you could use the following parameters to return all of the possible values for the **author** field:

```
search=*
facet=author
```

The results from this query include a collection of discrete facet values that you can display in the user interface for the user to select. Then in a subsequent query, you can use the selected facet value to filter the results:

```
search=*
$filter=author eq 'selected-facet-value-here'
```

## Sorting results

By default, results are sorted based on the relevancy score assigned by the query process, with the highest scoring matches listed first. However, you can override this sort order by including an OData **orderby** parameter that specifies one or more *sortable* fields and a sort order (*asc* or *desc*).

For example, to sort the results so that the most recently modified documents are listed first, you could use the following parameter values:

```
search=*
$orderby=last_modified desc
```

> [!TIP]
> For more information about using filters, see **[Filters in Azure AI Search](/azure/search/search-filters)** in the Azure AI Search documentation.
