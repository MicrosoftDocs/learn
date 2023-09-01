We've detected the language type by using the Azure AI services Text Analytics API and the sentiment by using the Sentiment Analysis API. What if we want to detect key phrases in the text? We can use the Key Phrases API.

```python
# As with the other services, set up the Key Phrases API with the following parameters
key_phrase_api_url = text_analytics_base_url + "keyPhrases"
print(key_phrase_api_url)
```

The output is:

```output
https://westcentralus.api.cognitive.microsoft.com/text/analytics/v2.1/keyPhrases
```

Create the documents needed to pass to the Key Phrases API with the `id` and `text` attributes.

```python
documents = {'documents' : [
  {'id': '1', 'language': 'en', 'text': 'I had a wonderful experience! The rooms were wonderful and the staff was helpful.'},
  {'id': '2', 'language': 'en', 'text': 'I had a terrible time at the hotel. The staff was rude and the food was awful.'},  
  {'id': '3', 'language': 'es', 'text': 'Los caminos que llevan hasta Monte Rainier son espectaculares y hermosos.'},  
  {'id': '4', 'language': 'es', 'text': 'La carretera estaba atascada. Había mucho tráfico el día de ayer.'}
]}
```

Now, call the Key Phrases API with the formatted documents to retrieve the key phrases.

```python
headers   = {'Ocp-Apim-Subscription-Key': subscription_key}
response  = requests.post(key_phrase_api_url, headers=headers, json=documents)
key_phrases = response.json()
pprint(key_phrases)
```

The output is:

```output
{'documents': [{'id': '1',
                'keyPhrases': ['wonderful experience', 'staff', 'rooms']},
               {'id': '2',
                'keyPhrases': ['food', 'terrible time', 'hotel', 'staff']},
               {'id': '3', 'keyPhrases': ['Monte Rainier', 'caminos']},
               {'id': '4', 'keyPhrases': ['carretera', 'tráfico', 'día']}],
 'errors': []}
```

We can make this output easier to read by outputting the documents in an HTML table format.

```python
table = []
for document in key_phrases["documents"]:
    text    = next(filter(lambda d: d["id"] == document["id"], documents["documents"]))["text"]    
    phrases = ",".join(document["keyPhrases"])
    table.append("<tr><td>{0}</td><td>{1}</td>".format(text, phrases))
HTML("<table><tr><th>Text</th><th>Key phrases</th></tr>{0}</table>".format("\n".join(table)))
```

Here's the output:

```output
| Text                                                                              | Key phrases                      |
| I had a wonderful experience! The rooms were wonderful and the staff was helpful. | wonderful experience,staff,rooms |
| I had a terrible time at the hotel. The staff was rude and the food was awful.    | food,terrible time,hotel,staff   |
| Los caminos que llevan hasta Monte Rainier son espectaculares y hermosos.         | Monte Rainier,caminos            |
| La carretera estaba atascada. Había mucho tráfico el día de ayer.                 | carretera,tráfico,día            |
```

Now call the Key Phrases API with the formatted documents to retrieve the key phrases.

### Try it yourself

What other key phrases can you come up with for analysis?

<br />

<details>

  <summary>Hint <i>(expand to reveal)</i></summary>

  Here's the input:

  ```python
  documents = {'documents' : [
    {'id': '1', 'language': 'en', 'text': 'This was a great experience overall. I particularly loved the demos.'},
    {'id': '2', 'language': 'en', 'text': 'I never want to come back here. The audio was horrendous.'}
  ]}
  headers   = {'Ocp-Apim-Subscription-Key': subscription_key}
  response  = requests.post(key_phrase_api_url, headers=headers, json=documents)
  key_phrases = response.json()
  pprint(key_phrases)
  table = []
  for document in key_phrases["documents"]:
      text    = next(filter(lambda d: d["id"] == document["id"], documents["documents"]))["text"]    
      phrases = ",".join(document["keyPhrases"])
      table.append("<tr><td>{0}</td><td>{1}</td>".format(text, phrases))
  HTML("<table><tr><th>Text</th><th>Key phrases</th></tr>{0}</table>".format("\n".join(table)))
  ```

  The output is:

  ```output
  {'documents': [{'id': '1', 'keyPhrases': ['great experience', 'demos']},
               {'id': '2', 'keyPhrases': ['audio']}],
  'errors': []}

  | Text | Key phrases |
  | This was a great experience overall. I particularly loved the demos. | great experience,demos |
  | I never want to come back here. The audio was horrendous. | audio |
  ```

</details>

<br /><br />

***
