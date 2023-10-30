Azure AI Language service provides pretrained and customizable deep learning models to analyze text. These models use tokens and embeddings to turn words into numerical representations. Deep learning models perform calculations on these numerical representations to provide responses returned in natural language. 

## Tokenization
Tokens represent each unique text value. For the sake of simplicity, you can think of each distinct word in the training text as a token (though in reality, tokens can be generated for partial words, or combinations of words and punctuation).

The sentence "I heard a dog bark loudly at a cat" can be presented as tokens:
- I 
- heard
- a
- dog
- bark
- loudly
- at
- cat

Tokens can be generated for partial words. Consider the following concepts that influence the creation of tokens: 

- **Stop words** are words that should be excluded from the analysis. For example, "the", "a", or "then" make text easier for people to read but add little semantic meaning. By excluding these words, a machine learning model is better able to identify the important words. 
- **n-grams** are multi-term phrases such as "I have" or "he walked". A single word phrase is a *unigram*, a two-word phrase is a *bi-gram*, a three-word phrase is a *tri-gram*, and so on. By considering words as groups, a machine learning model can make better sense of the text. 
- **Stemming** algorithms are applied to normalize words before counting them so that words like "power", "powered", and "powerful" are interpreted as being the same word.

Natural language processing assigns token IDs to tokens. For example:
- I (1)
- heard (2)
- a (3)
- dog (4)
- bark (5)
- loudly (6)
- at (7)
- ("a" is already tokenized as 3)
- cat (8)

The sentence can now be represented with the tokens: [1 2 3 4 5 6 7 3 8]. Similarly, the sentence "I heard a cat" could be represented as [1 2 3 8].

## Embeddings
Token sequences are used to create vectors known as embeddings. Embeddings capture the relationship between tokens and are determined during training based on how commonly words are used together or in similar contexts.

It can be useful to think of the elements in a token embedding vector as coordinates in multidimensional space, so that each token occupies a specific "location." The closer tokens are to one another along a particular dimension, the more semantically related they are. In other words, related words are grouped closer together. As a simple example, suppose the embeddings for our tokens consist of vectors with three elements, for example:

- 4 ("dog"): [10.3.2]
- 5 ("bark"): [10,2,2]
- 8 ("cat"): [10,3,1]
- 9 ("meow"): [10,2,1]
- 10 ("skateboard"): [3,3,1]
We can plot the location of tokens based on these vectors in three-dimensional space, like this:

![A diagram of words plotted on a three-dimensional space.](../media/example-embeddings-graph.png)

The locations of the tokens in the embeddings space include some information about how closely the tokens are related to one another. For example, the token for "dog" is close to "cat" and also to "bark." The tokens for "cat" and "bark" are close to "meow." The token for "skateboard" is further away from the other tokens.

The language models we use in industry are based on these principles but have greater complexity. For example, the vectors used may have many more dimensions. There are also multiple ways you can calculate appropriate embeddings for a given set of tokens. Different methods result in different predictions from natural language processing models.

