One of the strengths of Naive Bayes analysis is that we don't have to go too deep into text processing to develop robust spam detection. However, the text is raw and it does require a certain amount of cleaning. 

To clean the text, we'll use one of the most commonly used text analytics libraries in Python, the Natural Language Toolkit (NLTK). Before we can import it, we first need to install it:

```python
!pip install nltk
```

If you already have NLTK installed, you'll see the following output:

```Output
Requirement already satisfied: nltk in /home/nbuser/anaconda3_420/lib/python3.5/site-packages (3.2.1)
```

We can now import NLTK, in addition to the native Python string library to help with our text manipulation. We'll also download the latest list of stop words (such as _the_, _is_, and _are_) for NLTK.

```python
import string
import nltk
nltk.download('stopwords')
from nltk.corpus import stopwords
```

The output is:

```Output
[nltk_data] Downloading package stopwords to /home/nbuser/nltk_data...
[nltk_data]   Unzipping corpora/stopwords.zip.
```

Part of our data preparation is *vectorizing* the text data. Recall that earlier in the section, when we first introduced Naive Bayes analysis, we stated that we wanted to treat our messages as "bags of words" rather than as English-language messages. Vectorization is the process by which we convert our collection of text messages to a matrix of word counts.

Part of the vectorization process is to remove punctuation from the messages and exclude stop words from our analysis. We'll write a function to perform those tasks here, because we want to access those actions later on.

```python
def txt_preprocess(text):
   
    #Remove punctuation 
    temp = [w for w in text if w not in string.punctuation]
    temp = ''.join(temp)
    
    #Exclude stopwords
    processedtext = [w for w in temp.split() if w.lower() not in stopwords.words('english')]
    return processedtext
```

The scikit-learn library provides a `count-vectorizer` function. We'll import it now, and then use the `txt_preprocess()` function that we just wrote as a custom analyzer for it:

```python
from sklearn.feature_extraction.text import CountVectorizer
X = df['Message']
y = df['Class']
CountVect = CountVectorizer(analyzer=txt_preprocess).fit(X)
```

> [!NOTE]
> The convention of using an uppercase `X` to represent the independent variables (the predictors) and a lowercase `y` to represent the dependent variable (the response) comes from statistics. Data scientists commonly use this convention.

To see how the vectorizer transformed the words, let's check it against a common English word like _go_:

```python
print(CountVect.vocabulary_.get('go'))
```

The output is `6864`. _Go_ appears 6,864 times in our dataset.

Before we transform the entire dataset and train the model, we take the final preparatory step of splitting our data into training and test data:

```python
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.30, random_state=50)
```

Finally, we transform our training messages into a [document-term matrix](https://wikipedia.org/wiki/Document-term_matrix?azure-portal=true). "Document" might sound a little grandiose in this case, because it refers to individual text messages. But it's a term of art for text analysis.

```python
X_train_data = CountVect.transform(X_train)
```

It can be a tricky concept, so let's look at the training text matrix directly:

```python
print(X_train_data)
```

The output is:

```Output
  (0, 7173)	    1
  (0, 9613)	    1
  (0, 10093)	1
  (0, 11051)	1
  (1, 16)	    1
  (1, 273)	    1
  (1, 370)    	1
  (1, 526)	    1
  (1, 685)    	1
  (1, 1341)	    1
  (1, 3350)    	1
  (1, 3851)	    1
  (1, 4098)	    1
  (1, 4828)	    1
  (1, 4881)	    1
  (1, 5286)	    1
  (1, 5683)    	1
  (1, 8064)	    1
  (1, 8218)	    1
  (1, 11369)    1
  (2, 2648)	    1
  (2, 5881)	    1
  (2, 7395)	    1
  (2, 7838)	    1
  (2, 8000)	    1
  :	:
  (3896, 4254)	1
  (3896, 7944)	1
  (3896, 8009)	1
  (3896, 8241)	1
  (3896, 9549)	1
  (3897, 1634)	1
  (3897, 4005)	1
  (3897, 4491)	1
  (3897, 5275)	1
  (3898, 61)	1
  (3898, 1353)	1
  (3898, 1417)	1
  (3898, 1867)	1
  (3898, 2088)	1
  (3898, 2971)	1
  (3898, 3746)	1
  (3898, 5519)	1
  (3898, 6838)	1
  (3898, 6969)	1
  (3898, 7839)	1
  (3898, 8607)	1
  (3898, 11363)	1
  (3898, 11384)	1
  (3899, 1445)	1
  (3899, 6079)	1
```

Then, we shape our data:

```python
X_train_data.shape
```

The output is:

```Output
(3900, 11425)
```

`X_train_data` is now a 3,900 &times; 11,425 matrix. Each of the 3,900 rows represents a text ("document") from the training dataset. Each column is a specific word (11,425 of them, in this case).

> [!div class="alert is-tip"]
> ### Key takeaway
>
> Putting our bag of words into a document-term matrix the way we did here is a standard tool of natural language processing and text analysis. It's used in contexts beyond Naive Bayes analysis in which word frequency is important, such as [term frequency–inverse document frequency (TF-IDF)](https://wikipedia.org/wiki/Tf%E2%80%93idf?azure-portal=true).
>