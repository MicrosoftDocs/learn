 Since the 1950's, researchers, often known as *data scientists*, have worked on different approaches to AI, broadly through **Machine learning**, a branch of AI that combines computer science and mathematics. Most modern applications of artificial intelligence in general have their origins in machine learning.  

Machine learning models try to capture the relationship between data with equations. These equations are created by taking in data (like temperature) and fitting a model to the data to make predictions (like how how many units of ice cream a store may sell that day). Temperature is a *feature*, a factor that influence the result. The result is the number of units sold in the day and is known as the *label*. 

The relationship between the temperature and units of ice cream can be visualized in a graph. On the graph, the points on the graph describe what the average temperature was on a day when a certain number of ice cream units were sold. The red line can be thought of as a simple model captures this relationship. The model allows you to predict how many ice cream units can be sold based any temperature.  

![Screenshot of the relationship between temperature and ice cream units sold in a graph.](../media/temp-ice-cream-regression-example.png) 

How well a model solves a problem can be quantified in what is known as evaluation metrics. One evaluation metric is error, which we can think of the distance between an actual label and a predicted label. In the case of the ice cream units, the model may predict 10 units will be sold in a day. If at the end of the day the store sells 15 units, the actual label is 15. We can try to improve models by reducing the overall error.

## Language modeling

Approaches to AI have advanced to complete tasks of greater complexity. **Deep learning** developed as a subset of machine learning to address complex tasks using layers of algorithms. In the beginning of the 2000's, data scientists began to use deep learning algorithms to solve for language learning problems. These approaches are categorized as **Natural language processing** (NLP) methods, which enable machines to process and understand the context of language.

Between 2010 and 2020, language modeling approaches increased in sophistication. One of the key advances in natural language processing was the development of embedding techniques in which text is broken down into tokens (words, phrases, or even partial words) and each token is assigned a vector value. 

## What are tokens?
We call the body of training text the *corpus* and the words that are broken down into their root form *tokens*. Consider the sentence `The sun sets in the west` which breaks down into key tokens `sun`, `set`, and `west`. Tokenization can be broken down into four main steps:

1. Split the words in a text based on a rule. For example, split the words where there's a space between words.
2. Merge similar words by removing the end of a word. This is known as *stemming*.
3. Remove words that have little meaning like `the` and `in`. This is known as *stop word removal*.
4. Assign a number to each unique token.

![A gif of the tokenization process.](../media/tokenization-pipeline.gif) 

## Distance between tokens
The Word2Vec algorithm was developed in 2013. It uses a deep learning model to analyze a large corpus of text and assign vector values to each discrete token.

Vectors are assigned to each token during the training process, so that the representation for each token consist of multiple numeric elements. Each element indicates the location of the word along a particular dimension, like coordinates on a map. So for example, after training is complete, the vectors for "cat" and "dog" will likely be closer together along one dimension than, say, "skateboard"; and the vector for "cat" might be close to "meow" one a dimension in which "dog" is close to "bark". That way, we can represent semantic meaning by the distance between vectors. 

![An image of words plotted in three dimensional space to show the distance between words.](../media/langue-model-vector-example.png)

The diagram above shows a simple example model in which each embedding has three dimensions. Real language models have many more dimensions; each of which relates to some kind of attribute of the word. Examples of attributes are: they are both commonly used as prepositions or they are both used in culinary terminology.

## Model evolution
Many advancements have developed beyond Word2Vec. Today, large language models are commonly used not only to understand language, but to generate new content from natural language.

Commonly used large language models in Microsoft generative AI technologies include Generative Pre-trained (GPT) models such as GPT-3 models for text and code-generation and GPT 4 models, next generation GPT optimized for chat interactions. These models can be used to design new models for specific purposes, such as DALL-E, which is based on GPT but designed for image generation. 

To get a sense of a magnitude of difference between models, the GPT-3 model contains 175 billion parameters (weights) while GPT-4 contains trillions. These models are developed by OpenAI, a company that partners closely with Microsoft to develop LLMs and other AI solutions. OpenAI is best known as the company behind ChatGPT, an AI chatbot app based on a GPT LLM. Microsoft's partnership with OpenAI enables Azure OpenAI users to access the latest language model innovations.

Next we will take a closer look at how large language models work to create original content based on natural language input.


