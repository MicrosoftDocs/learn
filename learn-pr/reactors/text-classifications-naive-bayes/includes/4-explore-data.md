Now that we have an idea of some of the individual entries in the dataset, let's get a better sense of the dataset as a whole.

```python
df.info()
```

TBD output

### Try it yourself

Now run the `describe()` method on `df`. Does it provide much useful information about this dataset? If not, why not?

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

Possible exercise solution:

```python
df.describe()
```

TBD output

</details>

<br /><br />

***

We can also visualize the dataset to graphically see the mix of spam to ham. (Note that we need to include the `%matplotlib inline` magic command in order to actually see the bar chart here in the notebook.)

```python
%matplotlib inline
df.groupby('Class').count().plot(kind='bar')
```

TBD output

> [!div class="alert is-tip"]
> ### Key takeaway
>
> Notice that here, as in previous units, we have stuck together several methods to run on a DataFrame. This kind of additive method-stacking is part of what makes Python and pandas such a power combination for the rough-and-ready data exploration that is a crucial part of data science.
>

## Explore the data using word clouds

Because our data is largely not numeric, you might have noticed that some of our go-to data exploration tools (such as bar charts and the `describe()` method) have been of limited use in exploring this data. Instead, word clouds can be a powerful way of getting a quick glance at what's represented in text data as a whole.

```python
!pip install wordcloud
```

We will have to supply a number of parameters to the `WordCloud()` function and to matplotlib in order to render the word clouds, so we will save ourselves some redundant work by writing a short function to handle it. Parameters for `WordCloud()` will include the stop words we want to ignore and font size for the words in the cloud. For matplotlib, these parameters will include instructions for rendering the word cloud.

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

TBD output

Now, it's time to plot the word clouds.

```python
spam_msg = df.loc[df['Class']=='spam']['Message']
get_wordcloud(spam_msg,'Spam Cloud')
ham_msg = df.loc[df['Class']=='ham']['Message']
get_wordcloud(ham_msg,'Ham Cloud')
```

TBD output

Looking at the two word clouds, it's immediately apparent that the frequency of the most common words is different between our spam and our ham messages, which will form the primary basis of our spam detection.

## Explore the data numerically

Just because the data does not naturally lend itself to numerical analysis "out of the box" does not mean that we can't do so. We can also analyze the average length of spam and ham messages to see if there are differences. For this, we need to create a new column.

```python
df['Length_of_msg'] = df['Message'].apply(len)
df.head()
```

TBD output

### Try it yourself

What does the `apply()` method do in the preceding code cell?

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

If you are unsure, you can refer to the [pandas reference documentation](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.apply.html?azure-portal=true).

TBD possible solution and output

</details>

<br /><br />

***

Now that we have the length of each message, we can visualize those message lengths using a histogram.

```Python
df.groupby('Class')['Length_of_msg'].plot(kind='hist', bins=50)
```

TBD output

The orange histogram is the spam messages. Because there are so many more ham messages than spam, let's break these out separately to see the details more clearly.

```python
df.hist(bins=50,by='Class', column='Length_of_msg')
```

TBD output

Spam messages skew much longer than ham messages.

### Try it yourself

Why does it appear in the details histograms that there is almost no overlap between the lengths of ham and spam text messages? What do the differences in scale tell us (and what could they inadvertently obscure)?

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

TBD output

</details>

<br /><br />

***

Let's look at the differences in length of the two classes of message numerically.

```python
df.groupby('Class').mean()
```

TBD output

These numbers accord with what we saw in the histograms.

Now, let's get to the actual modeling and spam detection.