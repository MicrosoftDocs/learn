
Key phrase extraction is the process of evaluating the text of a document, or documents, and then identifying the main points around the context of the document(s).

Key phrase extraction works best for larger documents (the maximum size that can be analyzed is 5,120 characters).

As with language detection, the REST interface enables you to submit one or more documents for analysis.

```python
# Example text to analyze
documents = ["You must be the change you wish to see in the world.",
             "The journey of a thousand miles begins with a single step."]

# Extract key phrases
response = client.extract_key_phrases(documents=documents)
for doc in response:
    print(f"Key phrases in document {doc.id}:")
    for phrase in doc.key_phrases:
        print(f"\t{phrase}")
```

The response contains a list of key phrases detected in each document:

```output
Key phrases in document 0:
        change
        world
Key phrases in document 1:
        thousand miles
        single step
        journey
```
