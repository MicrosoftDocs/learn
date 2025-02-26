To implement Generative AI Operations (GenAIOps) with Azure, you need a set of tools at each stage. From **getting started**, to **customizing** your AI apps, to **experimenting** and evaluating, until you're ready to bring your app to **production**. Let's explore the essential tools and frameworks that can streamline your GenAIOps workflow. 

:::image type="content" source="../media/overview-toolchain.png" alt-text="Diagram of GenAIOps phases related to useful toolchains.":::

## Get started with setting up the environment

Before you can build any AI application, you need the right environment. Azure provides tools to help you quickly set up and experiment with AI models, making it easier to get started.

One of the key tools that can help streamline this process is **AZD** or the [**Azure Developer CLI**](/azure/developer/azure-developer-cli/). Setting up the environment for AI development can be complex, involving multiple services and configurations that require both time and expertise. AZD addresses these challenges by simplifying the process of setting up your development environment and deploying applications on Azure.

Once your environment is set up with AZD, the next step in developing AI applications is exploration. **Azure AI Foundry** allows you to explore various AI models, enabling your to track their performance, test different configurations, and optimize them for better output. Within the Azure AI Foundry **portal**, you can use the **Chat playground** to interactively experiment with different prompts and receive immediate feedback.

|Tool|Use|
|---|---|
|[AZD AI Template](https://learn.microsoft.com/collections/5pq0uompdgje8d?sharingId=ADFFF9D4AD9A0F29&WT_mc.id=aip-114567-cassieb&azure-portal=true)|A set of prebuilt infrastructure templates that allow you to quickly deploy AI applications in Azure without manually configuring every component. It simplifies the process of setting up resources.|
|[Chat playground](/azure/ai-studio/quickstarts/get-started-playground?azure-portal=true)|An interactive environment within the Azure AI Foundry portal for testing and refining AI-generated responses. It enables you to experiment with Generative AI models before deploying them to production.|

Now that you have the necessary resources and explored the available language models, you can customize a model to your specific needs.

## Customize your model to enhance its performance

Once the environment is set up, the next step is tailor the Generative AI model to the requirements of your use case. Customization can involve using techniques like **Retrieval Augmented Generation** (**RAG**), **fine-tuning**, or **AI agents**, to improve accuracy. Both methods enhance the language model's ability to generate accurate and relevant responses, but they do so in different ways and are suited to different scenarios.

RAG combines the power of generative models with external information retrieval. Instead of solely relying on the model's pre-existing knowledge, RAG enables the model to search external databases or resources to retrieve relevant information in real-time. This approach is especially useful for tasks where the model needs to provide up-to-date information that isn't contained in the training data.

For example, if you're building a financial assistant, RAG can allow the model to pull the latest stock prices or financial news from external sources, ensuring more accurate and relevant responses.

|Tool|Use|
|---|---|
|[Azure AI Search](/azure/search/retrieval-augmented-generation-overview?azure-portal=true)|This search engine retrieves the most relevant and up-to-date information from a specified database, enhancing the quality of responses, especially when real-time knowledge is important.|
|[Microsoft Fabric](https://techcommunity.microsoft.com/blog/startupsatmicrosoftblog/building-high-scale-rag-applications-with-microsoft-fabric-eventhouse/4217816?azure-portal=true)|An integrated analytics platform. For RAG, use Fabric Eventhouse to store and search embeddings for real-time similarity search.|

Fine-tuning involves adjusting the model's weights to make it better at handling specific tasks or understanding certain types of data. This process is typically used when you have a well-defined dataset of sample prompts and answers, and want the model to learn from it to improve its accuracy for a particular domain or application.

For instance, if you're building a chat application that needs to respond to customer support queries using a specific tone of voice, fine-tuning would allow the model to learn from examples of such interactions, improving its consistency in behavior.

Another approach is to build AI agents. When you build an AI agent you don't alter the core model but enhance its utility for particular tasks through external programming and control. The purpose of an AI agent is to customize how a model behaves or interacts within a specific context, often by adjusting its decision-making processes, workflows, or response patters.

|Tool|Use|
|---|---|
|[Serverless fine-tuning](/azure/ai-studio/concepts/fine-tuning-overview?azure-portal=true)|A feature within Azure AI Foundry that allows you to fine-tune models without having to manage the underlying infrastructure.|
|[Azure AI Agents](/azure/ai-services/agents/overview?azure-portal=true)|This service within Azure AI Foundry enables you to combine language models with tools to build an agent specialized in a task.|

Whatever method you choose to customize a model, you want to ensure your AI models generate high-quality responses. The experimentation phase helps you to manage, debug, and test the performance of AI models, optimizing them for better output.

## Experiment with prompts and evaluate outputs

Optimizing AI model performance starts with prompt engineering, where carefully crafted instructions or queries are provided to the model. Prompts guide the model, influencing how it interprets and responds to queries.

By experimenting with different prompt variations, you can better understand how the model reacts to certain phrases, structures, or contexts. This iterative process helps refine the model's understanding, making it more adept at generating high-quality, contextually relevant, and precise responses.

To experiment with prompts, you can use Prompty, which includes an asset class and format, and tooling that you can run in a development environment of your choice.

|Tool|Use|
|---|---|
|[Prompty](/azure/search/retrieval-augmented-generation-overview?azure-portal=true)|A tool to manage prompts—these are the instructions or queries given to the AI model. Prompty helps you track the performance of different prompts and optimize them for better responses.|
|[Azure AI Foundry](https://techcommunity.microsoft.com/blog/startupsatmicrosoftblog/building-high-scale-rag-applications-with-microsoft-fabric-eventhouse/4217816?azure-portal=true)|A platform that allows you to experiment with different AI models, manage multiple experiments, and analyze results.|

If your AI model occasionally provides biased or inappropriate responses, Azure AI Content Safety helps you identify and address these issues before they reach end users.

|Tool|Use|
|---|---|
|[Tracing](/azure/ai-studio/concepts/fine-tuning-overview?azure-portal=true)|This tool helps debug AI models by tracing their actions, allowing you to understand why certain responses are generated.|
|[Azure AI Content Safety](/azure/ai-services/agents/overview?azure-portal=true)|It ensures that AI models generate ethical, unbiased, and safe responses. It detects harmful outputs and helps mitigate risks associated with AI.|
|[Evaluators](/azure/ai-services/agents/overview?azure-portal=true)|Tools designed to assess the quality and safety of AI outputs, helping you refine the model’s behavior and outputs.|
