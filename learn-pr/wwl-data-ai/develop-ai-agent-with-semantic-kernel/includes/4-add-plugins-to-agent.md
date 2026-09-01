::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=2f9e9edb-74b0-4e66-8a93-15ccdf6fb30a]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

Tools are what allow your agent to take action—call APIs, execute code, search files, or interact with external services. Without tools, an agent can only generate text based on what it already knows. With tools, it becomes capable of acting on the world.

The Microsoft Agent Framework supports two broad categories of tools: **service-provided tools** that are hosted and managed by the provider, and **custom function tools** that you write yourself and register with the agent.

## Service-provided tools

When using the Foundry provider, a range of hosted tools are available without any extra implementation. You enable them by including them in the agent configuration—the provider handles the actual execution.

The most commonly used service-provided tools include:

| Tool | What it does |
|---|---|
| **Code Interpreter** | Executes Python code in a sandboxed environment for calculations and data analysis |
| **File Search** | Searches through and retrieves information from uploaded documents |
| **Web Search** | Retrieves up-to-date information from the internet |
| **Hosted MCP Tools** | MCP (Model Context Protocol) servers invoked directly by the provider runtime |
| **Azure AI Search** | Queries an Azure AI Search index through a Foundry connection |
| **Foundry Toolboxes** | Named, versioned bundles of hosted tool configurations managed in a Foundry project |

> [!NOTE]
> Some tools—including Azure AI Search, Bing Grounding, SharePoint, and others—are in preview or experimental. They're available for Foundry agents but may have limited support across other providers.

## Custom function tools

Custom function tools let you extend your agent with any logic you need—calling internal APIs, querying databases, performing calculations, or anything else a Python function can do.

To register a function as a tool, you pass it directly to the agent during creation. The framework inspects the function's signature and generates a schema that tells the model what the function does, what parameters it expects, and what it returns.

For the model to call a tool reliably, your function needs to be clearly described. The Agent Framework supports two approaches:

- **Type annotations with descriptions**—use Python's `Annotated` type with a field description on each parameter. The function's docstring serves as the tool description.
- **The `@tool` decorator**—explicitly specify the tool's name and description as decorator arguments, giving you full control over what the model sees. You can also provide an explicit schema using a Pydantic model if you need precise control over the input structure.

In either case, the framework handles schema generation and tool invocation automatically. When the model determines a tool should be called, the framework executes the function and returns the result back to the model before the final response is generated.

### Adding multiple tools

You can register multiple tools with a single agent. Pass a list of functions when creating the agent, and the model automatically selects the most appropriate tool for each part of the conversation. You don't need to write any routing logic—the framework handles tool orchestration based on the conversation context and the tool descriptions you provide.

## Tool approval

For scenarios where tool invocations should require human review before execution, the Agent Framework supports a **tool approval** pattern. When approval mode is enabled on a tool, the agent pauses before calling that function and requests confirmation. This is useful for actions that are irreversible, expensive, or involve sensitive data. Approval behavior can be configured per tool using the `approval_mode` parameter on the `@tool` decorator.

## Using an agent as a tool

Agents can be composed by using one agent as a tool for another. You convert an inner agent into a function tool and pass it to an outer agent, which can then delegate specific tasks to it. This enables modular designs where specialized agents handle particular domains and a coordinating agent routes requests between them—a pattern explored in more depth in the multi-agent module.

## Best practices for custom tools

- **Write clear descriptions**—the model's ability to choose the right tool depends entirely on the descriptions you provide. Be specific about what the function does and when it should be used.
- **Annotate every parameter**—describe each input so the model can construct valid calls, especially when parameter names alone aren't self-explanatory.
- **Return meaningful data**—tools should return structured, interpretable output. The model uses the return value directly when forming its response.
- **Keep tools focused**—each tool should do one thing well. Combining multiple responsibilities into a single function makes it harder for the model to invoke it correctly.
- **Handle errors gracefully**—if a tool encounters an unexpected input or an external service fails, return an informative error message rather than raising an exception, so the model can respond helpfully.

::: zone-end

