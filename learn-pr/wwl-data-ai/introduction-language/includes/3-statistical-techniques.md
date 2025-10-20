Two important statistical techniques that form the foundation of natural language processing (NLP) include: **Naïve Bayes** and **Term Frequency - Inverse Document Frequency** (**TF-IDF**).

## Understanding Naïve Bayes

**Naïve Bayes** is a statistical technique that was first used for email filtering. To learn the difference between spam and not spam, two documents are compared. Naïve Bayes classifiers identify which tokens are correlated with emails labeled as spam. In other words, the technique finds which group of words only occurs in one type of document and not in the other. The group of words is often referred to as **bag-of-words** features.

For example, the words `miracle cure`, `lose weight fast`, and `anti-aging` may appear more frequently in spam emails about dubious health products than your regular emails.

Though Naïve Bayes proved to be more effective than simple rule-based models for text classification, it was still relatively rudimentary as only the presence (and not the position) of a word or token was considered.

## Understanding TF-IDF

The **Term Frequency - Inverse Document Frequency** (**TF-IDF**) technique had a similar approach in that it compared the frequency of a word in one document with the frequency of the word in a whole **corpus** of documents. By understanding in which context a word was being used, documents could be classified based on certain topics. TF-IDF is often used for information retrieval, to help understand which relative words or tokens to search for.

> [!Note]
> In the context of NLP, a **corpus** refers to a large and structured collection of text documents that is used for machine learning tasks. Corpora (plural of corpus) serve as essential resources for training, testing, and evaluating various NLP models.

For example, after tokenizing the words in `"we choose to go to the moon"`, you can perform some analysis to count the number of occurrences of each token. The most commonly used words (other than *stop words* such as `"a"`, `"the"`, and so on) can often provide a clue as to the main subject of a text corpus. For example, the most common words in the entire text of the `"go to the moon"` speech we considered previously include `"new"`, `"go"`, `"space"`, and `"moon"`. If we were to tokenize the text as `bi-grams` (word pairs), the most common `bi-gram` in the speech is `"the moon"`. From this information, we can easily surmise that the text is primarily concerned with space travel and going to the moon.

Simple frequency analysis in which you simply count the number of occurrences of each token can be an effective way to analyze a single document, but when you need to differentiate across multiple documents within the same corpus, you need a way to determine which tokens are most relevant in each document. *TF-IDF* calculates scores based on how often a word or term appears in one document compared to its more general frequency across the entire collection of documents. Using this technique, a high degree of relevance is assumed for words that appear frequently in a particular document, but relatively infrequently across a wide range of other documents.

Next, let's look at the deep learning techniques used to create today's semantic models.