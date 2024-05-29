## Abstractive summarization

[Abstractive summarization](/azure/ai-services/language-service/summarization/how-to/document-summarization#try-document-abstractive-summarization) relies on the natural language processing capabilities of generative AI language models, like Azure OpenAI, to create original sentences that capture the main idea of the original content. It generates summarized sentences by paraphrasing and rephrasing the original content. This method allows for more flexibility and creativity, capturing essential information while allowing for concise expression.

Abstractive summarization is accomplished with the `summarize_abstractive()` function found in the `azure_cognitive` schema of the `azure_ai` extension. The `azure_cognitive` schema contains three overloads of the `summarize_abstractive()` function. The list of arguments the three function overloads expect include:

| Argument | Type | Default | Description |
| -------- | ---- | ------- | ----------- |
| text | `text` or `text[]` || The text(s) for which summaries should be generated. |
| language_text | `text` or `text[]` || Language code (or array of language codes) representing the language of the text to summarize. Review the [list of supported languages](/azure/ai-services/language-service/summarization/language-support) to retrieve the necessary language codes. |
| sentence_count | `integer` | 3 | The number of summary sentences to generate. |
| batch_size | `integer` | 25 | Only for the two overload expecting an input of `text[]`. Specifies the number of records to process at a time. |
| disable_service_logs | `boolean` | false | Flag indicating whether to turn off service logs. |
| timeout_ms | `integer` | NULL | Timeout in milliseconds after which the operation is stopped. |
| throw_on_error | `boolean` | true | Flag indicating whether the function should, on error, throw an exception resulting in a rollback of the wrapping transaction. |
| max_attempts | `integer` | 1 | Number of times to retry the call to Azure AI Services in the event of a failure. |
| retry_delay_ms | `integer` | 1000 | Amount of time, in milliseconds, to wait before attempting to retry calling the Azure AI Services endpoint. |

Each function overload returns an array of sentences (`text[]`) containing the generated summary.

## Generate abstractive summaries for property descriptions

As a developer for Margie's Travel, you want to evaluate the abstractive technique accessible via the `azure_ai` extension and Azure AI Services and evaluate the ability of the method to generate concise, natural language summaries of lengthy property descriptions, such as this description from the first listing in the database:

_"Make yourself at home in this charming one-bedroom apartment, centrally located on the west side of Queen Anne Hill. This elegantly decorated, private apartment (bottom unit of a duplex) has an open floor plan, bamboo floors, a fully equipped kitchen, a TV, DVD player, basic cable, and a cozy bedroom with a queen-size bed. The unit sleeps up to four (two in the bedroom and two on the comfortable fold-out couch, linens included) and includes free Wi-Fi and laundry. The apartment opens onto a private deck, complete with its own barbecue, overlooking a garden and a forest of black bamboo. The Apartment is perfectly located just one block from the bus lines where you can catch a bus and be downtown Seattle in 15 minutes or historic Ballard in 10. A quick five-minute walk brings you to a natural grocery store and coffee shops. Or just take a fifteen-minute walk to the top of Queen Anne Hill where you find various eclectic stores, bars, and restaurants."_

You request a two-sentence summary of the above property description using the following query:

```sql
SELECT
  azure_cognitive.summarize_abstractive(description, 'en', 2) AS abstractive_summary
FROM listings
WHERE id = 1;
```

Abstractive summarization returns the two generated sentences:

```sql
{
  "The document describes a one-bedroom apartment located on the west side of Queen Anne Hill. The apartment, which is the bottom unit of a duplex, features an open floor plan, bamboo floors, a fully equipped kitchen, a queen-size bed, and a private deck with a BBQ. It is conveniently located near bus lines, historic Ballard, a grocery store, coffee shops, and various shops and restaurants."
}
```
