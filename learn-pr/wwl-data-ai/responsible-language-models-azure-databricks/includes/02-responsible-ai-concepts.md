To ensure your AI system behaves as expected, you need to evaluate your Generative AI (Gen AI) application. You need to check the effectiveness of the Large Language Model (LLM) solution, identify any biases or ethical concerns, ensure user satisfaction, and evaluate the cost and overall functionality of the AI system.

Let's explore the AI system before reviewing some responsible AI principles that can apply to your system.

## Manage the complete AI system

An AI system consists of several components, including document embedding, generation-model, user query, and other elements like vector search system, user interface, and security and governance tooling. Each component needs to be evaluated individually to ensure the system's overall performance.

For example, you can have an AI system that uses Retrieval Augmented Generation (RAG) to respond to a user's question with grounded automatically generated responses:

:::image type="content" source="../media/model-overview.png" alt-text="Diagram of AI system components.":::

In such an AI system, you can have:

- **Data** components, which include raw documents, vector databases, and other inputs and outputs.
- **Model** components, which include embeddings models and generation models.
- Other components, like a vector search system, user interface, and security and governance tooling.

## Explore responsible AI principles

Evaluating data is a challenging task. You must ensure the quality of contextual data, monitor changes, and review for biases or unethical information.

Especially when working with pretrained models, you want to examine which data is included during training and how that affects your solution.

Alternatively, you can fine-tune your own language model using your own dataset. When using a dataset, you need to confirm the **legality of the data** used and consult with legal teams for licensing requirements.

Next to issues like data legality, you also need to account for potential **harmful user behavior**, and **bias** and ethical use.

For example, users can input prompts intended to override the system’s intended use, leading to harmful or incorrect responses. Implementing oversight and guardrails can help mitigate these risks.

A systematic approach to GenAI evaluation involves mitigating data risks with data licensing, prompt safety, and guardrails. It also includes evaluating the quality of LLMs, securing the system, and ensuring comprehensive, component-based evaluation.
