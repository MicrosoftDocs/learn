> [!Note]
> **Sarah: Action items**
> 
> - Try it yourself block needa Input and Output code, and Hint text. Search on TBD.
> - Need output cell content. Search on TBD.
>

Now that we know how to use the Text Analytics API to detect the language, let's use it for sentiment analysis. Basically, the computers at the other end of the API connection will judge the sentiments of written phrases (anywhere on the spectrum of positive to negative) based solely on the context clues provided by the text.

```python
# Verify the API URl source for the Sentiment Analysis API
sentiment_api_url = text_analytics_base_url + "sentiment"
print(sentiment_api_url)
```

The output is:

```Output
TBD
```

As above, the Sentiment Analysis API requires the language to be passed in as documents with `id` and `text` attributes.

```python
documents = {'documents' : [
  {'id': '1', 'language': 'en', 'text': 'I had a wonderful experience! The rooms were wonderful and the staff was helpful.'},
  {'id': '2', 'language': 'en', 'text': 'I had a terrible time at the hotel. The staff was rude and the food was awful.'},  
  {'id': '3', 'language': 'es', 'text': 'Los caminos que llevan hasta Monte Rainier son espectaculares y hermosos.'},  
  {'id': '4', 'language': 'es', 'text': 'La carretera estaba atascada. Había mucho tráfico el día de ayer.'}
]}
```

Here's the output:

```Output
TBD
```

Let's analyze the text using the Sentiment Analysis API to output a sentiment analysis score:

```python
headers   = {"Ocp-Apim-Subscription-Key": subscription_key}
response  = requests.post(sentiment_api_url, headers=headers, json=documents)
sentiments = response.json()
pprint(sentiments)
```

The output is:

```Output
TBD
```

### Try it yourself

Create another document set with varying degree of sentiment and use the Sentiment Analysis API to detect what the sentiment is.

<br />

<details> 

  <summary>Hint - TBD <i>(expand to reveal)</i></summary>

  ```python
  tbd
  ```

  ```Output
  tbd
  ```
  
</details>

<br /><br />

***
