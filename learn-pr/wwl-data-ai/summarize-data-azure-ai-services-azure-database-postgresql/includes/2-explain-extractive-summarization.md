[Extractive summarization](/azure/ai-services/language-service/summarization/how-to/document-summarization#try-document-extractive-summarization) produces a summary by extracting essential sentences directly from the original text. Instead of generating new text, it uses natural language processing techniques to locate the sentences that collectively convey a document's primary idea or context.

Extractive summarization is accomplished using the `summarize_extractive()` function found in the `azure_cognitive` schema of the `azure_ai` extension. The `azure_cognitive` schema contains three overloads of the `summarize_extractive()` function. The list of arguments the three function overloads expect include:

| Argument | Type | Default | Description |
| -------- | ---- | ------- | ----------- |
| text | `text` or `text[]` || The text(s) for which summaries should be generated. |
| language_text | `text` or `text[]` || Language code (or array of language codes) representing the language of the text to summarize. Review the [list of supported languages](/azure/ai-services/language-service/summarization/language-support) to retrieve the necessary language codes. |
| sentence_count | `integer` | 3 | The number of summary sentences to generate. |
| sort_by | `text` | 'offset' | The sort order for the generated summary sentences. Acceptable values are "offset" and "rank," with offset representing the start position of each extracted sentence within the original content and rank being an AI-generated indicator of how relevant a sentence is to the main idea of the content. |
| batch_size | `integer` | 25 | Only for the two overload expecting an input of `text[]`. Specifies the number of records to process at a time. |
| disable_service_logs | `boolean` | false | Flag indicating whether to turn off service logs. |
| timeout_ms | `integer` | NULL | Timeout in milliseconds after which the operation is stopped. |
| throw_on_error | `boolean` | true | Flag indicating whether the function should, on error, throw an exception resulting in a rollback of the wrapping transaction. |
| max_attempts | `integer` | 1 | Number of times to retry the call to Azure AI Services in the event of a failure. |
| retry_delay_ms | `integer` | 1000 | Amount of time, in milliseconds, to wait before attempting to retry calling the Azure AI Services endpoint. |

Each function returns an array of extracted sentences and a rank score for each one, using the `azure_cognitive.sentence` composite type, as shown in the table below:

```sql
            Composite type "azure_cognitive.sentence"
    Column  |       Type       | Collation | Nullable | Default | Storage  | Description 
------------+------------------+-----------+----------+---------+----------+-------------
 text       | text             |           |          |         | extended | 
 rank_score | double precision |           |          |         | plain    |
```

The `azure_cognitive.sentence` is a composite type containing the text of an extractive sentence and a rank score for each sentence. The rank score, a value between 0 and 1 (inclusive), indicates how relevant a sentence is to the main idea of the original document. Document summarization ranks extracted sentences, and you can determine whether they're returned in the order they appear or according to their rank using the `sort_by` parameter of the function.

## Generate extractive summaries for property descriptions

As a developer for Margie's Travel, you want to evaluate the extractive summarization technique accessible via the `azure_ai` extension and Azure AI Services and evaluate the ability of the method to generate concise, natural language summaries of lengthy property descriptions, such as this description from the first listing in the database:

_"Make yourself at home in this charming one-bedroom apartment, centrally located on the west side of Queen Anne Hill. This elegantly decorated, private apartment (bottom unit of a duplex) has an open floor plan, bamboo floors, a fully equipped kitchen, a TV, DVD player, basic cable, and a cozy bedroom with a queen-size bed. The unit sleeps up to four (two in the bedroom and two on the comfortable fold-out couch, linens included) and includes free Wi-Fi and laundry. The apartment opens onto a private deck, complete with its own barbecue, overlooking a garden and a forest of black bamboo. The Apartment is perfectly located just one block from the bus lines where you can catch a bus and be downtown Seattle in 15 minutes or historic Ballard in 10. A quick five-minute walk brings you to a natural grocery store and coffee shops. Or just take a fifteen-minute walk to the top of Queen Anne Hill where you find various eclectic stores, bars, and restaurants."_

You request a two-sentence summary of the above property description using the following query:

```sql
SELECT
  azure_cognitive.summarize_extractive(description, 'en', 2) AS extractive_summary
FROM listings
WHERE id = 1;
```

Extractive summarization returns the two highest-scored sentences from the original text, along with the rank score for each:

```sql
{
  "("Make your self at home in this charming one-bedroom apartment, centrally-located on the west side of Queen Anne hill.",1)",
  "("This elegantly-decorated, completely private apartment (bottom unit of a duplex) has an open floor plan, bamboo floors, a fully equipped kitchen, a TV, DVD player, basic cable, and a very cozy bedroom with a queen-size bed.",0.49)"
}
```
