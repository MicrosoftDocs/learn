Now that we have an idea of some of the individual entries in the dataset, let's get a better sense of the dataset as a whole:

```python
df.info()
```

The output is:

```Output
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 5572 entries, 0 to 5571
Data columns (total 2 columns):
Class      5572 non-null object
Message    5572 non-null object
dtypes: object(2)
memory usage: 87.1+ KB
```

### Try it yourself

Run the `describe()` method on `df`. Does it provide much useful information about this dataset? If not, why not?

<details>

  <summary>Hint <i>(expand to reveal)</i></summary>

  Possible exercise solution:

  ```python
  df.describe()
  ```

  ```Output
  -------------------------------------------
  |        | Class | Message                |
  -------------------------------------------
  | count  | 5572  | 5572                   |
  -------------------------------------------
  | unique | 2     | 5169                   |
  -------------------------------------------
  | top    | ham   | Sorry, I'll call later |
  -------------------------------------------
  | freq   | 4825  | 30                     |
  -------------------------------------------
  ```

</details>

<br /><br />

***

We can also visualize the dataset to graphically see the mix of spam to ham. (Note that we need to include the `%matplotlib inline` magic command to actually see the bar chart here in the notebook.)

```python
%matplotlib inline
df.groupby('Class').count().plot(kind='bar')
```

The output is:

```Output
<matplotlib.axes._subplots.AxesSubplot at 0x7fd962b5f9e8>
```

:::image type="content" alt-text="Bar chart that demonstrates the mix of spam and ham in columns." source="../media/ham-spam-df-groupby.png" loc-scope="Azure":::


> [!div class="alert is-tip"]
> ### Key takeaway
>
> Here, as in previous units, we have stuck together several methods to run on a DataFrame. This kind of additive method-stacking is part of what makes Python and pandas a powerful combination for the data exploration that is a crucial part of data science.
>
## Explore the data by using word clouds

Because our data is largely not numeric, you might have noticed that some of our standard data-exploration tools (such as bar charts and the `describe()` method) have been of limited use in exploring this data. Instead, word clouds can be a powerful way of getting a quick glance at what's represented in text data as a whole:

```python
!pip install wordcloud
```
The output is:

```Output
Collecting wordcloud
  Downloading https://files.pythonhosted.org/packages/35/13/e580e08520a50fa0bd53a6a4025699534aafd78611bd283c73b4ffa99e80/wordcloud-1.6.0-cp35-cp35m-manylinux1_x86_64.whl (357kB)
     |████████████████████████████████| 358kB 2.9MB/s eta 0:00:01
Requirement already satisfied: matplotlib in /home/nbuser/anaconda3_420/lib/python3.5/site-packages (from wordcloud) (2.1.1)
Requirement already satisfied: numpy>=1.6.1 in /home/nbuser/anaconda3_420/lib/python3.5/site-packages (from wordcloud) (1.17.3)
Requirement already satisfied: pillow in /home/nbuser/anaconda3_420/lib/python3.5/site-packages (from wordcloud) (4.3.0)
Requirement already satisfied: six>=1.10 in /home/nbuser/anaconda3_420/lib/python3.5/site-packages (from matplotlib->wordcloud) (1.11.0)
Requirement already satisfied: python-dateutil>=2.0 in /home/nbuser/anaconda3_420/lib/python3.5/site-packages (from matplotlib->wordcloud) (2.8.1)
Requirement already satisfied: pytz in /home/nbuser/anaconda3_420/lib/python3.5/site-packages (from matplotlib->wordcloud) (2016.6.1)
Requirement already satisfied: cycler>=0.10 in /home/nbuser/anaconda3_420/lib/python3.5/site-packages (from matplotlib->wordcloud) (0.10.0)
Requirement already satisfied: pyparsing!=2.0.4,!=2.1.2,!=2.1.6,>=2.0.1 in /home/nbuser/anaconda3_420/lib/python3.5/site-packages (from matplotlib->wordcloud) (2.1.4)
Requirement already satisfied: olefile in /home/nbuser/anaconda3_420/lib/python3.5/site-packages (from pillow->wordcloud) (0.44)
Installing collected packages: wordcloud
Successfully installed wordcloud-1.6.0
```

We have to supply parameters to the `WordCloud()` function and to Matplotlib to render the word clouds. We'll save ourselves some redundant work by writing a short function to handle it. Parameters for `WordCloud()` will include the stop words we want to ignore and font size for the words in the cloud. For Matplotlib, these parameters will include instructions for rendering the word cloud.

```python
from wordcloud import WordCloud, STOPWORDS
import matplotlib.pyplot as plt
def get_wordcloud(text_data,title):
  wordcloud = WordCloud(background_color='black',
                        stopwords=set(STOPWORDS),
                        max_font_size=40, 
                        relative_scaling=1.0,
                        random_state=1
  ).generate(str(text_data))
  fig = plt.figure(1, figsize=(12, 12))
  plt.axis('off')
  plt.title(title)
  plt.imshow(wordcloud)
  plt.show()
```

It's time to plot the word clouds.

```python
spam_msg = df.loc[df['Class']=='spam']['Message']
get_wordcloud(spam_msg,'Spam Cloud')
ham_msg = df.loc[df['Class']=='ham']['Message']
get_wordcloud(ham_msg,'Ham Cloud')
```

:::image type="content" alt-text="Two word clouds, labeled Spam Cloud and Ham Cloud." source="../media/word-clouds.png" loc-scope="Azure":::

Looking at the two word clouds, it's immediately apparent that the frequency of the most common words is different between our spam and our ham messages. This difference will form the primary basis of our spam detection.

## Explore the data numerically

Just because the data doesn't naturally lend itself to numerical analysis "out of the box" does not mean that we can't do numerical analysis. We also can analyze the average length of spam and ham messages to see if there are differences. 

First, we need to create a new column:

```python
df['Length_of_msg'] = df['Message'].apply(len)
df.head()
```

The output is:

```Output
-----------------------------------------------------------------------------------------------------------------------------------------
|   | Class  | Message                                                                                                  | Length_of_msg |
-----------------------------------------------------------------------------------------------------------------------------------------
| 0 | ham    | Go until jurong point, crazy.. Available only in bugis n great world la e buffet... Cine there got amore | 111           |
|   |        | wat...                                                                                                   |               |
-----------------------------------------------------------------------------------------------------------------------------------------
| 1 | ham    | Ok lar... Joking wif u oni...                                                                            | 29            |
-----------------------------------------------------------------------------------------------------------------------------------------
| 2 | spam   | Free entry in 2 a wkly comp to win FA Cup final tkts 21st May 2005. Text FA to 87121 to receive entry    | 155           |
|   |        | question(std txt rate)T&C's apply 08452810075over18's                                                    |               |
-----------------------------------------------------------------------------------------------------------------------------------------
| 3 | ham    | U dun say so early hor... U c already then say...                                                        | 49            |
-----------------------------------------------------------------------------------------------------------------------------------------
| 4 | ham    | Nah I don't think he goes to usf, he lives around here though                                            | 61            |
-----------------------------------------------------------------------------------------------------------------------------------------
```

### Try it yourself

What does the `apply()` method do in the preceding code cell?


<details>
  <summary>Hint <i>(expand to reveal)</i></summary>
The `apply()` method calls the `len` function on every row's `message` column to find the length for each message.

If you want to learn more, you can refer to the [pandas reference documentation](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.apply.html?azure-portal=true).

</details>

<br /><br />

***

Now that we have the length of each message, we can visualize those message lengths by using a histogram:

```python
df.groupby('Class')['Length_of_msg'].plot(kind='hist', bins=50)
```

The output is:

```Output
Class
ham     AxesSubplot(0.125,0.125;0.775x0.755)
spam    AxesSubplot(0.125,0.125;0.775x0.755)
Name: Length_of_msg, dtype: object
```

:::image type="content" alt-text="Histogram that demonstrates message length and message frequency." source="../media/df-groupby-length-of-message.png" loc-scope="Azure":::

The orange histogram is the spam messages. There are many more ham messages than spam, so let's break these out separately to see the details more clearly:

```python
df.hist(bins=50,by='Class', column='Length_of_msg')
```

The output is:

```Output
array([<matplotlib.axes._subplots.AxesSubplot object at 0x7fd96270b198>,
       <matplotlib.axes._subplots.AxesSubplot object at 0x7fd9626c1ef0>],
      dtype=object)
```

:::image type="content" alt-text="Side-by-side histograms that demonstrate quantities of ham and spam in the dataset." source="../media/histograms-ham-spam.png" loc-scope="Azure":::

Spam messages skew much longer than ham messages.

### Try it yourself


Why does it appear in the details histograms that there is almost no overlap between the lengths of ham and spam text messages? What do the differences in scale tell us (and what might they inadvertently obscure)?

<br />

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

These vastly different lengths between ham and spam messages show us that spam messages tend to be much longer compared to real messages. This will inadvertently obscure longer, real messages.

</details>

<br /><br />

***

Let's look at the differences in length of the two classes of message numerically.

```python
df.groupby('Class').mean()
```

```Output
-------------------------
|       | Length_of_msg |
-------------------------
| Class |               |
-------------------------
| ham   | 71.482487     |
-------------------------
| spam  | 138.670683    |
-------------------------
```

These numbers are in accord with what we saw in the histograms.

Now, let's get to the actual modeling and spam detection.