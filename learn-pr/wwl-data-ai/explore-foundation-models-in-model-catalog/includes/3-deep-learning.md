A recent technique that has had advanced the field of **Natural Language Processing** (**NLP**) is **deep learning**. Deep learning models have introduced concepts that resulted in the creation of Large Language Models (LLMs).

## Understand word embeddings

One of the key concepts introduced by applying deep learning techniques to NLP is **word embeddings**. Word embeddings solved the problem of not being able to define the semantic relationship between words.

Before word embeddings, a prevailing challenge with NLP was to detect the semantic relationship between words. Word embeddings represent words in a vector space, so that the relationship between words can be easily described and calculated.

Word embeddings are created during **self-supervised learning**. During the training process, the model analyzes the cooccurrence patterns of words in sentences and learns to represent them as **vectors**. The vectors represent the words with coordinates in a multidimensional space. The distance between words can then be calculated by determining the distance between the relative vectors, describing the semantic relationship between words.

:::image type="content" source="../media/word-embeddings.png" alt-text="Diagram showing word embeddings for king and queen in a vector space, compared to cat and dog.":::

Imagine you train a model on a large corpus of text data. During the training process, the model finds that the words `king` and `queen` are often used in the same patterns of words. Though they may also be used together, in the same sentence, you can also find them to be used when describing similar things. For example, in one text a `king` is described to live in a castle, where in another text a `queen` is also said to live in a castle.

The model learns that the two words are often found in similar contexts and therefore plots the word vectors for `king` and `queen` close to each other in the vector space.

Though word embeddings were a great approach to detecting the semantic relationship between words, it still had its problems. For example, words with different intents like `love` and `hate` often show to be related because they're used in similar context. Another problem was that the model would only use one entry per word, resulting in a word with different meanings like `bank` to be semantically related to a wild array of words.

## Adding memory to NLP models

To understand text isn't just to understand individual words, presented in isolation. Words can differ in their meaning depending on the **context** they're presented in. In other words, the sentence around a word matters to the meaning of the word.

### Using RNNs to include the context of a word

Before deep learning, including the context of a word was a task too complex and costly. One of the first breakthroughs in including the context were **Recurrent Neural Networks** (**RNNs**).

RNNs consist of multiple steps. Each step takes an **input** and a **hidden state**. Imagine the input at each step to be a new word. Each step also produces an **output**. The hidden state can serve as a memory of the network, storing the output of the previous step and passing it as input to the next step.

:::image type="content" source="../media/recurrent-network.png" alt-text="Diagram showing a recurrent network with multiple steps, each step takes an input and hidden state as input and produces an output.":::

RNNs allow for context to be included when deciphering the meaning of a word in relation to the complete sentence. However, RNNs can't remember far and can't be parallelized. Imagine a sentence like:

```Vincent Van Gogh was a painter most known for creating stunning and emotionally expressive artworks, including ...```

To know what word comes next, you need to remember the name of the painter. As an RNN deems every word in the sentence equally important, and the painter's name came so far before, the model's *memory* might not include the relevant information or signal anymore to predict the next words: `Starry Night`.

### Improving RNNs with Long Short-Term Memory

A newer type of RNN is **Long Short-Term Memory** (**LSTM**) and is able to process sequential data by maintaining a hidden state that is updated at each step. With LSTM, the model can decide what to remember and what to forget. By doing so, context that isn't relevant or doesn't provide valuable information can be skipped, and important signals can be persisted longer.

Unlike RNNs, the next advancements in NLP were able to parallelize models in order to process larger amounts of data.
