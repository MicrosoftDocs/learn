A large language model (LLM) is a type of AI that can process and produce natural language text. It learns from a massive amount of data such as books, articles, web pages, and images, to discover patterns and rules of language from them.

## How large are they?

An LLM is built using a neural network architecture. It takes an input, has several hidden layers that break down different aspects of language, and an output layer.

People often report how the next foundational model is bigger than the last but what does this mean? The more parameters a model has, the more data it can process, learn from, and generate.

For each connection between two neurons of the neural network architecture, there's a function: weight * input + bias.

This produces numerical values that determine how the model processes language. LLMS are very large, and growing quickly, calculating millions of parameters in 2018 to GPT4 calculating trillions of parameters in 2023.

:::image type="content" source="../media/language-parameters.png" alt-text="Diagram showing the different generations of LLMS associated with the number of parameters each model has.":::

## Where do foundational models fit into LLMs?

A foundation model refers to a specific instance or version of an LLM. For example, GPT-3, GPT-4 or Codex.

This instance is trained and fine-tuned on a large corpus of text or code (if it's the Codex model).

A foundational model takes in training data in all different formats and uses a transformer architecture to build a general model. Adaptions and specializations can be created to achieve certain tasks via prompting or fine-tuning.

## How does an LLM differ from more traditional natural language processing (NLP)?

There are a few things that separated traditional NLP and large language models.

| **Traditional NLP** | **Large language models** |
|---|---|
| **One model per capability is needed.** | Single model for a variety of natural language use cases. |
| **Provides a set of labeled data to train the ML model.** | Use many terabytes of unlabeled data in the foundation model. |
| **Highly optimized for specific use cases.** | Describe in natural language what you want the model to do. |

## What doesn't an LLM do?

 As important it is to understand what an LLM can do, it's also equally important to understand what it can't do so you choose the right tool for the job.

- **Understand language**: An LLM is just a predictive engine that pulls patterns together based on text it saw before to produce more text. It also doesn't understand math.

- **Understand facts**: An LLM doesn't have separate modes for information retrieval and creative writing; it simply predicts the next most probable token.

- **Understand manners, emotion or ethics**: An LLM can't exhibit anthropomorphism or understand anything. The output is a combination of the training data and the prompts.
