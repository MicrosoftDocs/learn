In this module, we will explore different neural network architectures for dealing with natural language text. In recent years, **Natural Language Processing** (NLP) has experienced fast growth as a field, both because of improvements to the language model architectures and because they've been trained on increasingly large text corpora. As a result, their ability to "understand" text has vastly improved, and large pre-trained models such as BERT have become widely used.

We will focus on the fundamental aspects of representing NLP as tensors in TensorFlow, and on classical NLP architectures, such as using bag-of-words, embeddings and recurrent neural networks.

## Natural Language Tasks

There are several NLP tasks that we can solve using neural networks:
* **Text Classification** is used when we need to classify a text fragment into one of several predefined classes. Examples include e-mail spam detection, news categorization, assigning a support request to a category, and more. 
* **Intent Classification** is one specific case of text classification, where we want to map an input utterance in the conversational AI system into one of the intents that represent the actual meaning of the phrase, or intent of the user. 
* **Sentiment Analysis** is a regression task, where we want to understand the degree of positivity of a given piece of text. We may want to label text in a dataset from most negative (-1) to most positive (+1), and train a model that will output a number representing the positivity of the input text.
* **Named Entity Recognition** (NER) is the task of extracting entities from text, such as dates, addresses, people names, etc. Together with intent classification, NER is often used in dialog systems to extract parameters from the user's utterance. 
* A similar task of **Keyword Extraction** can be used to find the most meaningful words inside a text, which can then be used as tags.    
* **Text Summarization** extracts the most meaningful pieces of text, giving the user a compressed version of the original text. 
* **Question Answering** is the task of extracting an answer from a piece of text. This model takes a text fragment and a question as input, and finds the exact place within the text that contains the answer. For example, the text "*John is a 22 year old student who loves to use Microsoft Learn*", and the question *How old is John* should provide us with the answer *22*.

In this module, we will mostly focus on the **Text Classification** task. However, we will learn all the important concepts that we need to handle more difficult tasks in the future.

## Learning objectives
- Understand how text is processed for NLP tasks
- Learn about Recurrent Neural Networks (RNNs) and Generative Neural Networks (GNNs)
- Learn about Attention Mechanisms
- Learn how to build text classification models

## Prerequisites
- Knowledge of Python
- Basic understanding of machine learning