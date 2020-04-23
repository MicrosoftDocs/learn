> [!Note]
> **Sarah: Action items**
> 
> - Try it yourself block needa Input and Output code, and Hint text. Search on TBD.
> - Need output cell content. Search on TBD.
>

Now it's time to start processing some text languages.

To verify the URL endpoint for `text_analytics_base_url`, run the following:

```python
language_api_url = text_analytics_base_url + "languages"
print(language_api_url)
```

The output is:

```Output
TBD
```

The API requires that the payload be formatted in the form of documents containing `id` and `text` attributes:

```python
    { 'id': '1', 'text': 'This is a document written in English.' },
    { 'id': '2', 'text': 'Este es un documento escrito en Español.' },
    { 'id': '3', 'text': '这是一个用中文写的文件' },
    { 'id': '4', 'text': 'Ez egy magyar nyelvű dokumentum.' },
    { 'id': '5', 'text': 'Dette er et dokument skrevet på dansk.' },
    { 'id': '6', 'text': 'これは日本語で書かれた文書です。' }
]}
```

Here's the output:

```Output
TBD
```

The next lines of code call the API service using the requests library to determine the languages that were passed in from the documents:

```python
headers   = {"Ocp-Apim-Subscription-Key": subscription_key}
response  = requests.post(language_api_url, headers=headers, json=documents)
languages = response.json()
pprint(languages)
```

The output is:

```Output
TBD
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

```Output
TBD
```

The service did a pretty good job of identifying the languages. It did confidently identify the Danish phrase as being Norwegian, but in fairness, even linguists argue as to whether Danish and Norwegian constitute distinct languages or are dialects of the same language. (Note that Danes and Norwegians have no doubts on the subject.)

### Try it yourself

Create another document set of text and use the Text Analytics API to detect the language for the text.

<br />

<details> 

  <summary>Hint - TBD <i>(expand to reveal)</i></summary>

  Here's the input:
  
  ```python
  tbd
  ```

  The output is:
  
  ```Output
  tbd
  ```
  
</details>

<br /><br />

***
