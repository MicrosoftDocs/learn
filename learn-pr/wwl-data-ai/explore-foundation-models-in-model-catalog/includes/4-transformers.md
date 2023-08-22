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

To calculate the attention function, the query, keys, and values are all encoded to vectors. The attention function then computes the scaled dot-product between the query vector and the keys vectors. The dot-product calculates the angle between vectors, with the product being larger when the vectors are more aligned. The softmax function is used within the attention function, over the scaled dot-product of the vectors, to create a probability distribution with possible outcomes. In other words, the softmax function's output includes which keys are closest to the query. The key with the highest probability is then selected, and the associated value is the output of the attention function.

The Transformer architecture uses multi-headed attention, which means tokens are processed by the attention function several times in parallel. By doing so, a word or sentence can be processed multiple times, in various ways, to extract different kinds of information from the sentence.

## Explore the Transformer architecture

Within the Transformer architecture, attention is used three times:

- After using positional encoding on the source sentence.
- After encoding the (incomplete) target sentence.
- On the combined output of the source and target sentence, to compute the eventual output.

:::image type="content" source="../media/transformer-architecture.jpg" alt-text="Diagram the sentence tokenized to present the most important words in a sentence as individual tokens.":::

Let's imagine the following sentence as input for the model:

`Vincent Van Gogh was a painter most known for creating stunning and emotionally expressive artworks, including ..., including ...`

To predict the next word, the architecture will take tokens from the sentence and use positional encoding to encode the tokens. To simplify how the three attention mechanisms are used, let's assume that the first, the source sentence is encoded and processed with an attention function: `Vincent Van Gogh was a painter`. The incomplete target sentence to encode may then be `most known for creating stunning and emotionally expressive artworks, including ...`.

The outputted keys and values of the source sentence are combined with the query from the incomplete target sentence to the last attention mechanism. Using the learned information from the source, the model can then use the attention function to find which key is closest to the encoded query from the target sentence. In the example, we can align the information about artworks with Vincent van Gogh the painter, and therefore reason that the next word in the target sentence must be something like the famous paintings `Starry night` or `Sunflowers`.
