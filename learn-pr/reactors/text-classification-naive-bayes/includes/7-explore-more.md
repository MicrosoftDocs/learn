Beyond detecting spam, we can use ML to explore the SMS data more deeply. To do so, we can use sophisticated, cloud-based cognitive tools such as Azure Cognitive Services.

## Azure Cognitive Services

The advantage of using cloud-based services is that they provide cutting-edge models that you can access without having to train the models. This can help accelerate both your exploration and your use of ML.

Azure provides Cognitive Services APIs that can be consumed using Python to conduct image recognition, speech recognition, and text recognition, just to name a few. For the purposes of this subsection, we're going to look at using the Azure Text Analytics API.

First, we’ll start by obtaining a Cognitive Services API key. Note that you can get a free key for seven days (after which you'll be required to pay for continued access to the API).

Learn more about [pricing for Cognitive Services](https://azure.microsoft.com/pricing/details/cognitive-services/?azure-portal=true).

1. Go to [Try Azure Cognitive Services](https://azure.microsoft.com/try/cognitive-services/?azure-portal=true).
1. Select **Language APIs**.
1. By **Text Analytics**, select **Get API key**.
1. In the **Try Cognitive Services for free** window, under **7-day trial**, select **Get stared**.
1. In the **Microsoft Cognitive Services Terms** window, accept the terms of the free trial, and then select **Next**.
1. In the **Sign-in to Continue** window, select your preferred way to sign in to your Azure account.

When you have your API keys in hand, you're ready to start. Substitute the API key that you get for the seven-day trial below where it reads ACCOUNT_KEY.

```Python
# subscription_key = 'ACCOUNT_KEY'
subscription_key = '8efb79ce8fd84c95bd1aa2f9d68ae734'
assert subscription_key

# If using a Free Trial account, this URL does not need to be updated.
# If using a paid account, verify that it matches the region where the 
# Text Analytics Service was setup.
text_analytics_base_url = "https://westcentralus.api.cognitive.microsoft.com/text/analytics/v2.1/"
```

We will also need to import the NumPy and requests modules.

```Python
import numpy as np
import requests
```

The Azure Text Analytics API has a hard limit of 1,000 calls at a time, so we will need to split our 5,572 SMS messages into at least six chunks to run them through Azure.

```Python
chunks = np.array_split(df, 6)

for chunk in chunks:
    print(len(chunk))
```

```Output
929
929
929
929
928
928
```

Two of the things that cognitive services like those provided by Azure offer are language identification and sentiment analysis. Both are relevant for our dataset, so we will prepare our data for both by submitting them as JavaScript Object Notation (JSON) documents. We'll prepare the data for language identification first.

```Python
# Prepare the header for the JSON document including your subscription key
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

```Output
---------------------------------------------------------------------------
KeyError                                  Traceback (most recent call last)
<ipython-input-62-a51920ac8ffe> in <module>
     22     # Put the identified languages in a list.
     23     lang_list = []
---> 24     for document in languages['documents']:
     25         lang_list.append(document['detectedLanguages'][0]['name'])
     26 

KeyError: 'documents'
```

Now we need perform similar preparation of the data for sentiment analysis.


```Python
# Supply the URL for the sentiment-analysis API.
sentiment_api_url = text_analytics_base_url + "sentiment"

# Iterate over the chunked DataFrame.
for i in range(len(chunks)):
    
    # We have alread reset the chunk-indexes, so we don't need to do again.
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

We now need to reassemble our chunked DataFrame.

```Python
azure_df = pd.DataFrame(columns=['Index', 'Class', 'Message', 'Language', 'Sentiment'])

for i in range(len(chunks)):
    azure_df = pd.concat([azure_df, chunks[i]])
    if i == 0:
        azure_df['index'] = chunks[i].index

azure_df.set_index('index', inplace=True)
azure_df.drop(['Index'], axis=1, inplace=True)
azure_df.head()
```

```Output
--------------------------------------------------------------------------------------------------------------------------------------
|       | Class | Message                                                                    | Language  | Sentiment | Length_of_msg |
--------------------------------------------------------------------------------------------------------------------------------------
| index |       |                                                                            |           |           |               |
--------------------------------------------------------------------------------------------------------------------------------------
| 0.0   | ham   | Go until jurong point, crazy.. Available only in bugis n great world la e  | NaN       | NaN       | NaN           |
|       |       | buffet... Cine there got amore wat..                                       |           |           |               |
--------------------------------------------------------------------------------------------------------------------------------------
| 1.0   | ham   | Ok lar... Joking wif u oni...                                              | NaN       | NaN       | NaN           |
--------------------------------------------------------------------------------------------------------------------------------------
| 2.0   | spam  | Free entry in 2 a wkly comp to win FA Cup final tkts 21st May 2005. Text   | NaN       | NaN       | NaN           |
|       |       | FA to 87121 to receive entry question(std txt rate)T&C's apply             |           |           |               |
|       |       | 08452810075over18's                                                        |           |           |               |
--------------------------------------------------------------------------------------------------------------------------------------
| 3.0   | ham   | U dun say so early hor... U c already then say...                          | NaN       | NaN       | NaN           |
--------------------------------------------------------------------------------------------------------------------------------------
| 4.0   | ham   | Nah I don't think he goes to usf, he lives around here though              | NaN       | NaN       | NaN           |
--------------------------------------------------------------------------------------------------------------------------------------
```

We can also look at the tail of the DataFrame to check that our indexing worked as expected.

```Python
azure_df.tail()
```

```Output
--------------------------------------------------------------------------------------------------------------------------------------
|       | Class | Message                                                                    | Language  | Sentiment | Length_of_msg |
--------------------------------------------------------------------------------------------------------------------------------------
| index |       |                                                                            |           |           |               |
--------------------------------------------------------------------------------------------------------------------------------------
| NaN   | spam  | This is the 2nd time we have tried 2 contact u. U have won the £750        | NaN       | NaN       | 160.0         |
|       |       | Pound prize. 2 claim is easy, call 087187272008 NOW1! Only 10p per         |           |           |               |
|       |       | minute. BT-national-rate.                                                  |           |           |               |
--------------------------------------------------------------------------------------------------------------------------------------
| NaN   | ham   | Will ü b going to esplanade fr home?                                       | NaN       | NaN       | 36.0          |
--------------------------------------------------------------------------------------------------------------------------------------
| NaN   | ham   | Pity, * was in mood for that. So...any other suggestions?                  | NaN       | NaN       | 57.0          |
--------------------------------------------------------------------------------------------------------------------------------------
| NaN   | ham   | The guy did some bitching but I acted like i'd be interested in buying     | NaN       | NaN       | 125.0         |
|       |       | something else next week and he gave it to us for free                     |           |           |               |
--------------------------------------------------------------------------------------------------------------------------------------
| NaN   | ham   | Rofl. Its true to its name                                                 | NaN       | NaN       | 26.0          |
--------------------------------------------------------------------------------------------------------------------------------------
```

Let's now see if all of the SMS messages were in English (and, if not, how many messages of which languages we are looking at).

```Python
azure_df.groupby('Language')['Message'].count().plot(kind='bar')
```

```Output
---------------------------------------------------------------------------
IndexError                                Traceback (most recent call last)
<ipython-input-65-9b69cae9a0dd> in <module>
----> 1 azure_df.groupby('Language')['Message'].count().plot(kind='bar')

~\Anaconda3\lib\site-packages\pandas\plotting\_core.py in __call__(self, *args, **kwargs)
    845                     data.columns = label_name
    846 
--> 847         return plot_backend.plot(data, kind=kind, **kwargs)
    848 
    849     __call__.__doc__ = __doc__

~\Anaconda3\lib\site-packages\pandas\plotting\_matplotlib\__init__.py in plot(data, kind, **kwargs)
     59             kwargs["ax"] = getattr(ax, "left_ax", ax)
     60     plot_obj = PLOT_CLASSES[kind](data, **kwargs)
---> 61     plot_obj.generate()
     62     plot_obj.draw()
     63     return plot_obj.result

~\Anaconda3\lib\site-packages\pandas\plotting\_matplotlib\core.py in generate(self)
    268         for ax in self.axes:
    269             self._post_plot_logic_common(ax, self.data)
--> 270             self._post_plot_logic(ax, self.data)
    271 
    272     def _args_adjust(self):

~\Anaconda3\lib\site-packages\pandas\plotting\_matplotlib\core.py in _post_plot_logic(self, ax, data)
   1414         name = self._get_index_name()
   1415 
-> 1416         s_edge = self.ax_pos[0] - 0.25 + self.lim_offset
   1417         e_edge = self.ax_pos[-1] + 0.25 + self.bar_width + self.lim_offset
   1418 

IndexError: index 0 is out of bounds for axis 0 with size 0
```

So the overwhelming majority of the messages are in English, though we have several additional languages in our dataset. Let's look at the actual numbers.

### Try it yourself

Now use the `groupby` method to display actual counts of the languages detected in the dataset rather than a bar chart of them.

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

```Python
azure_df.groupby('Language')['Message'].count()
```

```Output
Series([], Name: Message, dtype: int64)
```

---

</details>


We have a surprising array of languages, perhaps, but the non-English messages are really just outliers and should have no real impact on the spam detection.

Now let's look at the sentiment analysis for our messages.

```Python
azure_df.groupby('Class')['Sentiment'].plot(kind='hist', bins=50)
```

```Output
Class
ham     AxesSubplot(0.125,0.125;0.775x0.755)
spam    AxesSubplot(0.125,0.125;0.775x0.755)
Name: Sentiment, dtype: object
```

:::image type="content" alt-text="A screenshot of the histogram chart that is created when you run the azure_df.groupby example code." source="../media/azure-df-groupby.png" loc-scope="Azure":::


It is perhaps not too surprising that the sentiments represented in the dataset should be bifurcated: SMS is a medium that captures extremes better than nuanced middle ground. That said, the number of dead-center messages is interesting. The proportion of spam messages right in the middle is also interesting. Let's break the two classes (ham and spam) into separate histograms to get a better look.

### Try it yourself

Break out the single histogram above into two histograms (one for each class of message).

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

Refer back to the code we used to do this earlier in the section.

```Python
azure_df.hist(bins=50,by='Class', column='Sentiment')
```

```Output
array([<matplotlib.axes._subplots.AxesSubplot object at 0x00000194F6985848>,
       <matplotlib.axes._subplots.AxesSubplot object at 0x00000194FC3A7FC8>],
      dtype=object)
```


:::image type="content" alt-text="A screenshot of the two histogram charts that are created when you run the azure_df.hist example code." source="../media/azure-df-hist.png" loc-scope="Azure":::

---

</details>

The number of spam messages in our dataset is about a tenth of the amount of ham, yet the number of spam messages with exactly neutral sentiment is about half that of the ham, indicating that spam messages, on average, tend to be more neutral than legitimate messages. We can also notice that non-neutral spam messages tend to have more positive than negative sentiment, which makes intuitive sense.

> [!div class="alert is-tip"]
> ### Takeaway
>
> Beyond providing additional insight into our data, sophisticated language-identification and sentiment-analysis algorithms provided by cloud-based services like Azure can provide additional details that could potentially help improve spam detection. For example, how patterns of sentiments in spam differ from those in legitimate messages.
>