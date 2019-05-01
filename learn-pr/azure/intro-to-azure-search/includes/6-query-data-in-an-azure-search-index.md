Importing data into an Azure Search index is the first step to enabling your company to use search. With data loaded into an index, the next step is learning how to query it.

Now that you've been through the basics of Azure Search and how to load documents into an index. You want to understand how to query your new index, you'll look at how to query the data stored within an index, work with the results, and understand the basics of query syntax.

In this unit, you'll see how to write simple search queries in the Azure Search explorer, then append extra parameters to manipulate those results.

## Searching content using Azure Search

Index and query design are closely linked, a crucial component to understand is that the schema of the index sets what's possible for the kind of query that can be answered.

Azure Search queries work in a similar way to any http or REST API request. They're constructed of two key parts, the request, and the response. Queries take the form of a request specifying a construct, that determines what fields are returned, how the index is returned, or how the index should be filtered or sorted. An unspecified query will execute against all the searchable fields within the index in a full text search operation. This method will return a result in an arbitrary order, and with unscored results.

### Query requests in an Azure Search

Query requests in Azure search are always executed against a single index. As a query request is a rich construct, there are several ways to query an index:

- **Azure Search explorer** - Uses a search bar and returns results as JSON objects. Has options for parameters and API version selection.
- **PostMan or Fiddler** - Web testing tools that offer a great alternative for creating REST API calls. They can be used to make REST API calls to your Azure Search service.
- **SearchIndexClient in .Net** - An object within the .NET SDK for querying an Azure Search index.
- **SearchDocuments in the REST API** - Supports every operation in Azure Search through either a GET or POST request, parameters can be added for greater search capability.

### Query request Elements and Parsing

Azure Search queries are constructed of several components. These components have required elements in order for a query request to be successful. A query request is essentially a hit list of what you would like to be returned in a result set. As queries are only against a single index, you're unable to create temporary or custom data structures for a query target, or join indexes together in the syntax of the query.

The required elements for a query request are:

- **The service endpoint and index collection:** Usually the URL such as <https://(your-service-name).search.windows.net/indexes/(your-index-name)/docs>.
- **The API version:** Enables you to choose which version to send the request to.
- **An API Key:** Used to authenticate the request.
- **A query type:** - One of two choices either simple or full, simple syntax is the default option.
- **The match criteria:** - Is either search or filter, it can be omitted if you wish to run an empty search.

### Simple Query Syntax

The simple query syntax in Azure Search excludes fuzzy search options. The simple query syntax is the default setting, it only needs to be explicitly invoked if the queryType parameter has been set to full.

**Joing terms**

`+`: To ask for documents that contain all the search terms. For example, `power + boxing` would return all videos with both power and boxing in the title.

`|`: To ask for documents that contain any of the search terms. For example, `yoga | cardio` would return all the videos with either yoga or cardio in the title.

`-`: To ask for documents that don't contain a term. For example, `-cycling` would return all the videos that don't have cycling in the title.

> [!IMPORTANT]
> Search queries default to match any of the search terms. `searchMode` controls this and can be changed to match with all the search  terms. If you don't pay attention to this, using a combination of terms, with some using `-` terms will lead to **OR** instead of **AND** searches. Append either `&searchMode=all` or `&searchMode=any` to specify the desired behaviour.

**Wildcard**

`*`: To include all matching suffix characters. If you need to search for words that begin with a term. For example, to return all the videos that have crunch in their title use `crunch*`.

**Specific strings**

`" "`: To have an exact phrase matched. If you need to find an exact string of characters, including spaces. For example, if a customer wanted to see all `"Hatha Yoga"` classes.

**Specify the order**

`( )`: To state the precedence in the query. For example, use `body + (mind | tone)` if you needed to match all titles with body and either mind or tone.

### Full Lucene Query Syntax

The full Lucene query syntax in Azure Search includes rich query functionality such as wildcards, fuzzy search, regular expressions, and proximity searching. To use the full lucene query syntax in the Azure Search explorer append `&queryType=full` to the end of a search term.

**Simple queries**

All the above can be represented in this syntax.

`OR` or `||`: is the same as `|`

`AND` or `&&`: is the same as `+`

`NOT` or `!`: is the same as `-`

Precedence behaves exactly the same as it does in the simple query syntax.

**Query a specific field**

`fieldname:term`: Search within a specific field in the index, the term can include any valid search term. For example, `title:(yoga | pilates)`

**Fuzzy searches**

`~`: Fuzzy searches expand the search term, looking for variations on a term. For example, the search `high~` will match with hugh, sigh, and high.

**Proximity searches**

`"term term"~X`: To search for words X words apart. Using a `~` after a phrase search, specifying how many words apart they can be. For example, search for `"abs crunch"~3` would return any titles that have abs and crunch within 3 words of each other.

**Regular expressions**

`/search term/`: Use forward slashes to match on regular expressions.

### Filtering data

Filtering in Azure Search works in the same way as any normal filter mechanism. You provide criteria to the index to enable it to select documents to be used in the search, or on a subset of documents that are in scope. For example, a filter could be used to restrict the exercise videos returned in the catalog based on their difficulty level. Using a filter is a fundamental aspect to many search experiences.

Filter expressions are written as OData expressions.

`&$filter=fieldname operator value`: Both strings and numerical fields can be used as the fieldname. For string fields `eq` and `ne` can be used. For numeric fields, OData supports `eq`, `ne`, `gt`, or `lt`.

### Result handling

After a search term has been designed, you also have the ability to choose how the index returns the results. If the result set is large, and you want to display them on a webpage, a typical user experience is to show pages of results. You might want to let the users sort the results on a specific field, or you may only need a subset of the fields in a document.

To test these user experiences in the Azure Search service, you can append the following to your search term.

`&$top=X`: Returns the first X documents from the result set.

`&$count=true`: Returns the total number of documents that match the search term.

`&$skip=X`: Used to manage pagination in results. For example, using `top` and `skip` together allows for `&$top=30&$skip=0` for the first page of results, and then use `&$top=30&$skip=30` for the second page.

`&$select`: Used to specify the fields to be returned.

`&$orderby=fieldname asc|desc`: Used to sort the results by the specified field and direction.

`&facet=fieldname`: Returns a facet structure in the JSON results for the specified field. For example `&facet=Length` includes an array in the results. This array could be used by the website, allowing users to select the length of videos.

```JSON
    "@search.facets": {
        "Length": [
            {
                "count": 6,
                "value": "2019-05-01T00:14:12Z"
            },
            {
                "count": 4,
                "value": "2019-05-01T00:15:30Z"
            },
            {
                "count": 3,
                "value": "2019-05-01T00:02:40Z"
            },
            {
                "count": 3,
                "value": "2019-05-01T00:07:11Z"
            },
            {
                "count": 2,
                "value": "2019-05-01T00:04:12Z"
            }
        ]
    }
```

The search results include an array of the length `value` and a `count` of the videos that match that length.
