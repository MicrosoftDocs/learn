One of the great strengths of naive Bayes analysis is that we don't have to go too deep into text processing in order to develop robust spam detection. However, the text is raw and it does require a certain amount of cleaning. To do this, we will use one of the most commonly used text analytics libraries in Python, the Natural Language Toolkit (NLTK). However, before we can import it, we will need to first install it.

```Python
!pip install nltk
```

TBD output

We can now import NLTK, in addition to the native Python string library to help with our text manipulation. We will also download the latest list of stop words (such as 'the', 'is', and 'are') for NLTK.

```Python
import string
import nltk
nltk.download('stopwords')
from nltk.corpus import stopwords
```

TBD output

Part of our data preparation will be vectorizing the text data. Recall that earlier in the section when we first introduced naive Bayes analysis, we stated that we wanted to treat our messages as "bags of words" rather than as English-language messages. Vectorization is the process by which we convert our collection of text messages to a matrix of word counts.

Part of the vectorization process will be for us to remove punctuation from the messages and exclude stop words from our analysis. We will write a function to perform those tasks here, because we will want to access those actions later on.

```Python
def txt_preprocess(text):
   
    #Remove punctuation 
    temp = [w for w in text if w not in string.punctuation]
    temp = ''.join(temp)
    
    #Exclude stopwords
    processedtext = [w for w in temp.split() if w.lower() not in stopwords.words('english')]
    return processedtext
```

TBD output

Scikit-learn provides a count-vectorizer function. We will now import it and then use the `txt_preprocess()` function we just wrote as a custom analyzer for it.

```Python
from sklearn.feature_extraction.text import CountVectorizer

X = df['Message']
y = df['Class']

CountVect = CountVectorizer(analyzer=txt_preprocess).fit(X)
```

TBD output

> [!NOTE]
> The convention of using an uppercase `X` to represent the independent variables (the predictors) and a lowercase `y` to represent the dependent variable (the response) comes from statistics and is commonly used by data scientists.

In order to see how the vectorizer transformed the words, let's check it against a common English word like "go."

```Python
print(CountVect.vocabulary_.get('go'))
```

TBD output

So "go" appears 6,864 times in our dataset.

Now, before we transform the entire dataset and train the model, we have the final preparatory step of splitting our data into training and test data to perform.

```Python
from sklearn.model_selection import train_test_split

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.30, random_state=50)
```

TBD output

Finally, we will transform our training messages into a [document-term matrix](https://wikipedia.org/wiki/Document-term_matrix?azure-portal=true). "Document" might sound a little grandiose in this case as it refers to individual text messages, but it is a term of art for text analysis.

```Python
X_train_data = CountVect.transform(X_train)
```

TBD output

This can be a tricky concept, so let's look at the training-text matrix directly:

```Python
print(X_train_data)
```

TBD output


```Python
X_train_data.shape
```

TBD output

`X_train_data` is now a 3900x11425 matrix, where each of the 3,900 rows represents a text ("document") from the training dataset and each column is a specific word (11,425 of them in this case).

> [!div class="alert is-tip"]
> ### Key takeaway
>
> Putting our bag of words into a document-term matrix like this is a standard tool of natural-language processing and text analysis, and it is used in contexts beyond naive Bayes analysis in which word-frequency is important, such as [term frequency–inverse document frequency (TF-IDF)](https://wikipedia.org/wiki/Tf%E2%80%93idf?azure-portal=true).
>