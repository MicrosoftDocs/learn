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

> [!TIP]
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

> [!NOTE]
> For more information about using filters, see [Filters in Azure AI Search](/azure/search/search-filters). For information about working with results, including sorting and hit highlighting, see [How to work with search results in Azure AI Search](/azure/search/search-pagination-page-layout).
