AI agents go beyond traditional apps that just respond to what you tell them—they can **act independently**, **make decisions**, and **work together** to get things done. Building these **proactive systems** requires **specialized frameworks and tools**, and there's now a growing ecosystem of solutions to choose from, each suited to different **skill levels** and **use cases**.

Let's explore the available options for agent development and learn how to choose the right one for your needs.

## Traditional AI frameworks: Enhancing apps with intelligence

Traditional AI frameworks help developers **integrate intelligent capabilities** into applications. These frameworks improve **performance** and **user engagement** in several key ways:

- **Personalization:**  
  AI can analyze user behavior and preferences to deliver tailored recommendations and experiences.  
  *Example:* Streaming platforms like **Netflix** suggest shows and movies based on viewing history, enhancing engagement.

- **Automation and efficiency:**  
  AI automates repetitive tasks and streamlines workflows, improving operational efficiency.  
  *Example:* **AI chatbots** in customer service handle common inquiries, reducing response times and freeing human agents for complex issues.

- **Enhanced user experience:**  
  AI introduces features like natural language processing, voice recognition, and predictive text.  
  *Example:* Virtual assistants like **Siri** and **Google Assistant** understand voice commands, making device interactions more intuitive.

### Beyond traditional AI: The rise of AI agent frameworks

While traditional AI enhances applications, **AI Agent Frameworks** go further by enabling the development of **autonomous, goal-oriented agents**. These agents don't just process data—they **act**, **decide**, and **collaborate** to achieve objectives.

Key capabilities include:

- **Agent collaboration and coordination:**  
  Supports multiple agents that communicate, share information, and work together to solve complex problems.

- **Task automation and management:**  
  Automates multi-step workflows and dynamic task delegation across agents for more efficient operations.

- **Contextual understanding and adaptation:**  
  Enables agents to perceive context, make decisions based on real-time data, and adapt to changing environments.

## Choose the right framework for your needs

Now that you understand the difference between traditional AI frameworks and AI agent frameworks, let's explore the **specific tools and services** available for building agents. Microsoft offers several solutions—from **low-code tools** for business users to **full-featured SDKs** for professional developers—each designed for different scenarios and skill levels.

### Microsoft Foundry agent service

Microsoft Foundry Agent Service is a managed service in Azure that is designed to provide a framework for creating, managing, and using AI agents within Microsoft Foundry. The service is based on the OpenAI Assistants API but with increased choice of models, data integration, and enterprise security; enabling you to use both the OpenAI SDK and the Azure Foundry SDK to develop agentic solutions.

> [!TIP]
> For more information about Foundry Agent Service, see the **[Microsoft Foundry Agent Service documentation](/azure/ai-services/agents/)**.

### OpenAI Assistants API

The OpenAI Assistants API provides a subset of the features in Foundry Agent Service, and can only be used with OpenAI models. In Azure, you can use the Assistants API with Azure OpenAI, though in practice the Foundry Agent Service provides greater flexibility and functionality for agent development on Azure.

> [!TIP]
> For more information about using the OpenAI Assistants API in Azure, see **[Getting started with Azure OpenAI Assistants](/azure/ai-services/openai/how-to/assistant)**.

### Microsoft Agent Framework

The Microsoft Agent Framework is a lightweight development kit that you can use to build AI agents and orchestrate multi-agent solutions. The framework serves as a platform specifically optimized for creating agents and implementing agentic solution patterns.

### AutoGen

AutoGen is an open-source framework for developing agents rapidly. It's useful as a research and ideation tool when experimenting with agents.

> [!TIP]
> For more information about AutoGen, see the **[AutoGen documentation](https://microsoft.github.io/autogen/stable/index.html)**.

### Microsoft 365 agents SDK

Developers can create self-hosted agents for delivery through a wide range of channels by using the Microsoft 365 Agents SDK. Despite the name, agents built using this SDK aren't limited to Microsoft 365, but can be delivered through channels like Slack or Messenger.

> [!TIP]
> For more information about Microsoft 365 Agents SDK, see the **[Microsoft 365 Agents SDK documentation](/microsoft-365/agents-sdk/)**.

### Microsoft Copilot Studio

Microsoft Copilot Studio provides a low-code development environment that "citizen developers" can use to quickly build and deploy agents that integrate with a Microsoft 365 ecosystem or commonly used channels like Slack and Messenger. The visual design interface of Copilot Studio makes it a good choice for building agents when you have little or no professional software development experience.

> [!TIP]
> For more information about Microsoft Copilot Studio, see the **[Microsoft Copilot Studio documentation](/microsoft-copilot-studio/)**.

### Copilot Studio lite experience in Microsoft 365 Copilot

Business users can use the *declarative* Copilot Studio lite experience tool in Microsoft 365 Copilot to author basic agents for common tasks. The declarative nature of the tool enables users to create an agent by describing the functionality they need, or they can use an intuitive visual interface to specify options for their agent.

> [!TIP]
> For more information about authoring agents with Copilot Studio lite experience, see the **[Build agents with Copilot Studio lite experience](/microsoft-365-copilot/extensibility/copilot-studio-agent-builder-build)**.

## Choose an agent development solution

With such a wide range of available tools and frameworks, it can be challenging to decide which ones to use. Use the following considerations to help you identify the right choices for your scenario:

| **User Type / Scenario** | **Recommended Solution** | **Key Capabilities** | **Typical Use Cases / Benefits** |
|---------------------------|---------------------------|-----------------------|----------------------------------|
| **Business users with little or no software development experience** | **Copilot Studio (lite experience in Microsoft 365 Copilot Chat)** | - Simple declarative agent creation<br>- No coding required | - Automate everyday tasks<br>- Empower non-technical staff to use AI with minimal IT involvement |
| **Business users with low-code development skills (Power Platform)** | **Copilot Studio (full version)** | - Combines low-code tools with business domain knowledge<br>- Extends Microsoft 365 Copilot capabilities<br>- Adds agent functionality to Teams, Slack, Messenger | - Build low-code agentic solutions<br>- Extend enterprise productivity tools |
| **Professional developers extending Microsoft 365 Copilot** | **Microsoft 365 Agents SDK** | - Full developer flexibility<br>- Build complex extensions targeting Microsoft 365 channels | - Custom integrations and advanced agent behaviors in Microsoft ecosystem |
| **Professional developers building Azure-based AI solutions** | **Foundry Agent Service** | - Integrates with Azure AI and back-end services<br>- Supports multiple models, storage, and search options | - Create scalable, customized agentic solutions using Azure infrastructure |
| **Developers building standalone or multi-agent systems** | **Microsoft Agent Framework** | - Enables creation of single or multi-agent systems<br>- Supports different orchestration patterns | - Build complex, orchestrated agent systems across diverse environments |

> [!NOTE]
> There's overlap between the capabilities of each agent development solution, and in some cases factors like existing familiarity with tools, programming language preferences, and other considerations will influence the decision.
