In the Microsoft Agent Framework, tools allow your AI agent to use existing APIs and services to perform tasks it couldn't do on its own. Tools work through function calling, allowing AI to automatically request and use specific functions. The framework routes the request to the appropriate function in your codebase and returns the results back to the LLM so it can generate a final response.

To enable automatic function calling, tools need to provide details that describe how they work. The function's input, output, and purpose should be described in a way that the AI can understand, otherwise, the AI will not correctly call the function.

## How to use tools with Azure AI Foundry Agent

The Microsoft Agent Framework supports both custom function tools and built-in tools that are ready to use out of the box.

### Built-in tools

Azure AI Foundry Agents come with several built-in tools that you can use immediately:

- **Code Interpreter** - executes Python code for calculations, data analysis, and more
- **File Search** - searches through and analyzes documents
- **Web Search** - retrieves information from the internet

These tools are automatically available and don't require any additional setup.

### Custom function tools

When creating custom tools for your Azure AI Foundry Agent, you need to understand several key concepts:

1. **Function definition and annotations**
    
    Create your tool by defining a regular Python function with proper type annotations. Use `Annotated` and `Field` from Pydantic to provide detailed descriptions that help the AI understand the function's purpose and how to use its parameters. The more descriptive your annotations, the better the AI can understand when and how to call your function.

1. **Adding tools to your agent**

    Pass your custom functions to the ChatAgent during creation using the `tools` parameter. You can add a single function or a list of multiple functions. The framework automatically registers these functions and makes them available for the AI to call.

1. **Tool invocation through conversation**

    Once your tools are registered with the agent, you don't need to manually invoke them. Instead, ask the agent questions or give it tasks that would naturally require your tool's functionality. The AI will automatically determine when to call your tools based on the conversation context and the tool descriptions you provided.

1. **Multiple tools and orchestration**

    You can add multiple tools to a single agent, and the AI will automatically choose which tool to use based on the user's request. The framework handles the orchestration, calling the appropriate functions and combining their results to provide a comprehensive response.

### Best practices for tool development

- **Clear descriptions**: Write clear, detailed descriptions for your functions and parameters to help the AI understand their purpose
- **Type annotations**: Use proper Python type hints to specify expected input and output types
- **Error handling**: Implement appropriate error handling in your tool functions to gracefully handle unexpected inputs
- **Return meaningful data**: Ensure your functions return data that the AI can effectively use in its responses
- **Keep functions focused**: Design each tool to handle a specific task rather than trying to do too many things in one function

By following these concepts, you can extend your Azure AI Foundry Agent with both built-in and custom tools, allowing it to interact with APIs and perform advanced tasks. This makes your AI more powerful and capable of handling real-world applications efficiently.