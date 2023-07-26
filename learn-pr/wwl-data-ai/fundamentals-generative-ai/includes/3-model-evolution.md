Between 2010 and 2020, language modeling approaches increased in sophistication. One of the key advances in natural language processing was the development of embedding techniques in which text is broken down into tokens (words, phrases, or even partial words) and each token is assigned a vector value. 

Picture all of the text in the world laid out page by page like a big map. Then imagine we circled one word, and drew a line between that word and another word, like drawing a line between two cities on a map. The physical distance between the words could be considered a way to describe the relationship between words. The location of the words and their relationship to one another are captured in vectors.   

We call the body of training text the *corpus* and the words that are broken down into their root form *tokens*. Consider the sentence "The sun sets in the west." 

![A gif of the tokenization process.](../media/tokenization-pipeline.gif) 

In 2013, this approach was encapsulated in the Word2Vec algorithm, which uses a deep learning model to analyze a large corpus of text and assign vector values to each discrete token.

Vectors are assigned to each token during the training process, so that the representation for each token consist of multiple numeric elements. Each element indicates the location of the word along a particular dimension, like coordinates on a map. So for example, after training is complete, the vectors for "cat" and "dog" will likely be closer together along one dimension than, say, "skateboard"; and the vector for "cat" might be close to "meow" one a dimension in which "dog" is close to "bark". That way, we can represent semantic meaning by the distance between vectors. 

![An image of words plotted in three dimensional space to show the distance between words.](../media/langue-model-vector-example.png)

The diagram above shows a simple example model in which each embedding has three dimensions. Real language models have many more dimensions; each of which relates to some kind of attribute of the word. Examples of attributes are: they are both commonly used as prepositions or they are both used in culinary terminology.

## Model evolution
Many advancements have developed beyond Word2Vec. Today, large language models are commonly used not only to understand language, but to generate new content from natural language.

Commonly used large language models in Microsoft generative AI technologies include Generative Pre-trained (GPT) models such as GPT-3 models for text and code-generation and GPT 4 models, next generation GPT optimized for chat interactions. These models can be used to design new models for specific purposes, such as DALL-E, which is based on GPT but designed for image generation. 

To get a sense of a magnitude of difference between models, the GPT-3 model contains 175B parameters (weights) while GPT-4 contains trillions. These models are developed by OpenAI, a company that partners closely with Microsoft to develop LLMs and other AI solutions. OpenAI is best known as the company behind ChatGPT, an AI chatbot app based on a GPT LLM. Microsoft's partnership with OpenAI enables Azure OpenAI users to access the latest language model innovations.

Next we will take a closer look at how large language models work to create original content based on natural language input.


