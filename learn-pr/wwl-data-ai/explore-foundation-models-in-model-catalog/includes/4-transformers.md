The latest breakthrough in **Natural Language Processing** (**NLP**) is owed to the development of the **Transformer** architecture.

Transformers were introduced in the [*Attention is all you need* paper by Vaswani, et al. from 2017](https://arxiv.org/abs/1706.03762?azure-portal=true). The Transformer architecture provides an alternative to the **Recurrent Neural Networks** (**RNNS**) to do NLP. Whereas RNNs are compute-intensive since they process words sequentially, Transformers don't process the words sequentially, but instead process each word independently in parallel. The two most important techniques Transformers use to more optimally process text are **positional encoding** and **multi-headed attention**.

## Understand positional encoding

A common approach to encode words in text has been to use word embeddings. Word embeddings allow you to encode the meaning of a word by understanding the relationship between words. **Positional encoding** differs in that it encodes the position of a word in a sentence, as the position of a word is often an indication of the type of word it is.

## Understand multi-headed attention

The most important technique used by Transformers to process text, is the use of attention instead of recurrence. **Attention** (also referred to as self-attention or intra-attention) is a mechanism used to map new information to learned information, in order to understand what the new information entails. Transformers use an attention *function*, where a new word is encoded (using positional encoding) and represented as a **query**. The output of an encoded word is a **key** with an associated **value**.

To illustrate the three variables that are used by the attention function: the query, keys, and values, let's explore a simplified example. Imagine the Transformer encoding the sentence `Vincent van Gogh is a painter, known for his stunning and emotionally expressive artworks.` When encoding the query `Vincent van Gogh`, the output may be `Vincent van Gogh` as the key with `painter` as the associated value. The architecture stores keys and values in a table, which it can then use for future decoding:

|Keys|Values|
|-----|-----|
|Vincent van Gogh|Painter|
|William Shakespeare|Playwright|
|Charles Dickens|Writer|

Whenever a new sentence is presented like `Shakespeare's work has influenced many movies, mostly thanks to his work as a ...` The model can complete the sentence by taking `Shakespeare` as the query and *finding* it in the table of keys and values. `Shakespeare` the query is closest to `William Shakespeare` the key, and thus the associated value `playwright` is presented as the output.

### Using the scaled dot-product to compute the attention function

To calculate the attention function, the query, keys, and values are all encoded to vectors. The attention function then computes the scaled dot-product between the query vector and the keys vectors to find the key that most aligns with the query. 

The attention function finds the key that best aligns with the encoded query. When encoding both the key and query, a vector is created to represent the encoded token. By calculating the scaled dot-product between the query and each key, you'll find the two vectors that are most aligned, or the key that is most similar to the query.


- Keys: 
- Values:
- Queries

An attention function can be described as mapping a query and a set of key-value pairs to an output,
where the query, keys, values, and output are all vectors. The

Three kinds of attention:

- Attention over input sentence.
- Output sentence is encoded.
- Top right is most important attention. Source is combined with target sentence.

Key connections to the third are the:

- Keys
- Values: output by the encoding part of the source sentence
- Queries: output by the encoding part of target sentence

Calculates dot product of Query and Keys. Dot product gives angle between vectors. Dot product is larger the more aligned the vectors are.
Each key is associated with a value.
A query is a vector. Use dot product to find the key that is closest to the query.
Soft max to make the numbers more different from each other (almost 1 or almost 0).


## Explore the Transformer architecture
