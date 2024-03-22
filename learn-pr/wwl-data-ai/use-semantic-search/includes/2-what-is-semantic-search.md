Semantic ranking is a capability within Azure AI Search that aims to improve the ranking of search results. Semantic ranking improves the ranking of search results by using language understanding to more accurately match the context of the original query.

## BM25 ranking function

Azure AI Search uses the BM25 ranking function, by default. The BM25 ranking function ranks search results based on the frequency that the search term appears within a document. The BM25 ranking function will often achieve excellent ranking results, because a document that frequently includes a search term is often the most relevant, however, this isn't always the case. BM25 ranking doesn't place any relevance on the semantics of the query and ranking can sometimes be improved by adding language understanding.

## Semantic ranking

Semantic ranking has two functions; it improves the ranking of the query results based on language understanding and it improves the response to the query by providing captions and answers in the results.

Semantic ranking uses the BM25 ranking and calculates a new relevance score using the original BM25 ranking combined with language understanding models to extract the context and meaning of the query.

### Semantic captions and answers

Semantic captions and answers provide additional results alongside the ranked search results that you can display to improve the understanding of the results for users.

Semantic captions extract summary sentences from the document verbatim and highlight the most relevant text in the summary sentences.

Semantic answers is an optional additional feature of semantic ranking that provides answers to questions. If the search query appears to be a question and the search results contains text that appears to be a relevant answer, then the semantic answer is returned.

## How semantic ranking works

Semantic ranking takes the top 50 results from the BM25 ranking results. The results are split into multiple fields as defined by a semantic configuration. The fields are converted into text strings and trimmed to 256 unique tokens. A token is roughly equivalent to a word in the document.

Once the strings are prepared, they are passed to machine reading comprehension models to find the phrases and sentences that best match the query. The results of this summarization phrase is a semantic caption and, optionally, a semantic answer.

The semantic captions are now ranked based on the semantic relevance of the caption. The results are then returned in descending order of relevance.

## Semantic ranking capabilities

See the following video for an overview of the capabilities of AI Search:

> [!VIDEO https://www.youtube.com/embed/yOf0WfVd_V0?si=_xY1s8AytK0R-ohY]

## Semantic ranking advantages

Semantic ranking has two key advantages over traditional search results:

* Semantic ranking can rank results to more closely match the semantics of the original query. This can make it more likely hat the most useful documents appear at the top of the search results.
* Semantic ranking can find strings within the results to render as a caption on the search results page and to provide an answer to a question.

## Semantic ranking limitations

Semantic ranking is applied to results returned from the BM25 ranking function. Although semantic ranking can re-rank the results provided by the BM25 ranking function, it will not provide any additional documents that weren't returned by the BM25 ranking function.

Semantic ranking uses the top 50 results from the BM25 ranking function. If more than 50 results are returned, only the top 50 results are considered.

## Semantic ranking pricing

Up to 1000 semantic ranking queries a month are available free of charge.

For more than 1000 queries a month, you should choose standard pricing. The cost of standard pricing is based on the volume of searches, the type of searches, and the region of the search.

For more information on semantic ranking pricing, see [Azure AI Search pricing](https://azure.microsoft.com/pricing/details/search/)
