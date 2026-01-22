Organizations often store large amounts of unstructured text, such as product details, customer reviews, or service descriptions. While this information contains useful insights, it can be difficult to scan quickly or use effectively in applications. Without a way to condense text into shorter summaries, both employees and customers could struggle to identify the most important details.  

Let’s consider how a managed travel company deals with this challenge. *Margie’s Travel*, which manages vacation rentals, stores long property descriptions in their PostgreSQL database. Each listing includes paragraphs about amenities, location, and nearby attractions. While this information is helpful, customers who are browsing multiple properties don’t always have time to read every detail. Margie’s Travel wants a way to generate shorter summaries that highlight the most important features. Customers can use these summaries to compare listings quickly and make confident booking decisions.  

Azure AI Services, through the `azure_ai` extension, provides summarization functions that make those summaries possible. In this unit, you learn how to use two summarization approaches: **extractive summarization** and **abstractive summarization**.  

## Extractive summarization

Extractive summarization selects the most important sentences from the original text. Instead of creating new wording, it surfaces sentences that best represent the main ideas.  

Margie’s Travel can use this method to pull out the most relevant parts of a property description without altering the language. For example, if a description includes 10 sentences, an extractive summary might return two that mention the apartment’s layout and its convenient location near public transit.  

In PostgreSQL, this summary is done with the `azure_cognitive.summarize_extractive()` function. The function accepts parameters such as:  
- **Text** to summarize.  
- **Language code** for the text.  
- **Sentence count** to control how many summary sentences you want.  
- **Sort order** to decide whether results are returned by sentence position or by relevance score.  

The function returns sentences with a rank score that shows how closely each one relates to the main idea of the document. For Margie’s Travel, this function makes it easy to reduce a full property description to just the most important sentences.  

## Abstractive summarization

Abstractive summarization creates new sentences that capture the meaning of the original text. Instead of selecting from the source, it rephrases and condenses the content into a shorter, more natural summary.  

Margie’s Travel can use this method when they want property listings to be easier to read at a glance. Instead of pulling whole sentences from the original, the summary might combine details about amenities and location into one smooth statement. For customers, this means they can scan through multiple listings quickly without losing the key context.  

In PostgreSQL, abstractive summarization is done with the `azure_cognitive.summarize_abstractive()` function. It takes similar parameters—text, language, and sentence count—and generates a concise summary in just a few sentences.  

## When to use each technique

Both methods are valuable, but they serve different needs:

- **Extractive summarization** works best when factual accuracy is most important and you need to keep the original wording intact. Margie’s Travel might use this method for internal reporting or quality reviews, where staff need to see key sentences exactly as written.

- **Abstractive summarization** is better when readability and flow are a priority. Margie’s Travel could apply this method for customer-facing listings, where a smooth and concise summary helps customers compare properties more quickly.  

By applying these summarization techniques with Azure AI Services, Margie’s Travel can make property listings easier to consume, improve the customer booking experience, and keep all data processing inside Azure Database for PostgreSQL.  

## Key takeaways

In this unit, you learn how to summarize text with Azure AI Services in Azure Database for PostgreSQL. Extractive summarization highlights the most important sentences from the original text, while abstractive summarization creates new sentences that express the meaning more naturally. Both approaches make long passages easier to work with and help applications present information in a clear, concise way.  
