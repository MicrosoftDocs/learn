For this exercise, you build a prompt that asks the large language model (LLM) to recommend activities for a tourist. You can also test your code with different inputs of your choice. Let's get started!

## Prepare your development environment

For these exercises, a starter project is available for you to use. Use the following steps to set up the starter project:

> [!IMPORTANT]
> You must have Visual Studio Code and the .NET Framework 8.0 installed to complete these steps. 
> You may also need to install the Visual Studio Code C# Dev Kit extension.

1. Open Visual Studio Code.

1. Under the Visual Studio Code **Start** section, select **Clone Git Repository**.

1. In the URL bar, enter `https://github.com/MicrosoftLearning/MSLearn-Develop-AI-Agents-with-Azure-OpenAI-and-Semantic-Kernel-SDK.git`

1. In the File Explorer, create a new folder in a location that is easy to find and remember, such as a folder in your Desktop.

1. Click the **Select as Repository Destination** button.

    You need to be signed in to GitHub to successfully clone the project.

1. Open the project in Visual Studio Code.

1. Open the **appsettings.json** file and update the values with your Azure OpenAI Services model id, endpoint, and API key.

    ```json
    {
        "modelId": "gpt-35-turbo-16k",
        "endpoint": "",
        "apiKey": ""
    }
    ```

1. In Explorer, right-click the **M02-run-prompts-with-semantic-kernel/M02-Project** folder and click **Open in Integrated Terminal**.

1. Expand the **M02-run-prompts-with-semantic-kernel/M02-Project** folder.

    You should see a "Program.cs" file.

Now you're ready to begin the exercise. Good luck!

## Create and run a kernel function from a prompt

In this task, you create and run a kernel function using Azure OpenAI. You build a small travel assistant that suggests activities based on user inputs.

1. Enter the following code to create the kernel:

    ```c#
    // Create a kernel builder with Azure OpenAI chat completion
    var builder = Kernel.CreateBuilder();
    builder.AddAzureOpenAIChatCompletion(modelId, endpoint, apiKey);

    // Build the kernel
    var kernel = builder.Build();
    ```

1. Create variables to store the prompt and travel information:

    ```c#
    string prompt = """
        You are a helpful travel guide. 
        I'm visiting {{$city}}. {{$background}}. What are some activities I should do today?
        """;
    string city = "Barcelona";
    string background = "I really enjoy art and dance.";
    ```

1. Create the kernel function and arguments with the following code:

    ```c#
    // Create the kernel function from the prompt
    var activitiesFunction = kernel.CreateFunctionFromPrompt(prompt);

    // Create the kernel arguments
    var arguments = new KernelArguments { ["city"] = city, ["background"] = background };
    ```

1. Enter the following code to invoke the function and output the response from the LLM:

    ```c#
    // InvokeAsync on the kernel object
    var result = await kernel.InvokeAsync(activitiesFunction, arguments);
    Console.WriteLine(result);
    ```

1. Run the code by entering `dotnet run` in the terminal. 

    You should see a response similar to the following output:

    ```output
    Barcelona is a wonderful destination for art and dance lovers. Here are some activities you should consider doing today:

    1. Visit the Picasso Museum: Explore the extensive collection of Pablo Picasso's artworks...(continued)
    ```

Great work! You created a kernel function, added inputs, and used it to generate personalized travel suggestions. This shows how AI can make user experiences more engaging and helpful.