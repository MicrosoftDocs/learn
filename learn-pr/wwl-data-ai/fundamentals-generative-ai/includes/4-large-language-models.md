Large language models need to understand grammar, syntax, semantics, and other language patterns. The model learns the relationship of words to one another by taking in a vast amount of text data. In fact, for the models that we use today to be so good, they use terabytes of text data to train.

## What is a pre-trained Large Language Model? 

#### Transformer architecture captures context
The relationship between words enables models to understand context. A major step forward from embedding algorithms like Word2Vec was the development of the transformer model architecture. Transformer architecture is designed to predict the next word in a sequence based on the preceding text.  
 
Transformers are deep learning models that pass embedded token vectors to layers that train a model to predict sequences of text tokens – in other words, they can generate language by determining the most probable sequence of words to complete a stream of text. The original transformer model architecture defines two blocks of layers: a block of encoder layers that generate contextualized token representations for a sequence of text (for example, encoding the word “bark” differently depending on the context within the sequence of words; because “I heard a dog bark” means something different to “the bark of a tree”), and a block of decoder layers that take the output of the encoder and iteratively generate a probable output sequence. 

Transformer models use additional attention (particularly self-attention) to predict words from context (e.g. "Use machine leaning to train a model" vs "Catch a train to London") – in other words, the model learns to identify these two different types of “train” as different words with different semantic meaning. 

#### Neural Networks enable calculations for token prediction 
Neural networks are based on a transformer architecture. Neural networks are trained by passing huge volumes of data through multiple layers of "neurons" that apply calculations to data using "weights". The output from the final layer is compared to a known true value and the level of error is used to iteratively adjust the weights so the model predicts more accurately. 

![Image of a neural network with layers.](../media/neural-network-layers-example.png)

GPT models are transformer neural networks that interpret words (more accurately, linguistic tokens) as numeric vectors and predict the next in sequence. By using millions of token sequences, the model is trained to apply weights that result in correct predictions of completions (i.e. from a few words, the rest of the sentence can be predicted). 

Mapping huge volume of data enables the model to learn language patters. The resulting model not only returns a sequence of words, it can return responses that make sense to humans because they are based in existing learned language patterns. 

#### Common Models
With all this complexity, you can imagine there is more than one way to solve for a problem. Each pre-trained model is a way of solving the problem of language understanding. Common transformer-based LLMs include the BERT model (which is used to power Google search) and GPT models from OpenAI. 

All of these models can be improved or customized. These pre-trained models can be fed more information about how to behave. Using more information is called "few-shot" learning. Not using more information is known as "zero-shot" learning. 

Next we will see how Microsoft provides access to large language models through Azure OpenAI.