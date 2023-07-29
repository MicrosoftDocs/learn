Generative AI applications are powered by *large language models* (LLMs), which are a specialized type of machine learning model that you can use to perform *natural language processing* (NLP) tasks, including:

- Determining *sentiment* or otherwise classifying natural language text.
- Summarizing text.
- Comparing multiple text sources for semantic similarity.
- Generating new natural language.

While the mathematical principles behind these LLMs can be complex, a basic understanding of the architecture used to implement them can help you gain a conceptual udnerstanding of how they work.

## Transformer models

Machine learning models for natural language processing have evolved over many years. Today's cutting-edge large language models are based on the *transformer* architecture, which builds on and extends some techniques that have been proven successful in modeling *vocabularies* to support NLP tasks - and in particular in generating language. Transformer models are trained with large volumes of text, enabling them to represent the semantic relationships between words and use those relationships to determine probable sequences of text that make sense. Tramsformer models with a large enough vocabulary are capable of generating language responses that can be very difficult, it not impossible, to distinguish from those of a human.

While a complete explanation of every aspect of tramsformer models is beyond the scope of this module, an explanation of some of the key elements in a transformer can help you get a sense for how they support generaive AI.

### Tokenization

The first step in training a transformer model is to decompose the training text into *tokens* - in other words, identify each unique text value. For the sake of simplicity, you can think of each distinct word in the training text as a token (though in reality, tokens can be generated for partial words, or combinations of words and punctuation).

For example, consider the following sentence:

*I heard a dog bark loudly at a cat*

To tokenize this text, you can identify each discrete word and assign token IDs to them. For example:

- I (1)
- heard (2)
- a (3)
- dog (4)
- bark (5)
- loudly (6)
- at (7)
- *("a" is already tokenized as 3)*
- cat (8)

The sentence can now be represented by the tokens: *[1 2 3 4 5 6 7 3 8]*. Similarly, the sentence "I heard a cat" could be represented as *[1 2 3 8]*.

As you continue to train the model, each new token in the training text is added to the vocabulary with appropriate token IDs:

- meow (9)
- skateboard (10)
- *and so on...*

With a sufficiently large set of training text, a vocabulary of many thousands of tokens could be compiled.

### Embeddings

While it may be convenient to represent tokens as simple IDs - essentially creating an index for all the words in the vocabulary, they don't tell us anything about the meaning of the words, or the relationships between them. To create a vocabulary that encapsulates semantic relationships between the tokens, we define contextual vectors, known as *embeddings*, for them. Vectors are multi-valued numeric representations of information, for example [10, 3, 1] in which each numeric element represents a particular attribute of the information. In the case of language tokens, each element of a token's vector represents some semantic attribute of the token. The specific categories for the elements of the vectors in a language model are determined during training based on how commonly words are used together or in similar contexts.

It can be useful to think of the elements in a token embedding vector as *coordinates* in multidimensional space, so that each token occupies a specific "location". The closer tokens are to one another along a particular dimension, the more semantically related they are. In other words, related words are grouped closer together. As a simple example, suppose our embeddings consist of vectors with three elements. We can plot the location of tokens based on these vectors in three-dimensional space, like this:

![Diagram of token vectors plotted in three dimensional space.](../media/language-model-vectors.png)

The diagram above shows a simple example model in which each embedding has three dimensions. Real language models have many more dimensions; each of which relates to some kind of attribute of the word, such terminology to talk about animals.

## Attention
One of the key elements in advancements in language modeling is attention layers. These layers of mathematical functions enable the model to analyze the sequence of text tokens in context and determine which tokens most influence the next in sequence. For example, given the sequence “I heard a dog”, the attention layer might assign greater weight to the tokens “heard” and “dog” when considering the next word in the sequence, like this:

I heard a dog [bark].

Consider how the next word in the sequence would be different if the model assigned greater weight to "I" and "heard". In that case, the next word could be `fireworks`, but that would not make sense with the full sequence `I heard a dog [fireworks]`. It’s important to remember that the attention layer is actually working with the vector embeddings, not the actual text and that the next word is a sequence is generated by a numeric calculation.  

The relationship between words enables models to understand context. A major step forward from embedding algorithms like Word2Vec was the development of the transformer model architecture. Transformer architecture is designed to predict the next word in a sequence based on the preceding text. Next we will take a closer look at transformer architecture in large language models. 
