Large language models need to understand grammar, syntax, semantics, and other language patterns. The model learns the relationship of words to one another by taking in a vast amount of text data. In fact, for the models that we use today to be so good, they used [XYZ amount] to train.

## What is a pre-trained Large Language Model? 
Picture all of the text in the world laid out page by page like a big map. Then imagine we circled one word, and drew a line between that word and another word, like drawing a line between two cities on a map. The physical distance between the words could be considered a way to describe the relationship between words. The location of the words and their relationship to one another are captured in vectors.   

We call the body of training text the *corpus* and the words that are broken down into their root form *tokens*. In this way, the commonality between words like "running", "runner", "runs" could be captured through the token `run`. 

Vectors are assigned to each word during the training process, so that the representation for each token consist of multiple numeric elements. Each element indicates the location of the word along a particular dimension, like coordinates on a map. So for example, after training is complete, the vectors for "cat" and "dog" will likely be closer together along one dimension than, say, "skateboard"; and the vector for "cat" might be close to "meow" one a dimension in which "dog" is close to "woof". That way, we can represent semantic meaning by the distance between vectors. 

#### Transformer architecture captures context
Transformer architecture is designed to predict the next word in a sequence based on the preceding text.  

The relationship between words enables models to understand context. 

Transformer models use attention (particularly self-attention) to predict words from context (e.g. "Use machine leaning to train a model" vs "Catch a train to London") – in other words, the model learns to identify these two different types of “train” as different words with different semantic meaning. 

#### Neural Networks enable calculations for token prediction 
Neural networks are based on a transformer architecture. Neural networks are trained by passing huge volumes of data through multiple layers of "neurons" that apply calculations to data using "weights". The output from the final layer is compared to a known true value and the level of error is used to iteratively adjust the weights so the model predicts more accurately. 

Generative Pre-trained (GPT) models are transformer neural networks that interpret words (more accurately, linguistic tokens) as numeric vectors and predict the next in sequence. By using millions of token sequences, the model is trained to apply weights that result in correct predictions of completions (i.e. from a few words, the rest of the sentence can be predicted). 

Mapping huge volume of data enables the model to learn language patters. The resulting model not only  returns a sequence of words, it can return responses that make sense to humans because they are based in existing learned language patterns. 

#### Common Models
With all this complexity, you can imagine there is more than one way to solve for a problem. Each pre-trained model is a way of solving the problem of language understanding. Common transformer based LLMs include the BERT model (which is used to power Google search) and Generative Pre Trained (GPT) models from OpenAI. 

All of these models can be improved or customized. These pre-trained models can be fed more information about how to behave. Using more information is called "few-shot" learning. Not using more information is known as "zero-shot" learning. 

Next we will take a look at how models have evolved and some constraints.  