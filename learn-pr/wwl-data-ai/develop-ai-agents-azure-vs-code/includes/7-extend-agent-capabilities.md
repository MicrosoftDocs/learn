One of the most powerful features of AI agents is their ability to use tools that extend their capabilities beyond text generation. Tools enable agents to perform actions, access data, and integrate with external systems. Microsoft Foundry provides built-in tools and supports custom integrations, transforming agents from simple chat interfaces into sophisticated automation systems.

## Understanding agent tools

Tools are programmatic functions that agents can invoke to complete tasks. When an agent determines that a tool is needed to respond to a user request, it automatically calls the appropriate tool, processes the results, and incorporates them into its response. This capability enables agents to work with real-time data, execute code, search knowledge bases, and interact with external services.

The tool-calling lifecycle happens automatically:
1. User sends a message to the agent
1. Agent analyzes the request and determines which tools (if any) are needed
1. Agent invokes the appropriate tools with relevant parameters
1. Tools execute and return results
1. Agent incorporates results into a natural language response
1. Response is returned to the user

This seamless integration means you can add powerful capabilities to agents without writing complex orchestration code.

## Built-in tools overview

Microsoft Foundry provides several production-ready tools that you can add to agents without additional configuration. These tools handle common scenarios and integrate directly with the platform.

### Code Interpreter

Code Interpreter enables agents to write and execute Python code in a secure, sandboxed environment. This tool is invaluable when agents need to perform calculations, analyze data, or solve problems programmatically.

**Common use cases:**
- Mathematical calculations and formula evaluation
- Data analysis and statistical computations
- Chart and graph generation
- File processing and transformation
- Complex problem-solving requiring computation

For example, if a user asks an agent to "calculate the compound interest on a $10,000 investment at 5% annual rate over 10 years," the agent can write and execute Python code to compute the exact result rather than estimating.

### File Search

File Search provides retrieval-augmented generation (RAG) by allowing agents to search through documents you've uploaded. The tool indexes your documents and retrieves relevant information when needed, grounding agent responses in your specific knowledge base.

**Common use cases:**
- Searching product documentation
- Finding relevant policy information
- Retrieving specific data from reports
- Answering questions based on internal documentation
- Providing accurate citations from source materials

File Search supports various file formats including PDF, Word documents, text files, and more. When you add File Search to an agent, you can upload documents to a vector store that the agent can query.

### Grounding with Bing Search

Bing Search connects your agent to real-time internet information. This tool enables agents to access current events, trending topics, and information beyond their training data cutoff.

**Common use cases:**
- Researching current events
- Finding latest product information
- Accessing real-time data like weather or stock prices
- Gathering information about recent developments
- Providing citations and sources for web content

Bing Search includes automatic citation generation, so agents can reference their sources when providing information from the web.

### OpenAPI specified tools

OpenAPI tools allow agents to interact with external APIs defined by OpenAPI 3.0 specifications. This capability connects your agents to vast ecosystems of web services and enterprise systems.

**Common use cases:**
- Calling internal business APIs
- Integrating with SaaS platforms
- Accessing database information through APIs
- Triggering workflows in external systems
- Retrieving real-time data from services

You provide the OpenAPI specification, and Microsoft Foundry handles the integration, including parameter mapping and response parsing.

## Adding tools in Visual Studio Code

The Microsoft Foundry extension provides an intuitive interface for adding and configuring tools. You can add tools through either the visual designer or by editing the YAML file directly.

### Using the visual designer

To add tools through the Agent Designer:

1. Open your agent in the Agent Designer
1. Navigate to the **Tools** section in the configuration panel
1. Select **Add Tool** or the **+** icon
1. Browse the available tools in the tool library
1. Select the tool you want to add
1. Configure tool-specific settings if required
1. Save your changes

![Screenshot of agent tools in the Microsoft Foundry VS Code extension.](../media/vs-code-agent-tools.png)

When you add certain tools, the extension prompts you to configure related assets. For example, adding File Search lets you create or select a vector store for document indexing.

### Adding tools through YAML

You can also add tools by editing the agent YAML file directly. This approach works well when you know exactly which tools you need or want to apply changes from templates.

Here's an example YAML configuration with multiple tools:

```yaml
version: 1.0.0
name: research-assistant
description: Helps with research tasks using code analysis and web search
model:
  id: 'gpt-4o-deployment'
instructions: |
  You're a research assistant helping users gather and analyze information.
  Use Code Interpreter for data analysis and Bing Search for current information.
tools:
  - type: code_interpreter
  - type: bing_grounding
    bing_grounding:
      connection_id: "your-connection-id"
  - type: file_search
    file_search:
      vector_store_ids:
        - "vectorstore-123"
```

The tools array lists each enabled tool with its configuration. Some tools require additional parameters like connection IDs or vector store references.

## Model Context Protocol (MCP) servers

Model Context Protocol (MCP) provides a standardized way to add custom tools to agents. MCP servers offer reusable tool interfaces that work consistently across different agent implementations.

### Benefits of MCP servers

MCP servers provide several advantages:

**Standardized protocol** - Consistent tool communication patterns make integration predictable and reliable.

**Reusable components** - Build tools once and use them across multiple agents and projects.

**Community-driven tools** - Access tools built by the community through MCP registries, expanding capabilities without custom development.

**Simplified integration** - Consistent interfaces reduce integration complexity and maintenance burden.

### Using MCP servers in VS Code

The Microsoft Foundry extension supports MCP server integration:

1. Browse available MCP servers through the extension's tool registry
1. Add MCP servers to your agent configuration
1. Configure server-specific settings and parameters
1. Test MCP server functionality in the integrated playground
1. Deploy agents with MCP server integrations to production

MCP servers extend your agent's capabilities with specialized functions while maintaining a consistent development experience.

## Configuring File Search with vector stores

File Search requires a vector store to index and retrieve document content. Vector stores organize your documents for efficient semantic search.

### Creating vector stores

To use File Search:

1. Add the File Search tool to your agent
1. Create a new vector store or select an existing one
1. Upload documents to the vector store through the extension
1. The system automatically indexes documents for retrieval
1. Your agent can now search uploaded documents during conversations

The extension handles vector store management, making it straightforward to maintain your agent's knowledge base.

### Supported document formats

File Search supports various formats:
- PDF documents
- Microsoft Word files (.docx)
- Plain text files (.txt)
- Markdown files (.md)
- And more

When uploading documents, the system extracts text content and creates searchable embeddings, enabling semantic search across your knowledge base.

## Tool configuration best practices

Effective tool management ensures reliable agent performance and optimal user experiences:

### Selection guidelines

**Identify required capabilities** - Start by listing what your agent needs to do. Match capabilities to available tools rather than adding tools without clear purposes.

**Start with built-in tools** - Use platform-provided tools before building custom solutions. Built-in tools are tested, maintained, and optimized for the platform.

**Consider performance** - Each tool adds latency to agent responses. Use tools when their value justifies the performance impact.

**Test thoroughly** - Verify tool behavior across various scenarios. Test edge cases, error conditions, and performance under load.

### Configuration tips

**Provide clear instructions** - Tell your agent when and how to use each tool. Instructions like "Use Code Interpreter for any mathematical calculations" help agents make appropriate tool choices.

**Set appropriate boundaries** - Define when agents should *not* use certain tools. For example, "Don't use Bing Search for internal company information."

**Monitor usage** - Track which tools agents use and how often. Usage patterns reveal optimization opportunities and potential issues.

**Update knowledge bases regularly** - When using File Search, keep documents current. Outdated information leads to incorrect agent responses.

## Combining multiple tools

Agents can use multiple tools to handle complex scenarios. The agent intelligently determines which tools to invoke based on the user's request and available capabilities.

### Multi-tool scenarios

**Research and analysis agent:**
- Uses Bing Search to gather current information
- Uses Code Interpreter to analyze data and generate visualizations
- Uses File Search to reference company documentation

**Customer service agent:**
- Uses File Search to find policy information
- Uses OpenAPI tools to check order status in business systems
- Uses Code Interpreter to calculate refund amounts

**Technical support agent:**
- Uses File Search to access troubleshooting guides
- Uses OpenAPI tools to check system status
- Uses Code Interpreter to analyze log files

The agent orchestrates tool usage automatically, creating seamless experiences where complex workflows happen behind the scenes.

## Testing tools in the playground

After adding tools to your agent, test them in the integrated playground:

1. Open the playground for your agent
1. Send messages that should trigger tool usage
1. Observe which tools the agent invokes
1. Verify the agent incorporates tool results correctly
1. Test error scenarios where tools might fail
1. Iterate on instructions based on testing results

The playground shows you when tools are invoked, helping you understand the agent's decision-making process and identify issues before production deployment.

Extending agent capabilities with tools transforms simple chat interfaces into powerful automation systems. By combining built-in tools with custom integrations and MCP servers, you can create agents that seamlessly interact with your data, systems, and services while maintaining enterprise-grade security and reliability.

More in-depth discussion on both tools and MCP servers can be found later modules.