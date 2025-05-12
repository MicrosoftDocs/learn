The *model catalog* in Azure AI Foundry provides a central repository of models that you can browse to find the right language model for your particular generative AI use case.

:::image type="content" source="../media/model-catalog.png" alt-text="Screenshot of the model catalog in Azure AI Foundry portal.":::

Selecting a foundation model for your generative AI app is important as it affects how well your app works. To find the best model for your app, you can use a structured approach by asking yourself the following questions:

- Can AI *solve* my use case?
- How do I *select* the best model for my use case?
- Can I *scale* for real-world workloads?

Let's explore each of these questions.

## Can AI *solve* my use case?

Nowadays we have thousands of language models to choose from. The main challenge is to understand if there's a model that satisfies your needs and to answer the question: *Can AI solve my use case?*

To start answering this question, you need to discover, filter, and deploy a model. You can explore the available language models through three different catalogs:

- [**Hugging Face**](https://huggingface.co/models): Vast catalog of open-source models across various domains.
- [**GitHub**](https://github.com/marketplace/models-github): Access to diverse models via GitHub Marketplace and GitHub Copilot.
- [**Azure AI Foundry**](https://ai.azure.com/explore/models): Comprehensive catalog with robust tools for deployment.

Though you can use each of these catalogs to explore models, the model catalog in Azure AI Foundry makes it easiest to explore and deploy a model to build you prototype, while offering the best selection of models.

Let's explore some of the options you need to consider when searching for suitable models.

### Choose between large and small language models

First of all, you have a choice between Large Language Models (LLMs) and Small Language Models (SLMs).

- LLMs like GPT-4, Mistral Large, Llama3 70B, Llama 405B, and Command R+ are powerful AI models designed for tasks that require deep reasoning, complex content generation, and extensive context understanding.

- SLMs like Phi3, Mistral OSS models, and Llama3 8B are efficient and cost-effective, while still handling many common Natural Language Processing (NLP) tasks. They're perfect for running on lower-end hardware or edge devices, where cost and speed are more important than model complexity.

### Focus on a modality, task, or tool

Language models like GPT-4 and Mistral Large are also known as **chat completion** models, designed to generate coherent and contextually appropriate text-based responses. When you need higher levels of performance in complex tasks like math, coding, science, strategy, and logistics, you can also use **reasoning** models like DeepSeek-R1 and o1.

Beyond text-based AI, some models are **multi-modal**, meaning they can process images, audio, and other data types alongside text. Models like GPT-4o and Phi3-vision are capable of analyzing and generating both text and images. Multi-modal models are useful when your application needs to process and understand images, such as in computer vision or document analysis. Or when you want to build an AI app that interacts with visual content, such as a digital tutor explaining images or charts.

If your use case involves **generating images**, tools like DALL·E 3 and Stability AI can create realistic visuals from text prompts. Image generation models are great for designing marketing materials, illustrations, or digital art.

Another group of task-specific models are **embedding models** like Ada and Cohere. Embeddings models convert text into numerical representations and are used to improve search relevance by understanding semantic meaning. These models are often implemented in **Retrieval Augmented Generation** (**RAG**) scenarios to enhance recommendation engines by linking similar content.

When you want to build an application that interacts with other software tools dynamically, you can add **function calling** and **JSON support**. These capabilities allow AI models to work efficiently with structured data, making them useful for automating API calls, database queries, and structured data processing.

### Specialize with regional and domain-specific models

Certain models are designed for specific languages, regions, or industries. These models can outperform general-purpose generative AI in their respective domains. For example:

- Core42 JAIS is an Arabic language LLM, making it the best choice for applications targeting Arabic-speaking users.
- Mistral Large has a strong focus on European languages, ensuring better linguistic accuracy for multilingual applications.
- Nixtla TimeGEN-1 specializes in time-series forecasting, making it ideal for financial predictions, supply chain optimization, and demand forecasting.

If your project has regional, linguistic, or industry-specific needs, these models can provide more relevant results than general-purpose AI.

### Balance flexibility and performance with open versus proprietary models

You also need to decide whether to use open-source models or proprietary models, each with its own advantages.

**Proprietary models** are best for cutting-edge performance and enterprise use. Azure offers models like OpenAI’s GPT-4, Mistral Large, and Cohere Command R+, which deliver industry-leading AI capabilities. These models are ideal for businesses needing enterprise-level security, support, and high accuracy.

**Open-source models** are best for flexibility and cost-efficiency. There are hundreds of open-source models available in the Azure AI Foundry model catalog from Hugging Face, and models from Meta, Databricks, Snowflake, and Nvidia. Open models give developers more control, allowing fine-tuning, customization, and local deployment.

Whatever model you choose, you can use the Azure AI Foundry model catalog. Using models through the model catalog meets the key enterprise requirements for usage:

- **Data and privacy**: you get to decide what happens with your data.
- **Security and compliance**: built-in security.
- **Responsible AI and content safety**: evaluations and content safety.

Now you know the language models that are available to you, you should have an understanding of whether AI can indeed solve your use case. If you think a language model would enrich your application, you then need to select the specific model that you want to deploy and integrate.

## How do I *select* the best model for my use case?

To select the best language model for you use case, you need to decide on what criteria you're using to filter the models. The criteria are the necessary characteristics you identify for a model. Four characteristics you can consider are:

- **Task type**: What type of task do you need the model to perform? Does it include the understanding of only text, or also audio, or video, or multiple modalities?
- **Precision**: Is the base model good enough or do you need a fine-tuned model that is trained on a specific skill or dataset?
- **Openness**: Do you want to be able to fine-tune the model yourself?
- **Deployment**: Do you want to deploy the model locally, on a serverless endpoint, or do you want to manage the deployment infrastructure?

You already explored the various types of models available in the previous section. Now, let's explore in more detail how precision and performance can be important filters when choosing a model.

### Filter models for precision

In generative AI, precision refers to the accuracy of the model in generating correct and relevant outputs. It measures the proportion of true positive results (correct outputs) among all generated outputs. High precision means fewer irrelevant or incorrect results, making the model more reliable.

When integrating a language model into an app, you can choose between a base model or a fine-tuned model. A base model, like GPT-4, is pretrained on a large dataset and can handle various tasks but can lack precision for specific domains. Techniques like prompt engineering can improve this, but sometimes fine-tuning is necessary.

A fine-tuned model is trained further on a smaller, task-specific dataset to improve its precision and ability to generate relevant outputs for specific applications. You can either use a fine-tuned model or fine-tune a model yourself.

### Filter models for performance

You can evaluate your model performance at different phases, using various evaluation approaches.

When you're exploring models through the Azure AI Foundry model catalog, you can use **model benchmarks** to compare publicly available metrics like coherence and accuracy across models and datasets. These benchmarks can help you in the initial exploration phase, but give little information on how the model would perform in your specific use case.

|Benchmark|Description|
|---|---|
|**Accuracy**|Compares model-generated text with correct answer according to the dataset. Result is one if generated text matches the answer exactly, and zero otherwise.|
|**Coherence**|Measures whether the model output flows smoothly, reads naturally, and resembles human-like language.|
|**Fluency**|Assesses how well the generated text adheres to grammatical rules, syntactic structures, and appropriate usage of vocabulary, resulting in linguistically correct and natural-sounding responses.|
|**Groundedness**|Measures alignment between the model's generated answers and the input data.|
|**GPT Similarity**|Quantifies the semantic similarity between a ground truth sentence (or document) and the prediction sentence generated by an AI model.|
|**Quality index**|A comparative aggregate score between 0 and 1, with better-performing models scoring a higher value|
|**Cost**|The cost of using the model based on a price-per-token. Cost is a useful metric with which to compare quality, enabling you to determine an appropriate tradeoff for your needs.|

To evaluate how a selected model performs regarding your specific requirements, you can consider **manual** or **automated** evaluations. Manual evaluations allow you to rate your model's responses. Automated evaluations include traditional machine learning metrics and AI-assisted metrics that are calculated and generated for you.

When you evaluate a model’s performance, it's common to start with manual evaluations, as they quickly assess the quality of the model’s responses. For more systematic comparisons, automated evaluations using metrics like precision, recall, and F1 score based on your own ground truth offer a faster, scalable, and more objective approach.

## Can I *scale* for real-world workloads?

You selected a model for your use case and have successfully built a prototype. Now, you need to understand how to scale for real-world workloads.

Considerations for scaling a generative AI solution include:

- **Model deployment**: Where will you deploy the model for the best balance of performance and cost?
- **Model monitoring and optimization**: How will you monitor, evaluate, and optimize model performance?
- **Prompt management**: How will you orchestrate and optimize prompts to maximize the accuracy and relevance of generated responses?
- **Model lifecycle**: How will you manage model, data, and code updates as part of an ongoing *Generative AI Operations* (GenAIOps) lifecycle?

Azure AI Foundry provides visual and code-first tools that can help you build and maintain a scalable generative AI solution.
