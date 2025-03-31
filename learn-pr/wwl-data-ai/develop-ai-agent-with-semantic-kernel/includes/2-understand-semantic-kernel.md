An AI agent is a program that uses generative AI to interpret data, make decisions, and perform tasks on behalf of users or other applications. AI agents rely on large language models to perform their tasks. Unlike conventional programs, AI agents can function autonomously, handling complex workflows and automating processes without requiring continuous human oversight.

AI Agents can be developed using many different tools and platforms, including the Semantic Kernel SDK. Semantic Kernel is an open-source SDK that enables developers to easily integrate the latest AI models into their applications. Part of that SDK includes the *Semantic Kernel Agents Framework*, which allows developers to quickly create functional agents that can use natural language processing to complete tasks. 

## Semantic Kernel core components

The Semantic Kernel offers different components that can be used individually or combined.

- **AI service connectors** - connect the code to AI services from different providers under a common interface. Supported services include Chat Completion, Text Generation, and more.

- **Memory connectors** - expose vector stores from other providers under a common interface.

- **Functions and plugins** - containers for functions that are registered with the kernel. Once registered, functions can be invoked by the AI or through prompt templates.

- **Prompt templates** - combine instructions, user input, and function outputs into a reusable format. Prompt templates allow AI models to execute predefined steps dynamically.

- **Filters** - allow custom actions to be performed before and after a function or prompt is invoked. When registered, function filters act as outer layers and prompt filters as inner layers.

## Agent framework core components

The Agent Framework within Semantic Kernel helps streamline the creation of agents and enables multi-agent collaboration in conversations while integrating human input. The framework uses these key components:

- **Agent** - abstraction for AI agents, with specialized subclasses like AzureAIAgent, allowing for task completion and human interaction in conversations.

- **Agent threads** - manage conversation state and stores conversations.

- **Agent chat** - the foundation for multi-agent interactions, allows for structured conversations and collaboration.

- **Agent channel** - used for custom agent development, allows different types of agents to participate in AgentChat.

- **Agent messages** - a unified structure for agent communication, provides seamless communication and integration with existing AI workflows.

- **Templating** - like Semantic Kernel prompt templates, templates use dynamic prompt configurations to shape agent behavior.

- **Functions and plugins** - like Semantic Kernel plugins, agent plugin functions allow developers to extend agent capabilities by incorporating custom functions.

This framework supports autonomous, multi-agent AI behaviors while maintaining consistency with Semantic Kernel's design, allowing developers to build intelligent, adaptable AI systems.