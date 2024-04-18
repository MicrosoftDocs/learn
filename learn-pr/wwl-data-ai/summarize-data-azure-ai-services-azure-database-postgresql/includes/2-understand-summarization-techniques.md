**Azure AI Services** and **Azure OpenAI** offer powerful text summarization techniques. These techniques allow you to condense lengthy documents, articles, or conversations into succinct summaries, making information more accessible and actionable. Summarization saves time by presenting essential information quickly.

As a developer for Margie's Travel, you want to understand the summarization techniques accessible via the `azure_ai` extension and Azure AI Services, including Azure OpenAI, and evaluate the ability of each method to generate a concise, natural language summary of lengthy property descriptions, such as:

"_Make yourself at home in this charming one-bedroom apartment, centrally located on the west side of Queen Anne Hill. This elegantly decorated, private apartment (bottom unit of a duplex) has: an open floor plan, bamboo floors, a fully equipped kitchen, a TV, DVD player, basic cable, and a cozy bedroom with a queen-size bed. The unit sleeps up to four (two in the bedroom and two on the comfortable fold-out couch, linens included) and includes free Wi-Fi and laundry. The apartment opens onto a private deck, complete with its own barbecue, overlooking a garden and a forest of black bamboo. The Apartment is perfectly located just one block from the bus lines where you can catch a bus and be downtown Seattle in 15 minutes or historic Ballard in 10. A quick five-minute walk brings you to a natural grocery store and coffee shops. Or just take a fifteen-minute walk to the top of Queen Anne Hill where you find various eclectic stores, bars, and restaurants._"

## Extractive summarization

Extractive summarization produces a summary by extracting essential sentences directly from the original text. Instead of generating new text, it uses natural language processing techniques to locate the sentences that collectively convey a document's primary idea or context. Extractive summarization is accomplished with the `summarize_extractive()` function found in the `azure_cognitive` schema of the `azure_ai` extension. It works by integrating the Azure AI Language service. It returns the extracted sentence and a rank score for each one. The rank score, a value between 0 and 1 (inclusive), indicates how relevant a sentence is to the main idea of a document. For example, if you request a two-sentence summary of the above property description, extractive summarization returns the two highest-scored sentences from the original text:

- "_Make yourself at home in this charming one-bedroom apartment, centrally located on the west side of Queen Anne Hill._"
- "_This elegantly decorated, private apartment (bottom unit of a duplex) has: an open floor plan. bamboo floors, a fully equipped kitchen, a TV, DVD player, basic cable, and a cozy bedroom with a queen-size bed._"

## Abstractive summarization

Abstractive summarization relies on the natural language processing capabilities of large language models, like Azure OpenAI, to create original sentences that capture the main idea of the original content. It generates summarized sentences by paraphrasing and rephrasing the original content. This method allows for more flexibility and creativity, capturing essential information while allowing for concise expression. Abstractive summarization is accomplished with the `summarize_abstractive()` function found in the `azure_cognitive` schema of the `azure_ai` extension. When you use the same previous example listing description, the abstractive summary generated is:

_"The one-bedroom apartment, located on the west side of Queen Anne Hill, is a private unit with: an open floor plan, bamboo floors, a fully equipped kitchen, and a queen-size bed that can accommodate up to four people. The apartment is conveniently located near bus lines, a grocery store, coffee shops, and various stores and restaurants, and offers a private deck with a barbecue overlooking a garden and a forest of black bamboo._"

## Query-focused summarization

Query-focused summarization tailors the summary generated based on a query or topic to enhance relevance and precision. Similar to abstractive summarization, it uses the power of large language models (LLMs) to generate original summaries. By incorporating user queries, you can create summaries that directly address the information users seek. Whether summarizing call center conversations, property descriptions, or user-generated content, query-based summarization ensures relevance and precision. Using query-focused summarization, you must provide a prompt that instructs the LLM how to formulate the summary, such as:

"Provide a concise two-sentence summary of the following text, focusing on the most desirable features of the property for families:"

For the example listing description, query-focused summarization could generate a summary like this:

"_This one-bedroom apartment is ideal for families, as it can accommodate up to four people with its queen-size bed and open floor plan, and is also equipped with a flat-screen TV, Wi-Fi, and a washer and dryer. The apartment is conveniently located near bus lines, grocery stores, coffee shops, and various stores and restaurants, and offers a private deck with a barbecue overlooking a garden and a forest of black bamboo._"

Query-focused summarization capabilities aren't available directly through the `azure_ai` extension, so to incorporate this functionality into the Margie's Travel apps, you must connect to the Azure OpenAI REST API to make these calls.
