Common **Natural Language Processing** (**NLP**) tasks harness the capabilities of **Large Language Models** (**LLMs**) to address a wide range of language-related challenges.

These tasks include:

- **Summarization**: Condense lengthy texts into concise summaries.
- **Sentiment analysis**: Identifies the emotional tone of text.
- **Translation**: Convert text between languages.
- **Zero-shot classification**: Categorize text into predefined labels without prior examples.
- **Few-shot learning**: Adapt to new tasks with minimal training data.

These versatile applications demonstrate the transformative potential of LLMs in processing and understanding human language.

Let's explore each of these tasks in more detail.

## Summarize text

**Summarization** is a common NLP task where a language model condenses a lengthy piece of text into a shorter version while preserving the key information and main ideas.

There are two types of summarization:

- **Extractive** summarization involves selecting important sentences or phrases directly from the source text.
- **Abstractive** summarization generates new sentences that capture the essence of the original text.

LLMs, with their advanced understanding of context and language, excel in abstractive summarization, producing coherent and contextually accurate summaries.

You can use summarization in various applications, like generating news briefs, summarizing research papers, and creating concise reports.

:::image type="content" source="../media/03-summarization.png" alt-text="Illustration of a news article that is summarized for a phone feed." lightbox="../media/03-summarization.png":::

## Perform sentiment analysis

**Sentiment analysis**, also known as **opinion mining**, is the process of determining the emotional tone behind a body of text.

Sentiment analysis involves classifying the text into categories such as *positive*, *negative*, or *neutral* sentiment.

LLMs are highly effective at this task due to their ability to understand nuanced language and context. By analyzing word choice, sentence structure, and context, these models can accurately gauge the sentiment expressed in reviews, social media posts, customer feedback, and more.

Sentiment analysis is widely used in businesses to monitor brand reputation, gauge customer satisfaction, and understand public opinion on various topics.

:::image type="content" source="../media/sentiment-analysis.png" alt-text="Diagram of two examples for sentiment analysis.":::

## Translate text

**Translation** is the task of converting text from one language to another, and LLMs revolutionized this field with their ability to perform high-quality machine translation.

These language models use vast multilingual datasets and sophisticated neural network architectures to understand and generate text in multiple languages. LLMs can capture the nuances and idiomatic expressions of different languages, and produce translations that aren't only accurate but also contextually appropriate.

Compared to previous techniques for translation, LLMs are often more accurate as they can understand the semantic meaning of a text before translating it, which results in less literal translations.

Machine translation powered by LLMs is essential for global communication, enabling businesses, governments, and individuals to interact across language barriers with greater ease and accuracy.

## Use zero-shot classification

**Zero-shot classification** is a technique where an LLM can categorize text into predefined labels without seeing any labeled examples during training.

Zero-shot classification is achieved by using the model's extensive general knowledge and language understanding.

You provide a natural language description of the labels, and the model classifies the text based on this input.

Zero-shot classification is highly versatile and efficient, as it eliminates the need for large, labeled training datasets specific to each new task. This capability is useful in fields where new categories emerge frequently, allowing for immediate adaptation and application.

:::image type="content" source="../media/zero-shot-classification.png" alt-text="Diagram of two examples for zero-shot classification.":::

## Use few-shot learning

When you use **few-shot learning**, you provide an LLM with a few examples before it performs a specific task.

Providing a model with a few examples, enables the model to quickly adapt to new tasks with minimal data, using its pre-existing language knowledge.

Few-shot learning is advantageous in scenarios where labeled data is scarce or expensive to obtain. By providing a handful of examples, you can guide the model to perform specialized tasks such as domain-specific text classification, custom sentiment analysis, or entity recognition.

The flexibility and efficiency make few-shot learning a powerful tool for deploying LLMs in diverse real-world applications.

For example, explore the following prompt that includes few-shot learning:

```md
## Instructions
For each tweet, describe its sentiment.

## Examples 
Tweet: I hate it when my phone battery dies
Sentiment: Negative

Tweet: My has been great
Sentiment: Positive

Tweet: This is the ink to the article
Sentiment: Neutral

Tweet: This new music video was incredible
Sentiment: 
```

The LLM uses the examples to understand what it needs to do and completes the prompt by returning the sentiment of the last tweet.

Now that you explored various tasks for LLMs, you can use Azure Databricks to experiment with open-source LLMs and test their capabilities with prompts.
