> [!Note]
> **Sarah: Action items**
> 
> - Line 61: Try it yourself block needs Input and Output code, and Hint text.

The final API we will use in the Text Analytics API service is the Entities API. This will retrieve attributes for documents provided to the API service.

```python
# Configure the Entities URI
entity_linking_api_url = text_analytics_base_url + "entities"
print(entity_linking_api_url)
```

The output is:

```Output
https://westcentralus.api.cognitive.microsoft.com/text/analytics/v2.1/entities
```

The next step is creating a document with id and text attributes to pass on to the Entities API.

```python
documents = {'documents' : [
  {'id': '1', 'text': 'Microsoft is an It company.'}
]}
```

Finally, call the service using the rest call below to retrieve the data listed in the text attribute.

```python
headers = {"Ocp-Apim-Subscription-Key": subscription_key}
response = requests.post(entity_linking_api_url, headers=headers, json=documents)
entities = response.json()
entities
```

The output is:

```Output
{'documents': [{'entities': [{'matches': [{'entityTypeScore': 0.999969482421875,
       'length': 9,
       'offset': 0,
       'text': 'Microsoft'}],
     'name': 'Microsoft',
     'type': 'Organization'},
    {'bingId': 'bc30426e-22ae-7a35-f24b-454722a47d8f',
     'matches': [{'entityTypeScore': 0.8,
       'length': 10,
       'offset': 16,
       'text': 'It company',
       'wikipediaScore': 0.7183870642593111}],
     'name': 'Technology company',
     'type': 'Organization',
     'wikipediaId': 'Technology company',
     'wikipediaLanguage': 'en',
     'wikipediaUrl': 'https://en.wikipedia.org/wiki/Technology_company'}],
   'id': '1'}],
 'errors': []}
```

### Try it yourself

What other entities can be retrieved with the API? Create a document setup and use the Text Analytics, Sentiment Analysis, Key Phrase, and Entities API services to retrieve the data.
