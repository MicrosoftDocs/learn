Large language models need to understand grammar, syntax, semantics, and other language patterns. The model learns the relationship of words to one another by taking in a vast amount of text data. In fact, for the models that we use today to be so good, they use terabytes of text data to train.

## What is a pre-trained Large Language Model? 

Large language models are designed to work with numeric data values. Numeric calculations are at the heart of all computer processing – fundamentally, the foundation of AI is mathematics. the goal of this exploration is simply to gain a conceptual understanding, an intuition if you will, of the principles on which common machine learning models work.

#### Transformer architecture captures context
The relationship between words enables models to understand context. A major step forward from embedding algorithms like Word2Vec was the development of the transformer model architecture. Transformer architecture is designed to predict the next word in a sequence based on the preceding text.  
 
Transformers are deep learning models that pass embedded token vectors to layers that train a model to predict sequences of text tokens – in other words, they can generate language by determining the most probable sequence of words to complete a stream of text. The original transformer model architecture defines two blocks of layers: a block of encoder layers that generate contextualized token representations for a sequence of text (for example, encoding the word “bark” differently depending on the context within the sequence of words; because “I heard a dog bark” means something different to “the bark of a tree”), and a block of decoder layers that take the output of the encoder and iteratively generate a probable output sequence. 

#### Neural Networks enable calculations for token prediction 
Neural networks are based on a transformer architecture. Neural networks are trained by passing huge volumes of data through multiple layers of "neurons" that apply calculations to data using "weights". The output from the final layer is compared to a known true value and the level of error is used to iteratively adjust the weights so the model predicts more accurately. 

GPT models are transformer neural networks that interpret words (more accurately, linguistic tokens) as numeric vectors and predict the next in sequence. By using millions of token sequences, the model is trained to apply weights that result in correct predictions of completions (i.e. from a few words, the rest of the sentence can be predicted). 

Mapping huge volume of data enables the model to learn language patters. The resulting model not only returns a sequence of words, it can return responses that make sense to humans because they are based in existing learned language patterns. 

## most probable next word 

#### Common Models
With all this complexity, you can imagine there is more than one way to solve for a problem. Each pre-trained model is a way of solving the problem of language understanding. Common transformer-based LLMs include the BERT model (which is used to power Google search) and GPT models from OpenAI. 

All of these models can be improved or customized. These pre-trained models can be fed more information about how to behave. Using more information is called "few-shot" learning. Not using more information is known as "zero-shot" learning. 

Next we will see how Microsoft provides access to large language models through Azure OpenAI.

## Advancements in models
Many advancements have developed beyond Word2Vec. Today, large language models are commonly used not only to understand language, but to generate new content from natural language.

Commonly used large language models in Microsoft generative AI technologies include Generative Pre-trained (GPT) models such as GPT-3 models for text and code-generation and GPT 4 models, next generation GPT optimized for chat interactions. These models can be used to design new models for specific purposes, such as DALL-E, which is based on GPT but designed for image generation. 

To get a sense of a magnitude of difference between models, the GPT-3 model contains 175 billion parameters (weights) while GPT-4 contains trillions.

Next we will take a closer look at how large language models work to create original content based on natural language input.