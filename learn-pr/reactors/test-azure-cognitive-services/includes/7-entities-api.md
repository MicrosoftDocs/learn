> [!Note]
> **Sarah: Conversion feedback**
> 
> - Suggest moving the **Takeaway** at the end of the unit, to the list of Learning objectives
>    in the Introduction unit or to the abstract summary in the module index.yml.

> [!Note]
> **Sarah: Action items**
> 
> - Try it yourself block needa Input and Output code, and Hint text. Search on TBD.
> - Need output cell content. Search on TBD.
> - Last paragraph needs some tweaking regarding: "eight sections".
>

The final API we will use in the Text Analytics API service is the Entities API. This will retrieve attributes for documents provided to the API service.

```python
# Configure the Entities URI
entity_linking_api_url = text_analytics_base_url + "entities"
print(entity_linking_api_url)
```

The output is:

```Output
TBD
```

The next step is creating a document with id and text attributes to pass on to the Entities API.

```python
documents = {'documents' : [
  {'id': '1', 'text': 'Microsoft is an It company.'}
]}
```

Here's the output:

```Output
TBD
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
TBD
```

### Try it yourself

What other entities can be retrieved with the API? Create a document setup and use the Text Analytics, Sentiment Analysis, Key Phrase, and Entities API services to retrieve the data.

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

> [!div class="alert is-tip"]
> ### Takeaway
>
>  In this subsection, you explored text analytics in the cloud. Specifically, you used a variety of different APIs to extract different information from text: language, sentiment, key phrases, and entities.

<br />
That's it for the instructional portion of this course. In these eight sections <!-- Sarah, confirm 'eight' and replace 'sections' with units or topics -->, you've now seen the range of tools that go into preparing data for analysis and performing ML and AI analysis on data. In the next, concluding section, you will bring these skills together in a final project.
