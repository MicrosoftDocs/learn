After you deploy your model to an endpoint, you can start interacting with it to see how it works. If you want the model to better fit your needs, there are several simple strategies you can use to improve its performance.

Let's explore different ways to optimize the model and make it work better for your specific use case.

<<<<<<< HEAD
## Apply prompt patterns to optimize your model's output

The quality of the questions you send to the language model, directly influences the quality of the responses you get back. You can carefully construct your question, or **prompt**, to receive better and more interesting responses. The process of designing and optimizing prompts to improve the model's performance is also known as **prompt engineering**.
=======
You can use your preferred coding language to make an API call to your model's endpoint, or you can chat with the model directly in the Azure AI Foundry portal playground. The chat playground is a quick and easy way to experiment and improve your model performance.

:::image type="content" source="../media/chat-playground.png" alt-text="Screenshot showing the chat playground in the Azure AI Foundry.":::
>>>>>>> 9728d51e21ae212cfd9ce334d3cfb5c112baae53

Prompt engineering requires users to ask relevant, specific, unambiguous, and well-structured questions, instructing the model to generate more accurate responses. To understand how to create well-defined prompts, let's explore some patterns that help you improve the output of a model.

> [!Note]
> The patterns listed here are based on the work by [White et al., (2023) who constructed a prompt pattern catalog](https://arxiv.org/abs/2302.11382?azure-portal=true).

### Instruct the model to act as a persona

When you want the model to take a specific point of view or perspective when answering a question, you can ask it to act as a persona.

For example, you can ask the model to respond as if it's a seasoned sales manager if you're working in sales and need insights about a new CRM software.

|                  |No persona specified|With persona specified|
|------------------|---------|--------|
|**User question**|Write a product description for a new CRM software.|Write a product description for a new CRM software, as if you're a seasoned sales manager explaining the software to potential clients.|
|**Model response**|This CRM software helps you manage customer relationships with easy-to-use tools that track leads, sales, and customer data. It integrates with your existing tools, making it a versatile choice for businesses of all sizes.|As a sales manager, I know how crucial it's to keep track of every customer interaction. This CRM software is built with sales teams in mind, offering tools to manage leads, monitor sales pipelines, and build stronger customer relationships. Its seamless integration with other platforms helps streamline your workflow, so you can focus more on closing deals and less on administrative tasks.|

You can create different personas for various business roles. Think of roles like a product manager, data analyst, customer service expert, or teacher. Define the persona and add more detail to what you expect that persona to know or do to get tailored, context-driven responses.

### Guide the model to suggest better questions

When you want the model to help refine your question, you can ask it to suggest better ways to phrase your query. You can also ask it to provide extra context.

For example, if you're seeking advice on increasing sales, you can prompt the model to suggest clarifying questions to help you get a more targeted answer.

|                  | No suggestions given | With suggestions given |
|------------------|----------------------|------------------------|
| **User question** | How can I increase sales for my product? | From now on, whenever I ask a question about increasing sales, suggest a better version of the question to use that incorporates details like the target audience, product type, and current sales strategies, and ask me if I want to use your question instead. |
| **Model response** | You can increase sales through better marketing, offering discounts, or improving your product’s features. | To make your question more specific, I suggest: "What are the best strategies to increase sales for an online retail business targeting young adults, and how can I optimize my current sales funnel?" Would you like to use this version of the question for a more targeted response? |

When you encourage the model to suggest clarifications or extra details can help you ask the right questions and achieve better, more accurate answers in fewer interactions.

### Provide a template to generate output in a specific format

When you want the model to generate output in a specific format, you can provide a template or structure in your prompt.

For example, if you're preparing a business report, you can ask the model to generate it in a structured format. You can request that the model follow a specific template, which includes headings, bullet points, and data breakdowns.

|                  | No template specified | With template specified |
|------------------|-----------------------|-------------------------|
| **User question** | Can you help me write a business report? | Can you help me write a business report following this template: Title, Executive Summary, Key Findings (with bullet points), Recommendations (with subheadings), and Conclusion? |
| **Model response** | Q1 2025 sales grew 10% (€1.2M). **Challenges**: retention in South Region, supply delays. **Recommendations**: loyalty programs, supply optimization, digital marketing. Positive growth trajectory identified.| **Title**: Business Performance Report<br>**Executive Summary**: This report evaluates the performance of the company over the last quarter.<br>**Key Findings**:<br>- Sales increased by 10%<br>- Customer satisfaction improved by 5%<br>**Recommendations**:<br>1. Increase marketing efforts in Q3<br>2. Improve customer service training<br>Conclusion: The company is on track to meet its annual targets, but some areas require attention. |

You can apply this approach to other scenarios where a specific format is needed, such as generating emails, summaries, proposals, or even code and scripts. Define the format template clearly and provide details on how you want the output structured to get consistent and organized responses.

You can also use a **one-shot** or **few-shots** approach by providing one or more examples to help the model identify a desired pattern.

### Understand how a model reasons by asking it to reflect

When you want the model to explain the reasoning behind its answers, you can ask the model to automatically reflect on its rationale and assumptions after providing a response.

For example, if you're working on coding tasks, you can ask the model to explain the reasoning behind choosing certain software frameworks. You can also ask the model to provide supporting evidence or code examples to clarify its choices.

|                  | No reflection specified | With reflection specified |
|------------------|-----------------------|-------------------------|
| **User question** | Why should I use this software framework for my project? | When you provide an answer, please explain the reasoning and assumptions behind your selection of software frameworks. If possible, use specific examples or evidence with associated code samples to support your answer. Additionally, address any potential ambiguities or limitations in your answer. |
| **Model response** | This framework is a great choice for your project because it’s flexible and widely used in the industry.| This framework is ideal because it supports scalability and is compatible with your existing stack. For example, in the context of web development, it integrates seamlessly with Node.js. The framework also provides excellent community support, which can help you resolve issues quickly. However, it may not be suitable if you're looking for lightweight alternatives for mobile apps, as it can be heavier compared to other frameworks.|

You can apply this approach when you want explanations in data analysis, marketing strategy, or technical troubleshooting. When you ask the model to define its reasoning, you use a technique called **chain-of-thought** to make it think step-by-step.

### Add context to improve the accuracy of the model's output

When you want the model to focus on specific topics, you can specify the context to consider. You can also tell the model to ignore irrelevant information.

For example, if you're preparing a business proposal and want to concentrate solely on market analysis, you can ask the model to ignore unrelated sections like financial projections or operational plans.

|                  | No context specified | With context specified |
|------------------|-----------------------|-------------------------|
| **User question** | Write a business proposal for a new product launch. | When writing a business proposal for a new product launch, please focus solely on market analysis. Please ignore financial projections and operational plans. |
| **Model response** | Here's a business proposal that covers all sections, including financial projections, operational plans, and market analysis.| The market analysis for your new product highlights key trends in consumer behavior, competitor products, and potential market share. Based on this data, the market is expected to grow by 15% over the next five years, and your product aligns well with current consumer preferences.|

By defining what the model should focus on or disregard, you can ensure the conversation stays on track and generate more relevant, tailored responses.

You can specify the context by describing what it should or shouldn't include, and by connecting the model to data sources it should retrieve context from before generating an answer.

## Apply model optimization strategies

As a developer, you can also apply other optimization strategies to improve the model's performance, without having to ask the end-user to write specific prompts.

The simplest approach is to add instructions to your deployed model, which you can add to the **system prompt**. The system prompt sets the model's behavior and allows you to guide the model without exposing the end-user to the instructions. You can apply prompt engineering to the system prompt too, for example by asking the model to behave as a persona or respond in a specific format.

Next to prompt engineering, the strategy you choose as a developer depends on your requirements:

:::image type="content" source="../media/model-optimization.png" alt-text="Diagram showing the various strategies to optimize the model's performance.":::

- **Optimize for context**: When the model lacks contextual knowledge and you want to **maximize responses accuracy**.
- **Optimize the model**: When you want to improve the response format, style, or speech by **maximizing consistency of behavior**.

To optimize for context, you can apply a **Retrieval Augmented Generation** (**RAG**) pattern. With RAG, you *ground* your data by first retrieving context from a data source before generating a response. For example, you want customers to ask questions about hotels that you're offering in your travel booking catalog.

When you want the model to respond in a specific style or format, you can instruct the model to do so by adding guidelines in the system message. When you notice the model's behavior isn't consistent, you can further enforce consistency in behavior by **fine-tuning** a model. With fine-tuning, you train a base language model on a dataset before integrating it in your application.

You can also use a combination of optimization strategies, like RAG *and* a fine-tuned model, to improve your language application.
