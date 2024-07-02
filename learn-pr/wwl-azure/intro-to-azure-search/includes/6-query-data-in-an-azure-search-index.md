Index and query design are closely linked. After we build the index, we can perform queries. A crucial component to understand is that the schema of the index determines what queries can be answered.

Azure AI Search queries can be submitted as an HTTP or REST API request, with the response coming back as JSON. Queries can specify what fields are searched and returned, how search results are shaped, and how the results should be filtered or sorted. A query that doesn't specify the field to search will execute against all the searchable fields within the index.

Azure AI Search supports two types of syntax: simple and full Lucene. Simple syntax covers all of the common query scenarios, while full Lucene is useful for advanced scenarios.

### Simple query requests (behind the scenes)

A query request is a list or words (search terms) and query operators (simple or full) of what you would like to see returned in a result set. Let's look what components make up a search query. Consider this simple search example:

```
coffee (-"busy" + "wifi")
```

This query is trying to find content about coffee, excluding busy and including wifi.

Breaking the query into components, it's made up of search terms (`coffee`), plus two verbatim phrases, `"busy"` and `"wifi"`, and operators (`-`, `+`, and `( )`). The search terms can be matched in the search index in any order or location in the content. The two phrases will only match with exactly what is specified, so `wi-fi` would not be a match. Finally, a query can contain a number of operators. In this example, the `-` operator tells the search engine that these phrases should *NOT* be in the results. The parenthesis group terms together, and set their precedence.

By default, the search engine will match any of the terms in the query. Content containing just `coffee` would be a match. In this example, using `-"busy"` would lead to the search results including all content that doesn't have the exact string "busy" in it.

The simple query syntax in Azure AI Search excludes some of the more complex features of the full Lucene query syntax, and it's the default search syntax for queries. 

You can learn more about query syntax in the [documentation](/azure/search/query-odata-filter-orderby-syntax). 



