After you import data into a search index, you can finally query the data. In this unit, you'll see how to write simple search queries in the Search explorer, and then append extra parameters to manipulate those results.

## Search content using Azure Cognitive Search

Index and query design are closely linked. A crucial component to understand is that the schema of the index determines what queries can be answered.

Azure Cognitive Search queries can be submitted as an HTTP or REST API request, with the response coming back as JSON. Queries can specify what fields are searched and returned, how search results are shaped, and how the results should be filtered or sorted. A query that doesn't specify the field to search will execute against all the searchable fields within the index.

Azure Cognitive Search supports two types of syntax: simple and full Lucene. Simple syntax covers all of the common query scenarios, including geo-search. Full Lucene is useful for advanced scenarios such as wildcard and fuzzy search, or term boosting.

Whichever way you choose to search your content, you need to know the following information to write your queries.

### Query request Elements and Parsing

A query request is a list or words (search terms) and query operators (simple or full) of what you would like to see returned in a result set. Let's look what components make up a search query. Consider this search:

```
calm easy meditation (-"yoga" + -"pilates")
```

This query is trying to find a video that is calm and relaxing, but the person searching wants to exclude yoga and pilates.

Breaking the query into components, it's made up of search terms, (`calm`, `easy`, `meditation`), plus two verbatim phrases, `"yoga"` and `"pilates"`, and operators (`-`, `+`, and `( )`). The search terms can be matched in the search index in any order or location in the title of your videos. The two phrases will only match with exactly what is specified, so yoga would not be a match. Finally, a query can contain a number of operators. In this example, the `-` operator tells the search engine that these phrases should *NOT* be in the results. The parenthesis group terms together, and set their precedence.

By default, the search engine will match any of the terms in the query. A title containing just `calm` would be a match. In this example, using `-"yoga"` would lead to the search results including all the titles that don't have the exact string "yoga" in it.

### Simple query syntax

The simple query syntax in Azure Cognitive Search excludes some of the more complex features of the full Lucene query syntax, and it's the default search syntax for queries. This example search is written in this simple query syntax.

**Operators**

`+`: To ask for documents that contain all the search terms. For example, `power + boxing` would return all videos with both power **AND** boxing in the title.

`|`: To ask for documents that contain any of the search terms. For example, `yoga | cardio` would return all the videos with either yoga **OR** cardio in the title.

`-`: To ask for documents that don't contain a term. For example, `-cycling` would return all the videos that do **NOT** have cycling in the title.

`*`: To include all matching suffix characters. If you need to search for words that begin with a term. For example, to return all the videos that have variations of crunch in their title, use `crunch*`. The search would match with crunch, crunches, and crunched.

> [!IMPORTANT] 
>
> Remember that search queries default to match *any* of the search terms. You can change this behavior using the `searchMode` option. A query can be changed to match with all the search terms. If you don't pay attention to this, using a combination of terms (with some using the `-` operator), will lead to **OR** instead of **AND** searches. Append either `&searchMode=all` or `&searchMode=any` to specify the desired behavior.

```
calm easy meditation (-"iyengar yoga" + -"hot pilates")
```

Examining the search query again, can you anticipate the outcome? If you ran this query as is, the search engine wouldn't return the desired results. Given an `any` search, all videos that *don't* have `(-"iyengar yoga" + -"hot pilates")` in their titles would be considered a match, which is probably not what you want. There are two ways to rewrite this query to achieve the desired results. One way uses the operators to clarify the query:

```
(calm easy meditation) + (-"iyengar yoga" + -"hot pilates")
```

This search query groups the first three terms with the precedence operator `( )`, so any of calm, easy, or meditation will be a match in the results. The `+` operator tells the search parser that the tile must have (calm, easy, **OR** meditation) **AND** (neither of the specific terms) in the result.

The other way is to change the search mode:

```
(calm | easy | meditation) (-"iyengar yoga" + -"hot pilates")&searchMode=all
```

Can you see that using `&searchMode=all` means that the first group of terms now needs to be separated by the **OR** `|` operator. If the query didn't contain the `|` operator, the search results would need to match (calm **AND** easy **AND** meditation) **AND** (neither of the phrases). Setting the search mode to `all` also means that the `+` operator becomes redundant, and can be removed.

### Handle results

After a query expression has been designed, you can choose how the results are shaped. If the result set is large, and you want to display them on a webpage, a typical user experience is to page the results:

`Showing 1 - 5 or 36 videos` or another way of displaying pagination `Showing Page 3 of 10`.

To support this experience, you limit the returned results with the `&$top=X` parameter. In the above example, you would append `&$top=5` to your search query. If the user then wanted to see the next 5 videos, you would append `&$top=5$skip=5`. The `skip` parameter allows you to reach deeper into the results. The amount that needs to be skipped can be represented as the formula `skip=(page*top)-top`. Using page 5 as an example, the parameter would be `(5*5)-5 = 20` so the value to skip is `20`. The total count of results can be shown in the result set if you append `&$count=true`.

A useful feature to your customers is the ability to order the results on the length of exercise videos. For example, users may want to see the shortest videos first. If you're familiar with SQL queries, ordering the results works in a similar way. Append an `&$orderby=fieldname asc|desc` parameter to the end of the query string. With this knowledge, how would you write a query so sort the results shortest first?

```
&$orderby=Length asc
```
