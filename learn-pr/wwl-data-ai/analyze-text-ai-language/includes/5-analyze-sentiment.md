
Sentiment analysis is used to evaluate how positive or negative a text document is, which can be useful in various workloads, such as:

- Evaluating a movie, book, or product by quantifying sentiment based on reviews.
- Prioritizing customer service responses to correspondence received through email or social media messaging.

When using Azure Language to evaluate sentiment, the response includes overall document sentiment and individual sentence sentiment for each document in the input.

```python
# Example text to analyze
documents = ["My favorite lyric. 'What a wonderful world!'",
             "These lyrics are so sad. " \
             "'Only the lonely know the heartaches I've been through." \
             "Only the lonely Know I cry and cry for you.'"]

# Analyze sentiment
response = client.analyze_sentiment(documents=documents)
for doc in response:
    print(f"Document: {doc.id}: {doc.sentiment} ({doc.confidence_scores})")
    for sentence in doc.sentences:
        print(f"\tSentence: {sentence.text}")
        print(f"\t\tSentiment: {sentence.sentiment} ({sentence.confidence_scores})")

```

The response for this input might look something like this:

```output
Document: 0: positive ({'positive': 0.99, 'neutral': 0.0, 'negative': 0.0})
        Sentence: My favorite lyric. 
                Sentiment: positive ({'positive': 1.0, 'neutral': 0.0, 'negative': 0.0})
        Sentence: 'What a wonderful world!'
                Sentiment: positive ({'positive': 0.99, 'neutral': 0.01, 'negative': 0.0})
Document: 1: negative ({'positive': 0.01, 'neutral': 0.08, 'negative': 0.9})
        Sentence: These lyrics are so sad.
                Sentiment: negative ({'positive': 0.0, 'neutral': 0.0, 'negative': 1.0})
        Sentence: 'Only the lonely know the heartaches I've been through.
                Sentiment: negative ({'positive': 0.01, 'neutral': 0.1, 'negative': 0.89})
        Sentence: Only the lonely Know I cry and cry for you.'
                Sentiment: negative ({'positive': 0.04, 'neutral': 0.15, 'negative': 0.81})
```

Sentence sentiment is based on confidence scores for **positive**, **negative**, and **neutral** classification values between 0 and 1.

Overall document sentiment is based on sentences:

- If all sentences are neutral, the overall sentiment is neutral.
- If sentence classifications include only positive and neutral, the overall sentiment is positive.
- If the sentence classifications include only negative and neutral, the overall sentiment is negative.
- If the sentence classifications include positive and negative, the overall sentiment is  mixed.
