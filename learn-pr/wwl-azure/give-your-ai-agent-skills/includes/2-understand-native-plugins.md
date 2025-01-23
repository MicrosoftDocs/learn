Plugins are a key component of the Semantic Kernel SDK. Plugins allow you to encapsulate your functions into a collection that can be used by the AI. Behind the scenes, Semantic Kernel uses function caling to perform planning and invoke your code. The LLM (Large Language Model) can request specific functions and the Semantic Kernel will route the request to the appropriate function in your code. The results are returned back to the LLM so that it can generate a final response.

## Creating a plugin

For the Semantic Kernel to correctly route requests to your functions, the plugins you create must include details that describe the function's behavior. The details need to be written in a way that can be understood by the AI. The function's input, output and side effects should be described so that they AI can use the function. To create a plugin function, you add the following attributes to your function: `KernelFunction`, `Description`, and `return` if there is data returned from the function. Here is an example of a task managment plugin with a function and its description:

```c#
using System.ComponentModel;
using Microsoft.SemanticKernel;

public class TaskManagementPlugin
{
    // Mock data for the tasks
    private readonly List<TaskModel> tasks = new()
    {
        new TaskModel { Id = 1, Title = "Design homepage", Description = "Create a modern homepage layout", Status = "In Progress", Priority = "High" },
        new TaskModel { Id = 2, Title = "Fix login bug", Description = "Resolve the issue with login sessions timing out", Status = "To Do", Priority = "Critical" },
        new TaskModel { Id = 3, Title = "Update documentation", Description = "Improve API reference for developers", Status = "Completed", Priority = "Medium" }
    };

    [KernelFunction("complete_task")]
    [Description("Updates the status of the specified task to Completed")]
    [return: Description("The updated task; will return null if the task does not exist")]
    public TaskModel? CompleteTask(int id)
    {
        var task = tasks.FirstOrDefault(task => task.Id == id);

        if (task == null)
        {
            return null;
        }

        task.Status = "Completed";

        return task;
    }
}
```

In this example, there is a simple `CompleteTask` function that marks a task as complete. To call your function, you need to add the plugin to the kernel using `Plugins.AddFromType`. This will give the kernel access to the plugin's functions. Afterwards you can invoke a function using the `InvokeAsync` method.

```c#
var builder = new KernelBuilder();
Kernel kernel = builder.Build();

// Add the plugin to the kernel
kernel.Plugins.AddFromType<TaskManagementPlugin>("TaskManagement");

// Invoke the function
var arguments = new KernelArguments { ["id"] = id };
var updatedTask = await kernel.InvokeAsync("TaskManagement", "complete_task", arguments);
```

Using plugin functions allows your agent to perform tasks beyond the capabilities of a typical LLM, such as managing data, interacting with external systems, or handling specific business logic. The modularity of plugins make it easy to add new functionality to your agent without modofying core logic. This approach keeps your code organized, reusable, and easier to maintain.

## Invoke functions automatically

The Semantic Kernel SDK enables the LLM to automatically invoke your plugin functions. Automatically invoking functions allows your application to respond more intelligently to user input. Instead of requiring explicit commands to trigger specific actions, the AI can determine the appropriate function to call based on the user's request. This enhances the user experience by making interactions more natural and reducing the need for precise instructions.

To enable functions to be invoked automatically, you must set the `FunctionChoiceBehavior` property of the `OpenAIPromptExecutionSettings` object to `Auto()`. Afterwards, user prompts will be able to trigger your plugin functions.

Suppose the `TaskManagementPlugin` contains a `GetCriticalTasks` function:

```c#
[KernelFunction("get_critical_tasks")]
[Description("Gets a list of all tasks marked as 'Critical' priority")]
[return: Description("A list of critical tasks")]
public List<TaskModel> GetCriticalTasks()
{
        // Filter tasks with "Critical" priority
        return tasks.Where(task => task.Priority.Equals("Critical", StringComparison.OrdinalIgnoreCase)).ToList();
}
```

The user could trigger this function with a prompt to the LLM. For example:

```c#
// Build the kernel
Kernel kernel = builder.Build();
var chatCompletionService = kernel.GetRequiredService<IChatCompletionService>();

// Add the plugin
kernel.Plugins.AddFromType<TaskManagementPlugin>("TaskManagement");

// Enable planning
OpenAIPromptExecutionSettings openAIPromptExecutionSettings = new() 
{
    FunctionChoiceBehavior = FunctionChoiceBehavior.Auto()
};

// Create a history store the conversation
var history = new ChatHistory();
history.AddUserMessage("What are all of the critical tasks?");

// Get the response from the AI
var result = await chatCompletionService.GetChatMessageContentAsync(
   history,
   executionSettings: openAIPromptExecutionSettings,
   kernel: kernel);

// Print the results
Console.WriteLine("Assistant: " + result);
```

The output of this code would be similar to the following text:

```output 
Assistant: The only critical task is "Fix login bug". The task is currently in the "To Do" status and its description is "Resolve the issue with login sessions timing out".
```

Notice that the results of the function are passed to the LLM and a generated response is returned. Automatic function invocation makes your application smarter and more user-friendly. This feature can enhance the overall usability and adaptability of your solution.

## Make plugins AI-friendly

To enhance the LLM's ability to understand and utilize your plugin functions, consider the following guidelines:

- **Use descriptive and concise function names** 
    
    Names that clearly convey the function's purpose will help the model understand when to call the function. Avoid using abbreviations or acroynms to shorten function names. The DescriptionAttribute increases token consumption, so use it to provide context and instructions when necessary.

- **Minimize function parameters**
    
    Limit the number of function parameters and use primitive types whenever possible. This approach reduces token consumption and simplifies the function signature, making it easier for the LLM to match function parameters effectively.

- **Name function parameters clearly** 

    Use descriptive parameter names that clarify their purpose. The parameter names help the LLM assign accurate values, so avoid using abbreviations or acronyms to shorten parameter names.

Plugins in the Semantic Kernel SDK make it easy to extend your AI application's capabilities. They allow your functions to interact seamlessly with the LLM, whether invoked manually or automatically, creating smarter and more user-friendly experiences. By following best practices for naming and structuring plugins, you ensure the AI can effectively use your functions, keeping your code organized and adaptable to future needs.