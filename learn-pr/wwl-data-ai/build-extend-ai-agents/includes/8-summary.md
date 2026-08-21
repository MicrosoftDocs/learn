You started with a language model and added the elements that make an agent useful. Trusted knowledge helps it answer accurately, while tools let it retrieve information, analyze data, and take action.

You applied these skills by building a supply chain assistant for Caldova. You first grounded the assistant in Caldova's supply chain policy so it answers from trusted data. Next, you connected it to live documentation and used Code interpreter to analyze production output. You then added a custom function that drafts capacity requests. Finally, you connected an MCP server so the assistant discovers a tool and checks current material stock.

Along the way, you compared the Foundry portal, Visual Studio Code, and code-first approaches. You also applied the *declarative* tool pattern, where the agent decides when to call a described tool, and handled approval requests for sensitive actions.

The through-line: grounding supplies the right **knowledge**, and tools supply the right **capabilities**. Together they turn a chat model into an agent that can act.

To keep learning, explore:

- [What is Microsoft Foundry Agent Service?](/azure/foundry/agents/overview)
- [Model Context Protocol (MCP) tools](/azure/foundry/agents/how-to/tools/model-context-protocol)
- [Fundamentals of AI agents](/training/modules/ai-agent-fundamentals/)
