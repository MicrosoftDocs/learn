Native functions are functions written in native code that can be called by the Semantic Kernel SDK in your application. They're useful for performing tasks that large language models (LLM) can't do on their own. You can think of a native function like a skill your application can perform. 

In later modules, you'll learn how to use the Semantic Kernel to automatically invoke native functions you create, and combine your logic with prompts to the  LLM. Combining chat completion services with functional skills allows you to create an AI agent that can perform a wide range of tasks. But for now, let's focus on designing native functions.

Native functions have a certain format and a recommended file structure to be used by the kernel. Native functions should use the `KernelFunction` decorator in their definitions. They also use a `Description` field for parameters. For example:

```c#
[KernelFunction, Description("Convert an amount of currency to USD")]
public static string ConvertCurrency(
  [Description("The currency")] string currency, 
  [Description("The amount")] double amount)
{
  // Code to convert currency
}
```

You can import your native functions into the kernel as a plugin. Classes containing native functions should be placed in a "Plugins" directory. Related functions should be placed in the same file to keep the code organized. You can also utilize subdirectories within the "Plugins" directory to further organize your code.

For example, suppose you have a todo list application. A user wants to complete an item on their todo list. The large language model (LLM) can't access the user's todo list directly, but you can write a native function to access the list and mark an item as complete. For example, the todo list file might contain the following:

```output
{
  "todoList": [
    {
      "task": "Complete coding exercise",
      "completed": false
    },
    {
      "task": "Practice Mandarin",
      "completed": false
    },
    {
      "task": "Buy groceries",
      "completed": false
    }
  ]
}
```

You can create a file `TodoListPlugin.cs` in the 'Plugins' directory with some code to mark the task completed:

```c#
using System.ComponentModel;
using System.Text.Json;
using System.Text.Json.Nodes;
using Microsoft.SemanticKernel;

public class TodoListPlugin
{
    [KernelFunction, Description("Mark a todo list item as complete")]
    public static string CompleteTask([Description("The task to complete")] string task)
    {
        // Read the JSON file
        string jsonFilePath = $"{Directory.GetCurrentDirectory()}/todo.txt";
        string jsonContent = File.ReadAllText(jsonFilePath);

        // Parse the JSON content
        JsonNode todoData = JsonNode.Parse(jsonContent);

        // Find the task and mark it as complete
        JsonArray todoList = (JsonArray) todoData["todoList"];
        foreach (JsonNode taskNode in todoList)
        {
            if (taskNode["task"].ToString() == task)
            {
                taskNode["completed"] = true;
                break;
            }
        }

        // Save the modified JSON back to the file
        File.WriteAllText(jsonFilePath, JsonSerializer.Serialize(todoData));
        return $"Task '{task}' marked as complete.";
    }
}
```

Notice the `KernelFunction` decorator on the `CompleteTask` function. This decorator tells the kernel that this function can be accessed. The `Description` decorator tells the kernel what the function does. The function accepts the `task` as a string. Variables of kernel functions should include a description that explains what the variable is. This function also returns a string letting the user know the task was marked complete.

In the `Program.cs` file, you can import and call this native function similar to how you would call a one of the built-in plugins. For example:

```c#
using Microsoft.SemanticKernel;
using Microsoft.SemanticKernel.Plugins.Core;

var builder = Kernel.CreateBuilder();
builder.AddAzureOpenAIChatCompletion(
  "your-deployment-name",
  "your-endpoint",
  "your-api-key",
  "deployment-model");
var kernel = builder.Build();
kernel.ImportPluginFromType<TodoListPlugin>();

var result = await kernel.InvokeAsync<string>(
  "TodoListPlugin", 
  "CompleteTask", 
  new() {{ "task", "Buy groceries" }}
);
Console.WriteLine(result);
```

In this example, `kernel.InvokeAsync` is called with the plugin name, function name, and arguments. The `task` argument is set to "Buy groceries". The function will mark the task as complete in the todo list file and return a message to the user.

Now your AI agent can help the user complete tasks on their todo list. Optionally, you can choose to denote the return type of the function in the `InvokeAsync` call. Otherwise a `FunctionResult` object is returned.

In the next exercise, you'll practice creating your own plugins with native functions.