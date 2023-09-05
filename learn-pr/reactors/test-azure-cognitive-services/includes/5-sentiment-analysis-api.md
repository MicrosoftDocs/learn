You just learned how to use the Azure AI services Text Analytics API to detect language. Now let's use it for sentiment analysis. The computers at the other end of the API connection will judge the sentiments of written phrases based solely on the context clues provided by the text. Sentiments will be ranked on the spectrum of positive to negative.

```python
# Verify the API URL source for the Sentiment Analysis API
sentiment_api_url = text_analytics_base_url + "sentiment"
print(sentiment_api_url)
```

The output is:

```output
https://westcentralus.api.cognitive.microsoft.com/text/analytics/v2.1/sentiment
```

As shown, the Azure AI services Sentiment Analysis API requires the language to be passed in as documents with `id` and `text` attributes.

```python
documents = {'documents' : [
  {'id': '1', 'language': 'en', 'text': 'I had a wonderful experience! The rooms were wonderful and the staff was helpful.'},
  {'id': '2', 'language': 'en', 'text': 'I had a terrible time at the hotel. The staff was rude and the food was awful.'},  
  {'id': '3', 'language': 'es', 'text': 'Los caminos que llevan hasta Monte Rainier son espectaculares y hermosos.'},  
  {'id': '4', 'language': 'es', 'text': 'La carretera estaba atascada. Había mucho tráfico el día de ayer.'}
]}
```

Let's analyze the text by using the Sentiment Analysis API to output a sentiment analysis score:

```python
headers   = {"Ocp-Apim-Subscription-Key": subscription_key}
response  = requests.post(sentiment_api_url, headers=headers, json=documents)
sentiments = response.json()
pprint(sentiments)
```

The output is:

```output
{'documents': [{'id': '1', 'score': 0.9708490371704102},
               {'id': '2', 'score': 0.0019068121910095215},
               {'id': '3', 'score': 0.7456425428390503},
               {'id': '4', 'score': 0.334433376789093}],
 'errors': []}
```

### Try it yourself

Create another document set with varying degrees of sentiment. Use the Sentiment Analysis API to detect what the sentiment is.

<br />

<details>

  <summary>Hint - TBD <i>(expand to reveal)</i></summary>

  Here's the input:

  ```python
  documents = {'documents' : [
  {'id': '1', 'language': 'en', 'text': 'I think this is amazingly horrible.'},
  {'id': '2', 'language': 'en', 'text': 'Ihad such an incredibly good day.'},  
  {'id': '3', 'language': 'es', 'text': 'Creo que voy a vomitar.'},  
  {'id': '4', 'language': 'es', 'text': 'Me gusto esta experiencia mucho.'}
  ]}
  headers   = {"Ocp-Apim-Subscription-Key": subscription_key}
  response  = requests.post(sentiment_api_url, headers=headers, json=documents)
  sentiments = response.json()
  pprint(sentiments)
  ```

  The output is:

  ```output
  {'documents': [{'id': '1', 'score': 0.09269934892654419},
               {'id': '2', 'score': 0.9604779481887817},
               {'id': '3', 'score': 0.1336020827293396},
               {'id': '4', 'score': 0.5463340282440186}],
  'errors': []}
  ```

</details>

<br /><br />

***
