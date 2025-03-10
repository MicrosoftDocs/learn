Semantic Kernel is an open source SDK that empowers developers to build their own custom artificially intelligent (AI) agents. By combining large language models (LLMs) with native code, developers can create AI agents that understand and respond to natural language prompts to complete a variety of tasks.

## What's an AI agent?

An AI agent is a program that can achieve predetermined goals. AI agents are powered by large language models (LLMs) that are trained on massive amounts of data. An AI agent can fulfill a wide variety of tasks with some or minimal human intervention. AI agents can help you:

- Write code.
- Compose emails.
- Summarize meetings.
- Provide recommendations.
- And the list goes on!

## What's Semantic Kernel?

Semantic Kernel integrates LLMs like OpenAI, Azure OpenAI, and Hugging Face with conventional programming languages like C#, Python, and Java. Using the SDK, developers can create "plugins" to interface with the LLMs and perform various tasks. The Semantic Kernel SDK acts as a bridge between AI capabilities and traditional code, which helps simplify the process of developing AI-powered applications. Developers can easily utilize LLMs in their own applications without having to learn the intricacies the model's API.

The kernel is the central component of the Semantic Kernel. The kernel acts as a dependency injection container that manages all of the services and plugins needed to run your AI application. This provides developers with a centralized location to configure and monitor their AI agents. For example, suppose you invoke a prompt from the kernel. The kernel will perform the following actions:

1. Select the best AI service to run the prompt.
1. Build the prompt using the provided prompt template.
1. Send the prompt to the AI service.
1. Receive and parse the response.
1. Return the response from the LLM to your application.

Throughout this entire process, you can create events and middleware that are triggered at any of these steps. This means you can perform actions like logging, provide status updates to users, and implement responsible AI.

:::image type="content" source="../media/kernel-graphic.png" alt-text="Screenshot of a stack graphic representing the key components of the Semantic Kernel SDK.":::

For developers eager to delve into AI development, the Semantic Kernel SDK opens the door to creating your own AI agent. The SDK seamlessly integrates AI models and custom plugins that enable you to create unique and impactful user experiences.