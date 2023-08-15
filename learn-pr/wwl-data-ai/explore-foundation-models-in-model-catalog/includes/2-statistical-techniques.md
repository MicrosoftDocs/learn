Over the last decades, multiple developments in the field of **natural language processing** (**NLP**) have resulted in achieving **Large Language Models** (**LLMs**).

To understand LLMs, let's first explore the statistical techniques for NLP that over time have contributed to the current techniques.

## The beginnings of Natural Language Processing (NLP)

As NLP is focused on understanding and generating text, most first attempts at accomplishing NLP were based on using the rules and structure inherent to languages. Especially before machine learning techniques became prevalent, structural models and formal grammar were the primary methods employed.

These approaches relied on explicit programming of linguistic rules and grammatical patterns to process and generate text. Though these models could handle some specific language tasks reasonably well, they faced significant challenges when confronted with the vast complexity and variability of natural languages.

Instead of hard-coding rules, researchers in the 1990s began to utilize statistical and probabilistic models to learn patterns and representations directly from data.

## Understanding tokenization

One of the most important developments in NLP research has been tokenization. **Tokens** are strings with a known meaning, usually representing a word. **Tokenization** is turning words into tokens, usually numbers. A statistical approach to tokenization is by using a pipeline:

:::image type="content" source="../media/tokenization-pipeline.gif" alt-text="Animation showing the pipeline of tokenization of a sentence.":::

1. Start with the text you want to **tokenize**.
1. **Split** the words in the text based on a rule. For example, split the words where there's a white space.
1. **Stemming**. Merge similar words by removing the end of a word.
1. **Stop word removal**. Remove noisy words that have little meaning like `the` and `a`. A dictionary of these words is provided to structurally remove them from the text.
1. **Assign a number** to each unique token.

Tokenization allowed for text to be labeled. As a result, statistical techniques could be used to let computers find patterns in the data instead of applying rule-based models.

## Statistical techniques for NLP

Two important advancements to achieve NLP used statistical techniques: **Naïve Bayes** and **Term Frequency - Inverse Document Frequency** (**TF-IDF**).

### Understanding Naïve Bayes

**Naïve Bayes** is a statistic technique that was first used for email filtering. To learn the difference between spam and not spam, two documents are compared. Naïve Bayes classifiers identify which tokens are correlated with emails labeled as spam. In other words, the technique finds which group of words only occurs in one type of document and not in the other. The group of words is often referred to as **bag-of-words** features.

For example, the words `miracle cure`, `lose weight fast`, and `anti-aging` may appear more frequently in spam emails about dubious health products than your regular emails.

Though Naïve Bayes proved to be more effective than simple rule-based models for text classification, it was still relatively rudimentary as only the presence (and not the position) of a word or token was considered.

### Understanding TF-IDF

The **TF-IDF** technique had a similar approach in that it compared the frequency of a word in one document with the frequency of the word in a whole **corpus** of documents. By understanding in which context a word was being used, documents could be classified based on certain topics. TF-IDF is often used for information retrieval, to help understand which relative words or tokens to search for.

> [!Note]
> In the context of NLP, a **corpus** refers to a large and structured collection of text documents that is used for machine learning tasks. Corpora (plural of corpus) serve as essential resources for training, testing, and evaluating various NLP models.

For example, the word `flour` may often occur in documents that include recipes for baking. If searching for documents with `flour`, documents that include `baking` can also be retrieved as the words are often used together in a text.

TF-IDF proved to be useful for search engines in understanding a document's relevance to someone's search query. However, the TF-IDF technique doesn't take the semantic relationship between words into consideration. Synonyms or words with similar meanings aren't detected.

Though statistical techniques were valuable developments in the field of NLP, deep learning techniques created the necessary innovations to accomplish the level of NLP we have today.
