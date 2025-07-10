To fine-tune a Large Language Model (LLM) with Azure Databricks, you first need to collect and prepare your dataset.

The data preparation process varies depending on which fine-tuning approach you choose. This unit focuses on preparing data for Azure OpenAI models. If you're working with Hugging Face models instead, you can learn more about [preparing data for Hugging Face fine-tuning](/azure/databricks/machine-learning/train-model/huggingface/load-data?azure-portal=true).

## Identify your data requirements

Before you start fine-tuning, you need to understand what makes effective training data. While Azure OpenAI fine-tuning can be used for various text-based tasks, this unit focuses on conversational data that teaches the model how to respond in chat and question-answering scenarios.

Your training data should represent the kinds of conversations you want your fine-tuned model to handle. If you're building a customer support chatbot, include real customer questions and ideal responses. If you're creating a technical assistant, include technical queries and expert answers.

For Azure OpenAI fine-tuning, your data must be in JSONL (JSON Lines) format. Each line contains a separate JSON object representing one training example, which works well for structuring conversation data with prompts and responses.

## Prepare your data

While fine-tuning can be used for various applications, this section focuses on preparing data for chat and question-answering scenarios, which are the most common uses for Azure OpenAI fine-tuning.

To fine-tune a model for these conversational scenarios, create a training dataset that consists of conversational exchanges reflecting the type of interactions you want the model to handle.

Include the following key elements in your dataset:

- **Prompts and responses**: Each entry should have a prompt (the question or statement) and a corresponding response (the answer or reply).
- **Contextual information**: If your chat involves multi-turn conversations, include context from previous turns. Context helps the model understand the flow of the conversation and generate more coherent responses.
- **Diverse examples**: Include various questions and answers to cover different topics and scenarios. Diverse examples help the model generalize better and handle a wide range of queries.
- **Human-generated responses**: Use human-generated responses to train the model. Human-generated responses ensure that the model learns to generate natural and accurate replies.

Well-prepared data is the foundation of successful fine-tuning, so investing time in creating high-quality, representative training examples will affect your model's performance.
