With a basic index and a client that can submit queries and display results, you can achieve an effective search solution. However, Azure AI Search supports several ways to enhance an index to provide a better user experience. This topic describes some of the ways in which you can extend your search solution.

## Search-as-you-type

By adding a *suggester* to an index, you can enable two forms of search-as-you-type experience to help users find relevant results more easily:

- *Suggestions* - retrieve and display a list of suggested results as the user types into the search box, without needing to submit the search query.
- *Autocomplete* - complete partially typed search terms based on values in index fields.

To implement one or both of these capabilities, create or update an index, defining a suggester for one or more fields.

After you've added a suggester, you can use the **suggestion** and **autocomplete** REST API endpoints or the .NET **DocumentsOperationsExtensions.Suggest** and **DocumentsOperationsExtensions.Autocomplete** methods to submit a partial search term and retrieve a list of suggested results or autocompleted terms to display in the user interface.

> [!NOTE]
> For more information about suggesters, see [Add autocomplete and suggestions to client apps](/azure/search/search-autocomplete-tutorial) in the Azure AI Search documentation.

## Custom scoring and result boosting

By default, search results are sorted by a relevance score that is calculated based on a term-frequency/inverse-document-frequency (TF/IDF) algorithm. You can customize the way this score is calculated by defining a *scoring profile* that applies a weighting value to specific fields - essentially increasing the search score for documents when the search term is found in those fields. Additionally, you can *boost* results based on field values - for example, increasing the relevancy score for documents based on how recently they were modified or their file size.

After you've defined a scoring profile, you can specify its use in an individual search, or you can modify an index definition so that it uses your custom scoring profile by default.

> [!NOTE]
> For more information about scoring profiles, see [Scoring Profiles](/azure/search/index-add-scoring-profiles) in the Azure AI Search documentation.

## Synonyms

Often, the same thing can be referred to in multiple ways. For example, someone searching for information about the United Kingdom might use any of the following terms:

- United Kingdom
- UK
- Great Britain\*
- GB\*

*\*To be accurate, the UK and Great Britain are different entities - but they're commonly confused with one another; so it's reasonable to assume that someone searching for "United Kingdom" might be interested in results that reference "Great Britain".*

To help users find the information they need, you can define *synonym maps* that link related terms together. You can then apply those synonym maps to individual fields in an index, so that when a user searches for a particular term, documents with fields that contain the term or any of its synonyms will be included in the results.

> [!NOTE]
> For more information about synonym maps, see [Synonyms in Azure AI Search](/azure/search/search-synonyms) in the Azure AI Search documentation.
