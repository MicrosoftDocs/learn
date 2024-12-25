After you have created and populated an index, you can query it to search for information in the indexed document content. While you could retrieve index entries based on simple field value matching, most search solutions use *full text search* semantics to query an index.

## Full text search

Full text search describes search solutions that parse text-based document contents to find query terms. Full text search queries in Azure AI Search are based on the *Lucene* query syntax, which provides a rich set of query operations for searching, filtering, and sorting data in indexes. Azure AI Search supports two variants of the Lucene syntax:

- **Simple** - An intuitive syntax that makes it easy to perform basic searches that match literal query terms submitted by a user.
- **Full** - An extended syntax that supports complex filtering, regular expressions, and other more sophisticated queries.

Client applications submit queries to Azure AI Search by specifying a search expression along with other parameters that determine how the expression is evaluated and the results returned. Some common parameters submitted with a query include:

- **search** - A search expression that includes the terms to be found.
- **queryType** - The Lucene syntax to be evaluated (*simple* or *full*).
- **searchFields** - The index fields to be searched.
- **select** - The fields to be included in the results.
- **searchMode** - Criteria for including results based on multiple search terms. For example, suppose you search for *comfortable hotel*. A searchMode value of *Any* returns documents that contain "comfortable", "hotel", or both; while a searchMode value of *All* restricts results to documents that contain both "comfortable" and "hotel".

Query processing consists of four stages:

1. *Query parsing*. The search expression is evaluated and reconstructed as a tree of appropriate subqueries. Subqueries might include *term queries* (finding specific individual words in the search expression - for example *hotel*), *phrase queries* (finding multi-term phrases specified in quotation marks in the search expression - for example, *"free parking"*), and *prefix queries* (finding terms with a specified prefix - for example *air\**, which would match *airway*, *air-conditioning*, and *airport*).
2. *Lexical analysis* - The query terms are analyzed and refined based on linguistic rules. For example, text is converted to lower case and nonessential *stopwords* (such as "the", "a", "is", and so on) are removed. Then words are converted to their *root* form (for example, "comfortable" might be simplified to "comfort") and composite words are split into their constituent terms.
3. *Document retrieval* - The query terms are matched against the indexed terms, and the set of matching documents is identified.
4. *Scoring* - A relevance score is assigned to each result based on a term frequency/inverse document frequency (TF/IDF) calculation.

> [!NOTE]
> For more information about querying an index, and details about **simple** and **full** syntax, see [Query types and composition in Azure AI Search](/azure/search/search-query-overview) in the Azure AI Search documentation.
