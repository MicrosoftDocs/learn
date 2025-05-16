In this exercise, you create a Handlebars prompt template that will filter the user's message to identify their travel dates, origin, and destination. This will help you gain experience understanding how to use templates to process user input and create flexible user experiences.

1. Open the Visual Studio Code project you created in the previous exercise.

1. In the terminal, enter the following command to install the Handlebars template package:

    `dotnet add package Microsoft.SemanticKernel.PromptTemplates.Handlebars --version 1.30.0`

1. Open the **Program.cs** file.

    You can clear the code you added from the previous exercise.

1. Add the following `using` directive to the **Program.cs** file:

    `using Microsoft.SemanticKernel.PromptTemplates.Handlebars;`

1. Add the following code to create a Handlebars template prompt:

    ```c#
    // Create a kernel with Azure OpenAI chat completion
    var builder = Kernel.CreateBuilder();
    builder.AddAzureOpenAIChatCompletion(modelId, endpoint, apiKey);

    // Build the kernel
    Kernel kernel = builder.Build();

    string prompt = """
        <message role="system">Instructions: Identify the from and to destinations 
        and dates from the user's request</message>

        <message role="user">Can you give me a list of flights from Seattle to Tokyo? 
        I want to travel from March 11 to March 18.</message>
        
        <message role="assistant">
        Origin: Seattle
        Destination: Tokyo
        Depart: 03/11/2025 
        Return: 03/18/2025
        </message>
        
        <message role="user">{{input}}</message>
        """;
        ```

1. Create the prompt input and kernel arguments with the following code:

    ```c#
    string input = "I want to travel from June 1 to July 22. I want to go to Greece. I live in Chicago.";

    // Create the kernel arguments
    var arguments = new KernelArguments { ["input"] = input };
    ```

1. Create the prompt template config with the following code:

    ```csharp 
    // Create the prompt template config using handlebars format
    var templateFactory = new HandlebarsPromptTemplateFactory();
    var promptTemplateConfig = new PromptTemplateConfig()
    {
        Template = prompt,
        TemplateFormat = "handlebars",
        Name = "FlightPrompt",
    };
    ```

1. Create and invoke the function prompt with the following code:

    ```c#
    // Invoke the prompt function
    var function = kernel.CreateFunctionFromPrompt(promptTemplateConfig, templateFactory);
    var response = await kernel.InvokeAsync(function, arguments);
    Console.WriteLine(response);
    ```

1. Run the code by entering `dotnet run` in the terminal.

    You should see a response similar to the following output:

    ```
    Origin: Chicago
    Destination: Greece
    Depart: 06/01/2022
    Return: 07/22/2022
    ```

Using the prompt template, the LLM is able to parse the user's input and return the desired information in the specified format. This function could then be used to pass travel information to a booking system to suggest flights, hotels, and more. The applications for prompt functions are endless. Great work!