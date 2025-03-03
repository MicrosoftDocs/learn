To implement Generative AI Operations (GenAIOps) with Azure, you need a set of tools at each stage. From **getting started**, to **customizing** your AI apps, to **experimenting** and evaluating, until you're ready to bring your app to **production**. Let's explore the essential tools and frameworks that can streamline your GenAIOps workflow. 

:::image type="content" source="../media/overview-toolchain.png" alt-text="Diagram of GenAIOps phases related to useful toolchains.":::

## Get started with setting up the environment

Before you can build any AI application, you need the right environment. Azure provides tools to help you quickly set up and experiment with AI models, making it easier to get started.

One of the key tools that can help streamline this process is **AZD** or the [**Azure Developer CLI**](/azure/developer/azure-developer-cli/). Setting up the environment for AI development can be complex, involving multiple services and configurations that require both time and expertise. AZD addresses these challenges by simplifying the process of setting up your development environment and deploying applications on Azure.

Once your environment is set up with AZD, the next step in developing AI applications is exploration. **Azure AI Foundry** allows you to explore various AI models, enabling you to track their performance, test different configurations, and optimize them for better output. Within the Azure AI Foundry **portal**, you can use the **Chat playground** to interactively experiment with different prompts and receive immediate feedback.

|Tool|Use|
|---|---|
|[AZD AI Template](https://learn.microsoft.com/collections/5pq0uompdgje8d?sharingId=ADFFF9D4AD9A0F29&WT_mc.id=aip-114567-cassieb&azure-portal=true)|A set of prebuilt infrastructure templates that allow you to quickly deploy AI applications in Azure without manually configuring every component. It simplifies the process of setting up resources.|
|[Chat playground](/azure/ai-studio/quickstarts/get-started-playground?azure-portal=true)|An interactive environment within the Azure AI Foundry portal for testing and refining AI-generated responses. It enables you to experiment with Generative AI models before deploying them to production.|

Now that you have the necessary resources and explored the available language models, you can customize a model to your specific needs.

## Customize your model and enhance model performance

Once the environment is set up, the next step is to tailor the Generative AI model to the requirements of your use case. Customization can involve using techniques like **Retrieval Augmented Generation** (**RAG**), **fine-tuning**, or **AI agents**, to improve accuracy. Both methods enhance the language model's ability to generate accurate and relevant responses, but they do so in different ways and are suited to different scenarios.

**RAG** combines the power of generative models with external information retrieval. Instead of solely relying on the model's preexisting knowledge, RAG enables the model to search external databases or resources to retrieve relevant information in real-time. This approach is especially useful for tasks where the model needs to provide up-to-date information that isn't contained in the training data.

For example, if you're building a financial assistant, RAG can allow the model to pull the latest stock prices or financial news from external sources, ensuring more accurate and relevant responses.

|Tool|Use|
|---|---|
|[Azure AI Search](/azure/search/retrieval-augmented-generation-overview?azure-portal=true)|This search engine retrieves the most relevant and up-to-date information from a specified database, enhancing the quality of responses, especially when real-time knowledge is important.|
|[Microsoft Fabric](https://techcommunity.microsoft.com/blog/startupsatmicrosoftblog/building-high-scale-rag-applications-with-microsoft-fabric-eventhouse/4217816?azure-portal=true)|An integrated analytics platform. For RAG, use Fabric Eventhouse to store and search embeddings for real-time similarity search.|

**Fine-tuning** involves adjusting the model's weights to make it better at handling specific tasks or understanding certain types of data. This process is typically used when you have a well-defined dataset of sample prompts and answers, and want the model to learn from it to improve its accuracy for a particular domain or application.

For example, if you're creating a chat app for customer support, fine-tuning helps the model learn from past interactions to maintain a consistent tone.

Another approach is to build **AI agents**. When you build an AI agent, you don't alter the core model but enhance its utility for particular tasks through external programming and control. The purpose of an AI agent is to customize how one or more model behaves or interacts within a specific context, often by adjusting its decision-making processes, workflows, or response patters.

An agent is an actor that uses one or more models, allows you to do complex long running tasks, and that can take action on your behalf

|Tool|Use|
|---|---|
|[Serverless fine-tuning](/azure/ai-studio/concepts/fine-tuning-overview?azure-portal=true)|A feature within Azure AI Foundry that allows you to fine-tune models without having to manage the underlying infrastructure.|
|[Azure AI Agents](/azure/ai-services/agents/overview?azure-portal=true)|This service within Azure AI Foundry enables you to combine language models with tools to build an agent specialized in a task.|

Whatever method you choose to customize a model, you want to ensure your AI models generate high-quality responses. The experimentation phase helps you to manage, debug, and test the performance of AI models, optimizing them for better output.

## Experiment with prompts and evaluate outputs

Optimizing AI model performance starts with prompt engineering, where carefully crafted instructions or queries are provided to the model. Prompts guide the model, influencing how it interprets and responds to queries.

By experimenting with different prompt variations, you can better understand how the model reacts to certain phrases, structures, or contexts. This iterative process helps refine the model's understanding, making it more adept at generating high-quality, contextually relevant, and precise responses.

When you want to quickly explore prompts, you can use the chat playground in the Azure AI Foundry portal. If you want a more code-based approach, you can use the [**Azure AI Foundry SDK**](/azure/ai-studio/how-to/develop/sdk-overview?tabs=sync&pivots=programming-language-python?azure-portal=true), which includes **prompt templates**. If you want a tool-agnostic approach to prompt experimentation, you can use Prompty. **Prompty** is a tool that you can run in any development environment of your choice, and provides an asset class and format to construct rich prompts.

|Tool|Use|
|---|---|
|[Azure AI Foundry prompt templates](azure/ai-studio/how-to/develop/sdk-overview?branch=main&tabs=sync&pivots=programming-language-python#prompt-templates&azure-portal=true)|A template that allows you to dynamically generate prompts using inputs that are available at runtime, part of the Azure AI Inference SDK.|
|[Prompty](https://prompty.ai/?azure-portal=true)|A tool to manage prompts, which are the instructions or queries given to the AI model. Prompty helps you track the performance of different prompts and optimize them for better responses.|

When you're experimenting with prompts, you want to evaluate how your model performs. **Evaluators** are either built in or custom insights into your model's performance. Whereas evaluators are based on how a given dataset is processed, you can also include **tracing** to gain more insights into how your application is being executed.

If your AI model occasionally provides biased or inappropriate responses, **Azure AI Content Safety** helps you identify and address these issues before they reach end users.

|Tool|Use|
|---|---|
|[Evaluators](/azure/ai-studio/how-to/develop/evaluate-sdk?azure-portal=true)|Tools designed to assess the quality and safety of AI outputs, helping you refine the model’s behavior and outputs.|
|[Tracing](/azure/ai-studio/concepts/trace?azure-portal=true)|This tool helps debug AI models by tracing their actions, allowing you to understand why certain responses are generated.|
|[Azure AI Content Safety](/azure/ai-services/content-safety/overview?azure-portal=true)|It ensures that AI models generate ethical, unbiased, and safe responses. It detects harmful outputs and helps mitigate risks associated with AI.|

## Deploy your Generative AI app to production

Once the model is refined and optimized, the next step is deployment. AI models need to be deployed into a production environment, automated for continuous updates, and monitored for performance. Choosing the right framework is key to integrating your model into an AI application that works reliably in real-world scenarios.

Azure AI Foundry integrated with several tools to help with this process, including **Prompt flow**, **LangChain**, and **Semantic Kernel**. Each of these orchestration frameworks helps structure and manage how AI models interact with data, tools, and other applications. They share a common goal of enabling AI models to function effectively within larger systems but differ in their specific focus areas.

|Tool|Use|
|---|---|
|[Prompt flow](https://microsoft.github.io/promptflow/?azure-portal=true)|Build, test, and automate AI workflows. Helps with prompt engineering, evaluation, and monitoring AI interactions in a structured way.|
|[LangChain](/azure/ai-foundry/how-to/develop/langchain?azure-portal=true)|Designed to connect AI models with external data sources, APIs, and memory. It enables AI to reason, retrieve relevant information, and interact dynamically with different systems.|
|[Semantic Kernel](/azure/ai-foundry/how-to/develop/semantic-kernel?azure-portal=true)|Focuses on integrating AI models with business logic and applications to build AI agents. Allows agents to run functions, remember context, and automate tasks within enterprise systems.|

Finally, when you deploy a generative AI app, you want to automate updates, monitor performance, and get insights into its usage to properly maintain the app. You can use tools like **GitHub Actions** for automation, and **Azure Monitor** with **Application Insights** for monitoring. These tools ensure that models remain reliable, efficient, and continuously improved based on real-world data.

|Tool|Use|
|---|---|
|[GitHub Actions](https://docs.github.com/actions?azure-portal=true)|Automates deployment, ensuring new models are updated without manual effort.|
|[Azure Monitor](/azure/azure-monitor/overview?azure-portal=true)|Tracks real-time AI performance, detecting failures and degradation.|
|[Application Insights](/azure/azure-monitor/app/app-insights-overview?azure-portal=true)|Provides analytics on usage, errors, and user interactions.|
