In this module, we will explore different neural network architectures for dealing with natural language texts. In the recent years, **Natural Language Processing** (NLP) has experienced fast growth primarily due to the performance of the language models’ ability to accurately "understand" human language faster while using unsupervised training on large text corpora. For instance, pre-trained text models such as BERT simplified many NLP tasks, and dramatically improved the performance.

We will focus on the fundamental aspects of representing NLP as tensors in PyTorch, and on classical NLP architectures such as using bag-of-words (BoW), embeddings and recurrent neural networks.

## Natural Language Tasks

There are several NLP tasks that we traditionally try to solve using neural networks:

* **Text Classification** is used when we need to classify text fragment into one of several pre-defined classes. Examples include e-mail spam detection, news categorization, assigning support request to one of the categories, and more. 
* **Intent Classification** is one specific case of text classification, when we want to map input utterance in the conversational AI system into one of the intents that represent the actual meaning of the phrase, or intent of the user. 
* **Sentiment Analysis** is a regression task, where we want to understand the degree of negativity of given piece of text. We may want to label texts in a dataset from the most negative (-1) to most positive ones (+1), and train a model that will output a number of "positiveness" of a text.
* **Named Entity Recognition** (NER) is a task of extracting some entities from text, such as dates, addresses, people names, etc. Together with intent classification, NER is often used in dialog systems to extract parameters from user's utterance. 
* A similar task of **keyword extraction** can be used to find the most meaningful words inside a text, which can then be used as tags.    
* **Text Summarization** extracts the most meaningful pieces of text, giving a user a compressed version that contains most of the meaning. 
* **Question/Answer** is a task of extracting an answer from a piece of text. This model gets text fragment and a question as an input, and needs to find exact place within the text that contains answer. For example, the text "*John is a 22 year old student who loves to use Microsoft Learn*", and the question *How old is John* should provide us with the answer *22*.

For the scope of this module, we will mostly focus on the **text classification** task. We'll use text from news headlines to classify which one of the 4 categories they belong to:  _World, Sports, Business and Sci/Tech_.

## Learning objectives

In this module you will:

- Understand how text is processed for natural language processing tasks
- Get introduced to using Recurrent Neural Networks (RNNs) and Generative Networks 
- Learn how to build text classification models  


## Prerequisites

- Basic Python knowledge
- Basic knowledge about how to use Jupyter Notebooks
- Basic understanding of machine learning
