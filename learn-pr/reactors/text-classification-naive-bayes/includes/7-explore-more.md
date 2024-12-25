Beyond detecting spam, we can use machine learning to explore the SMS data more deeply. To do so, we can use sophisticated, cloud-based cognitive tools such as Azure AI services.

<a name='azure-ai-services'></a>

## Azure AI services

The advantage of using cloud-based services is that they provide cutting-edge models that you can access without having to train the models. Using better models can help accelerate both your exploration and your use of machine learning.

Azure provides Azure AI services APIs that can be consumed through Python to conduct image recognition, speech recognition, and text recognition, just to name a few. We're going to take a look at using the Azure Text Analytics API.

We'll start by obtaining a Azure AI services API key. Note that you can get a free key for seven days. After that, you'll be required to pay for continued access to the API.

Learn more about [pricing for Azure AI services](https://azure.microsoft.com/pricing/details/cognitive-services/?azure-portal=true).

1. Go to [Try Azure AI services](https://azure.microsoft.com/try/cognitive-services/?azure-portal=true).
1. Select **Language APIs**.
1. By **Text Analytics**, select **Get API key**.
1. In the **Try Cognitive Services for free** window, under **7-day trial**, select **Get stared**.
1. In the **Microsoft Cognitive Services Terms** window, accept the terms of the free trial, and then select **Next**.
1. In the **Sign-in to Continue** window, select your preferred way to sign in to your Azure account.

When you have your API keys in hand, you're ready to start. Substitute the API key that you get for the 7-day trial below `ACCOUNT_KEY`:

```python
# subscription_key = 'ACCOUNT_KEY'
subscription_key = '8efb79ce8fd84c95bd1aa2f9d68ae734'
assert subscription_key
# If you're using a free trial account, this URL does not need to be updated.
# If you're using a paid account, verify that it matches the region where the 
# Text Analytics Service was set up.
text_analytics_base_url = "https://westcentralus.api.cognitive.microsoft.com/text/analytics/v2.1/"
```

We also need to import the NumPy and requests modules:

```python
import numpy as np
import requests
```

The Azure Text Analytics API has a hard limit of 1,000 calls at a time. So, we need to split our 5,572 SMS messages into at least six chunks to run them through Azure:

```python
chunks = np.array_split(df, 6)
for chunk in chunks:
    print(len(chunk))
```

The output is:

```Output
929
929
929
929
928
928
```

Two things that Azure AI services offer are language identification and sentiment analysis. Both are relevant for our dataset, so we'll prepare our data for both by submitting them as JavaScript Object Notation (JSON) documents. We'll prepare the data for language identification first:

```python
# Prepare the header for the JSON document, including your subscription key
headers   = {"Ocp-Apim-Subscription-Key": subscription_key}
# Supply the URL for the language-identification API.
language_api_url = text_analytics_base_url + "languages"
# Iterate over the chunked DataFrame.
for i in range(len(chunks)):
    
    # Reset the indexes within the chunks to avoid problems later on.
    chunks[i] = chunks[i].reset_index()
    
    # Split up the message from the DataFrame and put them in JSON format.
    documents = {'documents': []}
    for j in range(len(chunks[i]['Message'])):
        documents['documents'].append({'id': str(j), 'text': chunks[i]['Message'][j]})
    
    # Call the API and capture the responses.
    response  = requests.post(language_api_url, headers=headers, json=documents)
    languages = response.json()
    
    # Put the identified languages in a list.
    lang_list = []
    for document in languages['documents']:
        lang_list.append(document['detectedLanguages'][0]['name'])
    
    # Put the list of identified languages in a new column of the chunked DataFrame.
    chunks[i]['Language'] = np.array(lang_list)
```

We need perform similar preparation of the data for sentiment analysis:

```python
# Supply the URL for the sentiment-analysis API.
sentiment_api_url = text_analytics_base_url + "sentiment"
# Iterate over the chunked DataFrame.
for i in range(len(chunks)):
    
    # We have already reset the chunk-indexes, so we don't need to do again.
    # Split up the messages from the DataFrame and put them in JSON format.
    documents = {'documents': []}
    for j in range(len(chunks[i]['Message'])):
        documents['documents'].append({'id': str(j), 'text': chunks[i]['Message'][j]})
    
    # Call the API and capture the responses.
    response  = requests.post(sentiment_api_url, headers=headers, json=documents)
    sentiments = response.json()
    
    # Put the identified sentiments in a list.
    sent_list = []
    for document in sentiments['documents']:
        sent_list.append(document['score'])
    # Put the list of identified sentiments in a new column of the chunked DataFrame.
    chunks[i]['Sentiment'] = np.array(sent_list)
```

Now, we need to reassemble our chunked DataFrame:

```python
azure_df = pd.DataFrame(columns=['Index', 'Class', 'Message', 'Language', 'Sentiment'])
for i in range(len(chunks)):
    azure_df = pd.concat([azure_df, chunks[i]])
    if i == 0:
        azure_df['index'] = chunks[i].index
azure_df.set_index('index', inplace=True)
azure_df.drop(['Index'], axis=1, inplace=True)
azure_df.head()
```

The output is:

```Output
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|       | Class  | Language | Length_of_msg | Message                                                                                                                                                     | Sentiment |
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
| index |        |          |               |                                                                                                                                                             |           |
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
| 0     | ham    | English  | 111.0         | Go until jurong point.. Available only in bugis n great world la e buffet... Cine there got amore wat...                                             | 0.855910  |
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
| 1     | ham    | English  | 29.0          | Ok lar... Joking wif u oni...                                                                                                                               | 0.815817  |
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
| 2     | spam   | English  | 155.0         | Free entry in 2 a wkly comp to win FA Cup final tkts 21st May 2005. Text FA to 87121 to receive entry question(std txt rate)T&C's apply 08452810075over18's | 0.500000  |
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
| 3     | ham    | English  | 49.0          | U dun say so early hor... U c already then say...                                                                                                           | 0.692537  |
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
| 4     | ham    | English  | 61.0          | Nah I don't think he goes to usf, he lives aro...                                                                                                           | 0.119618  |
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
```

We can also look at the tail of the DataFrame to check that our indexing worked as expected:

```python
azure_df.tail()
```

The output is:

```Output
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|       | Class  | Language | Length_of_msg | Message                                                                                                                                                          | Sentiment |
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
| index |        |          |               |                                                                                                                                                                  |           |
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
| 5567  | ham    | English  | 160.0         | This is the 2nd time we have tried 2 contact u. U have won the £750 Pound prize. 2 claim is easy, call 087187272008 NOW1! Only 10p per minute. BT-national-rate. | 0.860303  |
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
| 5568  | ham    | English  | 36.0          | Will ü b going to esplanade fr home?                                                                                                                             | 0.795742  |
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
| 5569  | spam   | English  | 57.0          | Pity, * was in mood for that. So...any other suggestions?                                                                                                        | 0.193941  |
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
| 5570  | ham    | English  | 125.0         | The guy did some grousing but I acted like i'd be interested in buying something else next week and he gave it to us for free                                    | 0.249379  |
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
| 5571  | ham    | English  | 26.0          | Rofl. Its true to its name                                                                                                                                       | 0.974917  |
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
```

Let's see if all of the SMS messages were in English (and, if not, how many messages of which languages we're looking at):

```python
azure_df.groupby('Language')['Message'].count().plot(kind='bar')
```

The output is:

```Output
<matplotlib.axes._subplots.AxesSubplot at 0x7fd95f5d3278>
```

:::image type="content" alt-text="Histogram chart that demonstrates the results of language analysis." source="../media/language-analysis.png" loc-scope="Azure":::

The overwhelming majority of the messages are in English, although we have several additional languages in our dataset. Let's look at the actual numbers.

### Try it yourself

Use the `groupby` method to display actual counts of the languages detected in the dataset rather than a bar chart of them.

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

  ```python
  azure_df.groupby('Language')['Message'].count()
  ```

  The output is:

  ```Output
  Language
  (Unknown)     3   
  Catalan       1   
  English       5557
  Filipino      1   
  German        2   
  Indonesian    1   
  Malay         1   
  Romanian      1   
  Spanish       2   
  Swahili       1   
  Swedish       1   
  Turkish       1   
  Name: Message, dtype: int64
  ```

</details>

<br /><br />

***

We have a surprising array of languages, perhaps. But the non-English messages are really just outliers and should have no real impact on the spam detection.

Let's look at the sentiment analysis for our messages:

```python
azure_df.groupby('Class')['Sentiment'].plot(kind='hist', bins=50)
```

The output is:

```Output
Class
ham     AxesSubplot(0.125,0.125;0.775x0.755)
spam    AxesSubplot(0.125,0.125;0.775x0.755)
Name: Sentiment, dtype: object
```

:::image type="content" alt-text="Histogram chart that demonstrates the results of sentiment analysis." source="../media/sentiment-analysis.png" loc-scope="Azure":::

It might not be surprising that the sentiments represented in the dataset are bifurcated: SMS is a medium that captures extremes better than nuanced middle ground. That said, the number of dead-center messages is interesting. The proportion of spam messages right in the middle is also interesting. Let's break the two classes (ham and spam) into separate histograms to get a better look.

### Try it yourself

Break out the preceding single histogram into two histograms (one for each class of message).

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

  Refer to the code we used earlier in the section.

  ```python
  azure_df.hist(bins=50,by='Class', column='Sentiment')
  ```

  The output is:

  ```Output
  array([<matplotlib.axes._subplots.AxesSubplot object at 0x7fd95ed57c18>,
      <matplotlib.axes._subplots.AxesSubplot object at 0x7fd95ed2f7b8>],
      dtype=object)
  ```

  :::image type="content" alt-text="Side-by-side histograms that analyze sentiments in ham and spam." source="../media/sentiment-analysis-ham-spam.png" loc-scope="Azure":::

</details>

<br /><br />

***

The number of spam messages in our dataset is about a tenth of the amount of ham, yet the number of spam messages with exactly neutral sentiment is about half that of the ham. This result indicates that spam messages, on average, tend to be more neutral than legitimate messages. We can also notice that non-neutral spam messages tend to have more positive than negative sentiment, which makes intuitive sense.

> [!div class="alert is-tip"]
> ### Takeaway
>
> Beyond providing additional insight into our data, sophisticated language-identification and sentiment-analysis algorithms provided by cloud-based services like Azure can provide details that can potentially help improve spam detection. An example is how patterns of sentiments in spam differ from those in legitimate messages.
>
