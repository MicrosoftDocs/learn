Search works best when the most relevant results are shown first. All search engines try to return the most relevant results to search queries. Azure AI Search implements an enhanced version of Apache Lucene for full text search.

Here, you'll explore how to write more complex Lucene queries. You'll then improve the relevance of results by boosting specific terms in your search query.

### Search an index

Azure AI Search lets you query an index using a REST endpoint or inside the Azure portal with the search explorer tool. If you want a quick recap of the stages of query processing, see the *search index* unit in [Create an Azure AI Search solution](/training/modules/create-azure-cognitive-search-solution/5-search-index).

:::image type="content" source="../media/query-processing-small.png" alt-text="A diagram showing the four stages of query processing." lightbox="../media/query-processing.png" border="false":::

In this unit, you'll be focusing on query parsing.

You'll use the search explorer to see the difference between using the simple and full query type changes your search results.

> [!NOTE]
> If you want to run the queries yourself you'll need an Azure subscription. [Create an Azure AI Search service](/azure/search/search-create-service-portal) and import the hotels' sample data into an index.

#### Write a simple query

The hotel sample data contains 50 hotels with descriptions, room details, and their locations. Imagine you run a hotel booking business and have an app that users can book hotels with. Users can search and the most relevant hotels must be shown first.

You have a use case where a customer is trying to find a luxury hotel. Start by looking at the search results from this simple query:

`search=luxury&$select=HotelId, HotelName, Category, Tags, Description&$count=true`

The query parses will search for the term `luxury` across all the fields for a document in the index.

The query string also limits the returned fields from documents by adding the `select` option.

`&$select=HotelId, HotelName, Category, Tags, Description`

The last parameter on the query asks the index to count the total results.

`$count=true`

There's no lexical analysis needed so document retrieval returns 14 documents. The first three are:

```json
{
  "@odata.context": "https://advanced-cognitive-search.search.windows.net/indexes('hotels-sample-index')/$metadata#docs(*)",
  "@odata.count": 14,
  "value": [
    {
      "@search.score": 2.633778,
      "HotelId": "13",
      "HotelName": "Historic Lion Resort",
      "Description": "Unmatched Luxury.  Visit our downtown hotel to indulge in luxury accommodations. Moments from the stadium, we feature the best in comfort",
      "Category": "Budget",
      "Tags": [
        "view",
        "free wifi",
        "free wifi"
      ]
    },
    {
      "@search.score": 2.1104424,
      "HotelId": "18",
      "HotelName": "Oceanside Resort",
      "Description": "New Luxury Hotel.  Be the first to stay. Bay views from every room, location near the piper, rooftop pool, waterfront dining & more.",
      "Category": "Budget",
      "Tags": [
        "view",
        "laundry service",
        "air conditioning"
      ]
    },
    {
      "@search.score": 1.966516,
      "HotelId": "40",
      "HotelName": "Trails End Motel",
      "Description": "Only 8 miles from Downtown.  On-site bar/restaurant, Free hot breakfast buffet, Free wireless internet, All non-smoking hotel. Only 15 miles from airport.",
      "Category": "Luxury",
      "Tags": [
        "continental breakfast",
        "view",
        "view"
      ]
    },
    ...
  ]
}
```

The customer might be surprised that the top hotel you have that's supposed to be **luxury** is in the budget category and doesn't have any air conditioning. If the customer enters multiple words in their search, your app assumes all terms should be in the results, so it adds + between terms to the query. This query it sends to the API is:

`search=luxury + air con&$select=HotelId, HotelName, Category, Tags, Description&$count=true`

The search service now returns five documents but still the top results are in the budget category.

#### Enable the Lucene Query Parser

You can tell the search explorer to use the Lucene Query parser by adding `&queryType=full` to the query string.

`search=luxury AND air con&$select=HotelId, HotelName, Category, Tags, Description&$count=true&queryType=full`

With the Lucene syntax, you can write more precise queries. Here is a summary of available features:

- **Boolean operators**: `AND`, `OR`, `NOT` for example `luxury AND 'air con'`
- **Fielded search**: `fieldName:search term` for example `Description:luxury AND Tags:air con`
- **Fuzzy search**: `~` for example `Description:luxury~` returns results with misspelled versions of luxury
- **Term proximity search**: `"term1 term2"~n` for example `"indoor swimming pool"~3` returns documents with the words indoor swimming pool within three words of each other
- **Regular expression search**: `/regular expression/` use a regular expression between `/` for example `/[mh]otel/` would return documents with hotel and motel
- **Wildcard search**: `*`, `?` where `*` will match many characters and `?` matches a single character for example `'air con'*` would find air con and air conditioning
- **Precedence grouping**: `(term AND (term OR term))` for example `(Description:luxury OR Category:luxury) AND Tags:air?con*`
- **Term boosting**: `^` for example `Description:luxury OR Category:luxury^3` would give hotels with the category luxury a higher score than luxury in the description

To read more detail about these features, see [Lucene query syntax in Azure AI Search](/azure/search/query-lucene-syntax) in the docs.

#### Boost search terms

Using the above you can improve the results. The parser should give a higher priority to hotels in the luxury category. You can also be more precise and look for air conditioning in the Tags field.

`(Description:luxury OR Category:luxury^3) AND Tags:'air con'*`

Adding the other query string parameters you get this query string:

`search=(Description:luxury OR Category:luxury^3) AND Tags:'air con'*&$select=HotelId, HotelName, Category, Tags, Description&$count=true&queryType=full`

The top three hotels are now:

```json
{
  "@odata.context": "https://advanced-cognitive-search.search.windows.net/indexes('hotels-sample-index')/$metadata#docs(*)",
  "@odata.count": 5,
  "value": [
    {
      "@search.score": 5.3537707,
      "HotelId": "8",
      "HotelName": "Sapphire Resort",
      "Description": "Downtown, close to everything, steps to the park, shopping, and restaurants.",
      "Category": "Luxury",
      "Tags": [
        "free wifi",
        "continental breakfast",
        "air conditioning"
      ]
    },
    {
      "@search.score": 5.3522806,
      "HotelId": "49",
      "HotelName": "Old Carrabelle Hotel",
      "Description": "Spacious rooms, glamorous suites and residences, rooftop pool, walking access to shopping, dining, entertainment and the city center.",
      "Category": "Luxury",
      "Tags": [
        "air conditioning",
        "laundry service",
        "24-hour front desk service"
      ]
    },
    {
      "@search.score": 4.1448884,
      "HotelId": "18",
      "HotelName": "Oceanside Resort",
      "Description": "New Luxury Hotel.  Be the first to stay. Bay views from every room, location near the piper, rooftop pool, waterfront dining & more.",
      "Category": "Budget",
      "Tags": [
        "view",
        "laundry service",
        "air conditioning"
      ]
    },
    ...
  ]
}
```

The Sapphire Resorts search score has increased from **2.3321536** to **5.3537707** and is now the first hotel the customer will see. The Oceanside Resort is now in third place.
