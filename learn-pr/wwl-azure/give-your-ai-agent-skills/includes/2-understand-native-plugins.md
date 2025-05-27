Plugins are a key component of the Semantic Kernel SDK. Plugins allow you to encapsulate your functions into a collection that can be used by the AI. Behind the scenes, Semantic Kernel uses function calling to perform planning and invoke your code. The LLM (Large Language Model) can request specific functions and the Semantic Kernel will route the request to the appropriate function in your code. The results are returned back to the LLM so that it can generate a final response.

## Creating a plugin

For the Semantic Kernel to correctly route requests to your functions, the plugins you create must include details that describe the function's behavior. The details need to be written in a way that can be understood by the AI. The function's input, output and side effects should be described so that the AI can use the function.

::: zone pivot="csharp"

To create a plugin function in C#, you add the following attributes to your function: `[KernelFunction]`, `[Description]`, and `[return: Description]` if there's data returned from the function. Here’s a minimal example:

    ```csharp
    using Microsoft.SemanticKernel;

    public class TaskManagementPlugin
    {
        [KernelFunction("complete_task")]
        [Description("Marks a task as completed by its ID.")]
        [return: Description("The updated task, or null if not found.")]
        public TaskModel? CompleteTask(int id)
        {
            // ...complete the task logic...
        }
    }
    ```

::: zone-end

::: zone pivot="python"

To create a plugin function in Python, you use the `@kernel_function` decorator with a description parameter. The return type is specified in the function signature (for example, `-> dict | None`). Here’s a minimal example:

    ```python
    from semantic_kernel import kernel_function, KernelPlugin

    class TaskManagementPlugin(KernelPlugin):
        @kernel_function(name="complete_task", description="Marks a task as completed by its ID.")
        def complete_task(self, id: int) -> dict | None:
            # ...complete the task logic...
            pass
    ```

::: zone-end

> [!INOTE]
>
> ::: zone pivot="csharp"
>
> In C#, plugin functions use attributes such as `[KernelFunction]` and `[Description]` to provide metadata for the Semantic Kernel. Chat history is managed using the `ChatHistory` class and its methods, such as `AddUserMessage`.
>
> ::: zone-end
>
> ::: zone pivot="python"
>
> In Python, plugin functions use decorators such as `@kernel_function` to provide metadata for the Semantic Kernel. Chat history is typically represented as a list of dictionaries, each with a `role` and `content` key.
>
> ::: zone-end

In this example, only the essentials are shown: the function signature, attributes, and a placeholder for your logic.

To call your function, register the plugin and invoke the function as shown below:

::: zone pivot="csharp"

    ```csharp
    var kernel = new KernelBuilder().Build();
    kernel.Plugins.AddFromType<TaskManagementPlugin>("TaskManagement");

    var arguments = new KernelArguments { ["id"] = 1 };
    var updatedTask = await kernel.InvokeAsync("TaskManagement", "complete_task", arguments);
    ```

::: zone-end

::: zone pivot="python"

    ```python
    from semantic_kernel import Kernel

    kernel = Kernel()
    kernel.add_plugin(TaskManagementPlugin(), "TaskManagement")

    arguments = {"id": 1}
    updated_task = await kernel.invoke("TaskManagement.complete_task", arguments)
    ```

::: zone-end

Using plugin functions allows your agent to perform tasks beyond the capabilities of a typical LLM, such as managing data, interacting with external systems, or handling specific business logic. The modularity of plugins makes it easy to add new functionality to your agent without modifying core logic. This approach keeps your code organized, reusable, and easier to maintain.

## Invoke functions automatically

The Semantic Kernel SDK enables the LLM to automatically invoke your plugin functions. Automatically invoking functions allows your application to respond more intelligently to user input. Instead of requiring explicit commands to trigger specific actions, the AI can determine the appropriate function to call based on the user's request. This enhances the user experience by making interactions more natural and reducing the need for precise instructions.

To enable functions to be invoked automatically:

::: zone pivot="csharp"

Set the `FunctionChoiceBehavior` property of the `OpenAIPromptExecutionSettings` object to `Auto()`. Afterwards, user prompts will be able to trigger your plugin functions.

::: zone-end

::: zone pivot="python"

Set `function_call="auto"` in the `OpenAIChatCompletionSettings` object. This allows user prompts to automatically trigger your plugin functions based on the LLM's understanding of the user's intent.

::: zone-end

Suppose the `TaskManagementPlugin` contains a `GetCriticalTasks` function:

::: zone pivot="csharp"

    ```csharp
    [KernelFunction("get_critical_tasks")]
    [Description("Gets a list of all tasks marked as 'Critical' priority.")]
    [return: Description("A list of critical tasks.")]
    public List<TaskModel> GetCriticalTasks()
    {
        // ...return critical tasks...
    }
    ```

::: zone-end

::: zone pivot="python"

    ```python
    from semantic_kernel import kernel_function, KernelPlugin

    class TaskManagementPlugin(KernelPlugin):
        @kernel_function(name="get_critical_tasks", description="Gets a list of all tasks marked as 'Critical' priority.")
        def get_critical_tasks(self) -> list:
            # ...return critical tasks...
            pass
    ```

::: zone-end

The user could trigger this function with a prompt to the LLM. For example:

::: zone pivot="csharp"

    ```csharp
    var kernel = new KernelBuilder().Build();
    kernel.Plugins.AddFromType<TaskManagementPlugin>("TaskManagement");

    OpenAIPromptExecutionSettings settings = new()
    {
        FunctionChoiceBehavior = FunctionChoiceBehavior.Auto()
    };

    var history = new ChatHistory();
    history.AddUserMessage("What are all of the critical tasks?");
    var chatCompletionService = kernel.GetRequiredService<IChatCompletionService>();

    var result = await chatCompletionService.GetChatMessageContentAsync(
       history,
       executionSettings: settings,
       kernel: kernel);

    Console.WriteLine("Assistant: " + result);
    ```

::: zone-end

::: zone pivot="python"

    ```python
    from semantic_kernel.connectors.ai.open_ai import OpenAIChatCompletionSettings

    settings = OpenAIChatCompletionSettings(function_call="auto")

    history = [{"role": "user", "content": "What are all of the critical tasks?"}]
    chat_completion_service = kernel.get_service("chat_completion")

    result = await chat_completion_service.get_chat_message_content(
        history=history,
        execution_settings=settings,
        kernel=kernel
    )

    print("Assistant:", result)
    ```

::: zone-end

The output of this code would be similar to:

    ```console
    Assistant: The only critical task is "Fix login bug". The task is currently in the "To Do" status and its description is "Resolve the issue with login sessions timing out".
    ```

Notice that the results of the function are passed to the LLM and a generated response is returned. Automatic function invocation makes your application smarter and more user-friendly.

## Make plugins AI-friendly

To enhance the LLM's ability to understand and utilize your plugin functions, consider the following guidelines:

- **Use descriptive and concise function names**  

  ::: zone pivot="csharp"

Names that clearly convey the function's purpose will help the model understand when to call the function. Avoid abbreviations or acronyms. Use the `Description` attribute to provide context and instructions when necessary.

  ::: zone-end

  ::: zone pivot="python"

Names that clearly convey the function's purpose will help the model understand when to call the function. Avoid abbreviations or acronyms. Use the `description` parameter in the `@kernel_function` decorator to provide context and instructions when necessary.

  ::: zone-end

- **Minimize function parameters**  
  Limit the number of function parameters and use primitive types whenever possible. This reduces token consumption and simplifies the function signature.

- **Name function parameters clearly**  
  Use descriptive parameter names that clarify their purpose. Avoid abbreviations or acronyms.

Plugins in the Semantic Kernel SDK make it easy to extend your AI application's capabilities. They allow your functions to interact seamlessly with the LLM, whether invoked manually or automatically, creating smarter and more user-friendly experiences. By following best practices for naming and structuring plugins, you ensure the AI can effectively use your functions, keeping your code organized and adaptable to future needs.
