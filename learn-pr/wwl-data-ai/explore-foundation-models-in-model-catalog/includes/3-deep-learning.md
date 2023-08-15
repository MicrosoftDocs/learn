A recent technique that has had advanced the field of **Natural Language Processing** (**NLP**) is **deep learning**. Deep learning models have introduced concepts that resulted in the creation of Large Language Models (LLMs).

## Understand word embeddings

One of the key concepts introduced by applying deep learning techniques to NLP is **word embeddings**. Word embeddings solved the problem of not being able to define the semantic relationship between words.

Before word embeddings, a prevailing challenge with NLP was to detect the semantic relationship between words. Word embeddings represent words in a vector space, so that the relationship between words can be easily described and calculated.

Word embeddings are created during **self-supervised learning**. During the training process, the model analyzes the cooccurrence patterns of words in sentences and learns to represent them as **vectors**. The vectors represent the words with coordinates in a multidimensional space. The distance between words can then be calculated by determining the distance between the relative vectors, describing the semantic relationship between words.

Imagine you train a model on a large corpus of text data. During the training process, the model finds that the words `bike` and `car` are often used in the same patterns of words. Next to finding `bike` and `car` in the same text, you can also find each of them to be used when describing similar things. For example, someone may drive a `bike` or a `car`, or buy a `bike` or a `car` at a shop.

The model learns that the two words are often found in similar contexts and therefore plots the word vectors for `bike` and `car` close to each other in the vector space.

Imagine the vector space as a two-dimensional plane, where each word is given coordinates to assign the position in the space. 

:::image type="content" source="../media/word-embeddings.png" alt-text="Diagram showing word embeddings for bike and car in a vector space, compared to drive and shop.":::

1. **Boat** is closely related to **bike** and **car** but less related to each than they're to each other.
1. **Car** is closely related to **bike** as both are described in similar context, often with words like **drive** and **shop**.
1. Similarly **bike** is more closely related to **car** than **boat**, and all are related to words like **drive** and **shop** to a lesser extent.
1. **Drive** is related to **boat**, **bike**, and **car**, and less related to **shop**.
1. **Shop** is more related to **bike** and **car**, and less to **boat**.

> [!Note]
> In the example, a two-dimensional plane is used to describe word embeddings and vector spaces in simple terms. Vector spaces are often multidimensional planes with vectors representing a position in that space, similar to coordinates in a two-dimensional plane.

Though word embeddings are a great approach to detecting the semantic relationship between words, it still has its problems. For example, words with different intents like `love` and `hate` often appear related because they're used in similar context. Another problem was that the model would only use one entry per word, resulting in a word with different meanings like `bank` to be semantically related to a wild array of words.

## Adding memory to NLP models

To understand text isn't just to understand individual words, presented in isolation. Words can differ in their meaning depending on the **context** they're presented in. In other words, the sentence around a word matters to the meaning of the word.

### Using RNNs to include the context of a word

Before deep learning, including the context of a word was a task too complex and costly. One of the first breakthroughs in including the context were **Recurrent Neural Networks** (**RNNs**).

RNNs consist of multiple steps. Each step takes an **input** and a **hidden state**. Imagine the input at each step to be a new word. Each step also produces an **output**. The hidden state can serve as a memory of the network, storing the output of the previous step and passing it as input to the next step.

Imagine a sentence like:

```Vincent Van Gogh was a painter most known for creating stunning and emotionally expressive artworks, including ...```

To know what word comes next, you need to remember the name of the painter. The sentence needs to be completed, as the last word is still **masked**:

:::image type="content" source="../media/vincent-tokenized.png" alt-text="Diagram the sentence tokenized to present the most important words in a sentence as individual tokens.":::

The RNN takes each token as an input, process it, and update the hidden state with a memory of that token. When the next token is processed as new input, the hidden state from the previous step is updated.

:::image type="content" source="../media/recurrent-network.gif" alt-text="Diagram showing a recurrent network with multiple steps, each step takes an input and hidden state as input and produces an output.":::

RNNs allow for context to be included when deciphering the meaning of a word in relation to the complete sentence. However, as the hidden state of a RNN is updated with each token, the actual relevant information, or **signal**, may be lost.

In the example provided, Vincent van Gogh's name is at the start of the sentence, while the mask is at the end. At the step when the mask is processed, the hidden state might not include the name of the painter anymore. Another problem that may occur is that the painter's name is now a weak signal because of all other tokens stored in the hidden state. The latter especially happens as RNNs deem every token processed equally important.

### Improving RNNs with Long Short-Term Memory

A newer type of RNN is **Long Short-Term Memory** (**LSTM**) and is able to process sequential data by maintaining a hidden state that is updated at each step. With LSTM, the model can decide what to remember and what to forget. By doing so, context that isn't relevant or doesn't provide valuable information can be skipped, and important signals can be persisted longer.

Unlike RNNs, the next advancements in NLP were able to parallelize models in order to process larger amounts of data.
