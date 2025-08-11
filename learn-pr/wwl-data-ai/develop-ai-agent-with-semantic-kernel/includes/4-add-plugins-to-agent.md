In Semantic Kernel, plugins allow your AI agent to use existing APIs to perform tasks it couldn't do on its own. Plugins work through function calling, allowing AI to request and use specific functions. Semantic Kernel routes the request to the appropriate function in your codebase and returns the results back to the LLM so the LLM can generate a final response.

To enable automatic orchestration with function calling, plugins also need to provide details that describe how they behave. The function's input, output, and side effects should be described in a way that the AI can understand, otherwise, the AI will not correctly call the function.

## How to use plugins with AzureAIAgent

1. Define your plugin
    
    You can create a plugin by defining a class and annotating its methods with the `kernel_function` decorator. The decorator lets Semantic Kernel know that this function can be called by the AI or referenced in a prompt. The `kernel_function` decorator also supports a `description` attribute to help the AI understand how to use the function.

1. Add the plugin to your agent

    Once you define your plugin, you can add it to your AzureAIAgent by creating a new instance of the plugin and adding it to the agent's plugin collection.

1. Invoke the plugin's functions

    You can invoke your plugin's functions by using prompts on your agent's message thread. For example, if you have a plugin function called `get_tasks`, your prompt to the agent might be "What tasks do I have?".

By following these steps, you can extend your AzureAIAgent with plugins, allowing it to interact with APIs and perform more advanced tasks. This makes your AI more powerful and capable of handling real-world applications efficiently.