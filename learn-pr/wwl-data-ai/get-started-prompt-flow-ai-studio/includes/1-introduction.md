The true power of **Large Language Models** (**LLMs**) lies in their application. Whether you want to use LLMs to classify web pages into categories, or to build a chatbot on your data. To harness the power of the LLMs available, you need to create an application that combines your data sources with LLMs and generates the desired output.

To develop, test, tune, and deploy LLM applications, you can use **prompt flow**, accessible in the [Azure Machine Learning studio](/azure/machine-learning/prompt-flow/overview-what-is-prompt-flow?azure-portal=true) and the [Azure AI Studio](/azure/ai-studio/how-to/prompt-flow?azure-portal=true).

:::image type="content" source="../media/prompt-flow-feature.png" alt-text="Diagram showing prompt flow as a feature of Azure Machine Learning and Azure AI.":::

> [!Note]
> The focus of this module is on understanding and exploring prompt flow through Azure AI Studio. However, note that the content applies to the prompt flow experience in both Azure Machine Learning and Azure AI Studio.

Prompt flow takes a **prompt** as input, which in the context of LLMs, refers to the query provided to the LLM application to generate a response. It's the text or set of instructions given to the LLM application, prompting it to generate output or perform a specific task.

For example, when you want to use a text generation model, the prompt might be a sentence or a paragraph that initiates the generation process. In the context of a question-answering model, the prompt could be a query asking for information on a particular topic. The effectiveness of the prompt often depends on how well it conveys the user's intent and the desired outcome.

Prompt flow allows you to create **flows**, which refers to the sequence of actions or steps that are taken to achieve a specific task or functionality. A flow represents the overall process or pipeline that incorporates the interaction with the LLM to address a particular use case. The flow encapsulates the entire journey from receiving input to generating output or performing a desired action.
