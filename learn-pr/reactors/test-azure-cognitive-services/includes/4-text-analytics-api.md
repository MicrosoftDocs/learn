Now it's time to start processing some text languages.

To verify the URL endpoint for `text_analytics_base_url`, run the following code:

```python
language_api_url = text_analytics_base_url + "languages"
print(language_api_url)
```

The output is:

```output
https://westcentralus.api.cognitive.microsoft.com/text/analytics/v2.1/languages
```

The API requires that the payload be formatted in the form of documents that contain `id` and `text` attributes:

```python
    { 'id': '1', 'text': 'This is a document written in English.' },
    { 'id': '2', 'text': 'Este es un documento escrito en Español.' },
    { 'id': '3', 'text': '这是一个用中文写的文件' },
    { 'id': '4', 'text': 'Ez egy magyar nyelvű dokumentum.' },
    { 'id': '5', 'text': 'Dette er et dokument skrevet på dansk.' },
    { 'id': '6', 'text': 'これは日本語で書かれた文書です。' }
]}
```

The next lines of code call the API service by using the requests library to determine the languages that were passed in from the documents:

```python
headers   = {"Ocp-Apim-Subscription-Key": subscription_key}
response  = requests.post(language_api_url, headers=headers, json=documents)
languages = response.json()
pprint(languages)
```

The output is:

```output
{'documents': [{'detectedLanguages': [{'iso6391Name': 'en',
                                       'name': 'English',
                                       'score': 1.0}],
                'id': '1'},
               {'detectedLanguages': [{'iso6391Name': 'es',
                                       'name': 'Spanish',
                                       'score': 1.0}],
                'id': '2'},
               {'detectedLanguages': [{'iso6391Name': 'zh_chs',
                                       'name': 'Chinese_Simplified',
                                       'score': 1.0}],
                'id': '3'},
               {'detectedLanguages': [{'iso6391Name': 'hu',
                                       'name': 'Hungarian',
                                       'score': 1.0}],
                'id': '4'},
               {'detectedLanguages': [{'iso6391Name': 'no',
                                       'name': 'Norwegian',
                                       'score': 1.0}],
                'id': '5'},
               {'detectedLanguages': [{'iso6391Name': 'ja',
                                       'name': 'Japanese',
                                       'score': 1.0}],
                'id': '6'}],
 'errors': []}
```

The next line of code outputs the documents in a table format with the language information for each document:

```python
table = []
for document in languages["documents"]:
    text  = next(filter(lambda d: d["id"] == document["id"], documents["documents"]))["text"]
    langs = ", ".join(["{0}({1})".format(lang["name"], lang["score"]) for lang in document["detectedLanguages"]])
    table.append("<tr><td>{0}</td><td>{1}</td>".format(text, langs))
HTML("<table><tr><th>Text</th><th>Detected languages(scores)</th></tr>{0}</table>".format("\n".join(table)))
```

Here's the output:

```output
| Text                                     | Detected languages(scores) |
|------------------------------------------|----------------------------|
| This is a document written in English.   | English(1.0)               |
| Este es un documento escrito en Español. | Spanish(1.0)               |
| 这是一个用中文写的文件                     | Chinese_Simplified(1.0)    |
| Ez egy magyar nyelvű dokumentum.         | Hungarian(1.0)             |
| Dette er et dokument skrevet på dansk.   | Norwegian(1.0)             |
| これは日本語で書かれた文書です。            | Japanese(1.0)              |
```

The service did a pretty good job of identifying the languages. It did confidently identify the Danish phrase as being Norwegian. In fairness, even linguists argue whether Danish and Norwegian are distinct languages or are minor languages of the same language. (Danes and Norwegians have no doubts on the subject.)

### Try it yourself

Create another document set of text. Use the Azure AI services Text Analytics API to detect the language for the text.

<br />

<details>

  <summary>Hint <i>(expand to reveal)</i></summary>

  Here's the input:

  ```python
  documents = { 'documents': [
    { 'id': '1', 'text': 'Trying out this new feature' },
    { 'id': '2', 'text': 'Creo que estoy aprendiendo.' }
  ]}
  headers   = {"Ocp-Apim-Subscription-Key": subscription_key}
  response  = requests.post(language_api_url, headers=headers, json=documents)
  languages = response.json()
  pprint(languages)
  table = []
  for document in languages["documents"]:
      text  = next(filter(lambda d: d["id"] == document["id"], documents["documents"]))["text"]
      langs = ", ".join(["{0}({1})".format(lang["name"], lang["score"]) for lang in document["detectedLanguages"]])
      table.append("<tr><td>{0}</td><td>{1}</td>".format(text, langs))
  HTML("<table><tr><th>Text</th><th>Detected languages(scores)</th></tr>{0}</table>".format("\n".join(table)))
  ```

  The output is:

  ```output
  | Text                        | Detected languages(scores) |
  |-----------------------------|----------------------------|
  | Trying out this new feature | English(1.0)               |
  | Creo que estoy aprendiendo. | Spanish(1.0)               |
  ```

</details>

<br /><br />

***
