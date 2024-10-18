With the rise of **Large Language Models** (**LLMs**), there are several methods to deploy and use these models effectively.

## Store engineered prompts as templates

To start with, one of the key methods is through **engineered prompts**. Engineered prompts are carefully crafted prompts that guide the LLM to generate the desired output. When you store these prompts as templates, you can reuse them across different applications, ensuring consistency and efficiency in the deployment process.

## Build AI systems with chains

Another powerful approach is the use of **chains**. Tools like LangChain and LlamaIndex allow for the creation of chains, which are sequences of operations that process and transform data through various stages. By using LLMs at different points within these chains, you can achieve sophisticated data processing and transformation capabilities.

## Work with model deployments

When you work with LLMs, you most commonly work with **pretrained models**. These models are pretrained on large datasets and can be used out-of-the-box for various applications. They offer a quick and easy way to deploy generative AI without the need for extensive training.

To access pretrained models, you have two options:

- **Internally or self-hosted foundation models**: Models that are hosted within your own organization, which offers you more control and customization to tailor the model to your specific needs.
- **External proprietary models providers**: Models offered through API calls by, for example,  Azure OpenAI, which allow you to integrate advanced AI capabilities without the need for extensive infrastructure, making it a convenient and cost-effective option.

> [!Tip]
> Learn more about self-hosted foundation models like [Databricks' DBRX](https://www.databricks.com/blog/introducing-dbrx-new-state-art-open-llm?azure-portal=true) and external model providers like [Azure OpenAI](/azure/ai-services/openai/overview?azure-portal=true).

When you want to integrate an LLM into a production environment, making it accessible for end-users or other systems to generate predictions or completions, you need to deploy your model.

There are four deployment strategies:

- **Batch**: Generate and store completions on a table of text inputs or prompts. For example, to summarize financial reports and generate insights.
- **Streaming**: Generate and store completions on micro-batches of text inputs or prompts as they're processed. For example, to personalize marketing messages.
- **Real-time**: Generate completions asynchronously in real-time on an individual input or prompt. For example, for chatbots used in customer service.
- **Embedded** or **edge**: Deploy the model on local devices or edge servers to provide low-latency responses and offline capabilities. For example, to modify the air conditioning temperature in a car using voice command.

> [!Note]
> Edge (on-device) deployment is challenging with LLMs due to the space requirements. If you want to deploy a language model to the edge, you may want explore Small Language Models (SLMs) like [Phi-3 models](/shows/the-download/the-download-new-github-merch-phi-3-model-code-font-updates-and-more?azure-portal=true).
