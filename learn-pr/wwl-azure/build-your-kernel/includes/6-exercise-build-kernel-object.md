In this exercise, you learn how to build your first Semantic Kernel SDK project. You create a new project, add the Semantic Kernel SDK NuGet package, create a kernel object, and run your first prompt. Let's get started!

> [!IMPORTANT]
> You must have Visual Studio Code and the .NET Framework 8.0 installed to complete these steps. 
> You may also need to install the Visual Studio Code C# Dev Kit extension.

1. Open Visual Studio Code and create a new project.

    You can create a new project by opening the Terminal and running the command: `dotnet new console -o SKProject`

2. Open the terminal in your project's directory.

    You can open the terminal by right-clicking your project folder and selecting "Open in Integrated Terminal"

3. In the Terminal, run the following command to install the Semantic Kernel SDK:

    `dotnet add package Microsoft.SemanticKernel --version 1.30.0`

4. Enter the following code to create the kernel:

    ```c#
    using Microsoft.SemanticKernel;

    // Populate values from your OpenAI deployment
    var modelId = "gpt-35-turbo-16k";
    var endpoint = "";
    var apiKey = "";

    // Create a kernel with Azure OpenAI chat completion
    var builder = Kernel.CreateBuilder().AddAzureOpenAIChatCompletion(modelId, endpoint, apiKey);

    // Build the kernel
    Kernel kernel = builder.Build();
    ```

    Use the endpoint and key values from your Azure OpenAI resource deployment.

5. To test that your kernel and endpoint is working, enter the following code:

    ```c#
    var result = await kernel.InvokePromptAsync("Give me a list of breakfast foods with eggs and cheese");
    Console.WriteLine(result);
    ```

6. Run the code and check that you see a response similar to the following:

    ```output
    1. Omelette
    2. Frittata
    3. Breakfast burrito
    4. Scrambled eggs with cheese
    5. Quiche
    6. Huevos rancheros
    7. Cheese and egg sandwich
    8. Egg and cheese bagel
    9. Egg and cheese croissant
    10. Baked eggs with cheese
    ```

    The response comes from the Azure OpenAI model you passed to the kernel. The Semantic Kernel SDK is able to connect to the large language model (LLM) and run the prompt. Notice how quickly you were able to receive responses from the LLM. The Semantic Kernel SDK makes building smart applications easy and efficient.
