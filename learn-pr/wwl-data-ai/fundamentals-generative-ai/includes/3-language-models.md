Over the last decades, multiple developments in the field of **natural language processing** (**NLP**) have resulted in achieving **large language models** (**LLMs**). The development and availability of language models led to new ways to interact with applications and systems, such as through generative AI assistants and agents. There are a few key conepts to understand about modern language models: 

- How they *read*  
- How they understand the relationship between words 
- How they remember what was said  

## Understanding tokenization

As you may expect, machines have a hard time deciphering text as they mostly rely on numbers. To *read* text, we therefore need to convert the presented text to numbers.

One important development to allow machines to more easily work with text has been tokenization. **Tokens** are strings with a known meaning, usually representing a word. **Tokenization** is turning words into tokens, which are then converted to numbers. A statistical approach to tokenization is by using a pipeline:

:::image type="content" source="../media/tokenization-pipeline.gif" alt-text="Animation showing the pipeline of tokenization of a sentence.":::

1. Start with the text you want to **tokenize**.
1. **Split** the words in the text based on a rule. For example, split the words where there's a white space.
1. **Stemming**. Merge similar words by removing the end of a word.
1. **Stop word removal**. Remove noisy words that have little meaning like `the` and `a`. A dictionary of these words is provided to structurally remove them from the text.
1. **Assign a number** to each unique token.

Tokenization allowed for text to be labeled. As a result, statistical techniques could be used to let computers find patterns in the data instead of applying rule-based models.

## Understand word embeddings

One of the key concepts introduced by applying deep learning techniques to NLP is **word embeddings**. Word embeddings solved the problem of not being able to define the semantic relationship between words.

Before word embeddings, a prevailing challenge with NLP was to detect the semantic relationship between words. Word embeddings represent words in a vector space, so that the relationship between words can be easily described and calculated.

Word embeddings are created during **self-supervised learning**. During the training process, the model analyzes the cooccurrence patterns of words in sentences and learns to represent them as **vectors**. The vectors represent the words with coordinates in a multidimensional space. The distance between words can then be calculated by determining the distance between the relative vectors, describing the semantic relationship between words.

Imagine you train a model on a large corpus of text data. During the training process, the model finds that the words `bike` and `car` are often used in the same patterns of words. Next to finding `bike` and `car` in the same text, you can also find each of them to be used when describing similar things. For example, someone may drive a `bike` or a `car`, or buy a `bike` or a `car` at a shop.

The model learns that the two words are often found in similar contexts and therefore plots the word vectors for `bike` and `car` close to each other in the vector space.

Imagine we have a three-dimensional vector space where each dimension corresponds to a semantic feature. In this case, let's say the dimensions represent factors like *vehicle type*, *mode of transportation*, and *activity*. We can then assign hypothetical vectors to the words based on their semantic relationships:

:::image type="content" source="../media/word-embeddings-vectors.png" alt-text="Diagram showing word embeddings for bike and car in a vector space, compared to drive and shop.":::

1. `Boat` [2, 1, 4] is close to `drive` and `shop`, reflecting that you can drive a boat and visit shops near bodies of water.
1. `Car` [7, 5, 1] closer to `bike` than `boat` as cars and bikes are both used on land rather than on water.
1. `Bike` [6, 8, 0] is closer to `drive` in the *activity* dimension and close to `car` in the *vehicle type* dimension.
1. `Drive` [8, 4, 3] is close to `boat`, `car` and `bike`, but far from `shop` as it describes a different kind of activity.
1. `Shop` [1, 3, 5] is closest to `bike` as these words are most commonly used together.

> [!Note]
> In the example, a three-dimensional plane is used to describe word embeddings and vector spaces in simple terms. Vector spaces are often multidimensional planes with vectors representing a position in that space, similar to coordinates in a two-dimensional plane.

Though word embeddings are a great approach to detecting the semantic relationship between words, it still has its problems. For example, words with different intents like `love` and `hate` often appear related because they're used in similar context. Another problem was that the model would only use one entry per word, resulting in a word with different meanings like `bank` to be semantically related to a wild array of words.

## Understand the need for context 

To understand text isn't just to understand individual words, presented in isolation. Words can differ in their meaning depending on the **context** they're presented in. In other words, the sentence around a word matters to the meaning of the word.

Before deep learning, including the context of a word was a task too complex and costly. One of the first breakthroughs in including the context were **Recurrent Neural Networks** (**RNNs**).

RNNs consist of multiple sequential steps. Each step takes an **input** and a **hidden state**. Imagine the input at each step to be a new word. Each step also produces an **output**. The hidden state can serve as a memory of the network, storing the output of the previous step and passing it as input to the next step.

Imagine a sentence like:

```Vincent Van Gogh was a painter most known for creating stunning and emotionally expressive artworks, including ...```

To know what word comes next, you need to remember the name of the painter. The sentence needs to be completed, as the last word is still *missing*. A missing or **masked** word in NLP tasks is often represented with `[MASK]`. By using the special `[MASK]` token in a sentence, you can let a language model know it needs to predict what the missing token or value is.

Simplifying the example sentence, you can provide the following input to an RNN: `Vincent was a painter known for [MASK]`:

:::image type="content" source="../media/vincent-tokenized.png" alt-text="Diagram showing the sentence tokenized to present the most important words in a sentence as individual tokens.":::

The RNN takes each token as an input, process it, and update the hidden state with a memory of that token. When the next token is processed as new input, the hidden state from the previous step is updated.

Finally, the last token is presented as input to the model, namely the `[MASK]` token. Indicating that there's information missing and the model needs to predict its value. The RNN then uses the hidden state to predict that the output should be something like `Starry Night`

:::image type="content" source="../media/recurrent-network.gif" alt-text="Diagram showing a recurrent network with multiple steps. Each step takes an input and hidden state as input and produces an output.":::

#### Challenges with RNNs

In the example, the hidden state contains the information `Vincent`, `is`, `painter`, and `know`. With RNNs, each of these tokens are equally important in the hidden state, and therefore equally considered when predicting the output.

RNNs allow for context to be included when deciphering the meaning of a word in relation to the complete sentence. However, as the hidden state of an RNN is updated with each token, the actual relevant information, or **signal**, may be lost.

In the example provided, Vincent Van Gogh's name is at the start of the sentence, while the mask is at the end. At the final step, when the mask is presented as input, the hidden state may contain a large amount of information that is irrelevant for predicting the mask's output. Since the hidden state has a limited size, the relevant information may even be deleted to make room for new and more recent information.

When we read this sentence, we know that only certain words are essential to predict the last word. An RNN however, includes all (relevant and irrelevant) information in a hidden state. As a result, the relevant information may become a *weak signal* in the hidden state, meaning that it can be overlooked because there's too much other irrelevant information influencing the model.

So far, we described how language models can read text through *tokenization* and how they can understand the relationship between words through *word embeddings*. We also explored how past language models tried to capture the context of words. Next, learn how the limitations of previous models are handled in today's language models with transformer architecture. 
