Generative AI models are powerful at understanding and generating text, but they operate within a knowledge boundary. They can only reason about information in their training data. By integrating **tools** into your generative AI interactions, you unlock capabilities far beyond what the model alone can do.

> [!NOTE]
> The use of *tools* in generative AI model prompts shouldn't be confused with *[Foundry Tools](/azure/ai-services/reference/sdk-package-resources?azure-portal=true)*; which are Azure AI APIs that you can use in your applications and agents.

## Why tools matter

Tools bridge the gap between AI reasoning and real-world actions. They enable your generative AI applications to:

- **Access real-time information**: Fetch current data, weather, stock prices, or API responses that weren't in the model's training data
- **Take actions**: perform tasks like sending emails, creating database records, or triggering workflows based on AI decisions
- **Ground responses in facts**: Retrieve specific, authoritative information to reduce hallucinations and improve accuracy
- **Extend functionality**: Connect to your existing systems, databases, and business logic seamlessly
- **Build intelligent workflows**: Chain multiple operations together so AI coordinates complex, multi-step processes

Without tools, generative AI works in isolation. With tools, it becomes an intelligent assistant that can observe, reason, and act on the world around it.

In this module, we'll focus on specifying tools in prompts that a client application submits to a model. In this kind of solution, the tool configuration is managed by the client application - essentially creating a custom generative AI powered assistant within the application logic itself. Learning how to use tools on-demand with a generative AI model is a useful first step in learning how to build *agentic AI* solutions, in which the model, instructions, and tools are encapsulated and persisted in a named *agent*.

> [!TIP]
> You can learn more about how to use the Microsoft Foundry Agents SDK to create agents with persisted configurations in [Develop AI agents on Azure](/training/paths/develop-ai-agents-azure/).
