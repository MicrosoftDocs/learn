
The Azure Language detection API evaluates text input and, for each document submitted, returns language identifiers with a score indicating the strength of the analysis.

This capability is useful for content stores that collect arbitrary text, where language is unknown. Another scenario could involve a chat application.  If a user starts a session with the application, language detection can be used to determine which language they're using and allow you to configure your application's responses in the appropriate language.

You can parse the results of this analysis to determine which language is used in the input document. The response also returns a score, which reflects the confidence of the model (a value between 0 and 1).

Language detection can work with documents or single phrases. It's important to note that the document size must be under 5,120 characters.  The size limit is per document and each collection is restricted to 1,000 items (IDs).  A sample of a properly formatted JSON payload that you might submit to the service in the request body is shown here, including a collection of **documents**, each containing a unique **id** and the **text** to be analyzed.

For example, the following Python code analyzes two (short) documents to detect the language in which they're written.

```python
# Assumes code to create TextAnalyticsClient is above...

# Example text to analyze
documents = ["Hello World!", "Bonjour le monde!"]

# Detect language
response = client.detect_language(documents=documents)
for doc in response:
    print(f"Document: {doc.id}")
    print(f"\tPrimary Language: {doc.primary_language.name}")
    print(f"\tISO6391 Name: {doc.primary_language.iso6391_name}")
    print(f"\tConfidence Score: {doc.primary_language.confidence_score}")
```

The response contains a result for each **document** in the request, including the predicted language and a value indicating the confidence level of the prediction.  The confidence level is a value ranging from 0 to 1 with values closer to 1 being a higher confidence level.  Here's an example of a response from the previous code.

```output
Document: 0
        Primary Language: English
        ISO6391 Name: en
        Confidence Score: 0.9
Document: 1
        Primary Language: French
        ISO6391 Name: fr
        Confidence Score: 0.98
```

In our sample, both languages show a high confidence value, mostly because the text is relatively simple and easy to identify the language for.

If you try to detect the language of a document that has multilingual content, for example `I know a cool AI developer. He has a certain je ne sais quoi!`, the response may reflect some ambiguity.  Mixed language content within the same document returns the language with the largest representation in the content, but with a lower positive rating, reflecting the marginal strength of that assessment.

The last condition to consider is when there's ambiguity as to the language content.  The scenario might happen if you submit textual content that the analyzer isn't able to parse, for example because of character encoding issues when converting the text to a string variable.  As a result, the response for the language name and ISO code will be returned as `(unknown)` and the score value will be returned as `0`.  
