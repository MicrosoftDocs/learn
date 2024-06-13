Suppose you want to suggest travel destinations and recommend activities for a user. In this exercise, you practice creating prompts and saving them to files. Let's get started!

1. Open the Visual Studio Code project you created in the previous exercise.

1. Remove the `prompt` and `input` variables you created in the previous exercise.

    ```csharp
    using Microsoft.SemanticKernel;
    using Microsoft.SemanticKernel.Plugins.Core;

    var builder = Kernel.CreateBuilder();
    builder.AddAzureOpenAIChatCompletion(
        "your-deployment-name",
        "your-endpoint",
        "your-api-key",
        "deployment-model");
    var kernel = builder.Build();
    ```

1. Create the following folders in your project:

    - 'Prompts'
    - 'Prompts/TravelPlugins'
    - 'Prompts/TravelPlugins/SuggestDestinations'
    - 'Prompts/TravelPlugins/GetDestination'
    - 'Prompts/TravelPlugins/SuggestActivities'

    First you create a prompt that identifies the destination a user wants to travel to. To create the prompt, you need to create the config.json and the skprompt.txt files. Let's get started!

1. In the 'GetDestination' folder, create a config.json file and enter the following code:

    ```json
    {
        "schema": 1,
        "type": "completion",
        "description": "Identify the destination of the user's travel plans",
        "execution_settings": {
            "default": {
                "max_tokens": 1200,
                "temperature": 0
            }
        },
        "input_variables": [
            {
                "name": "input",
                "description": "Text from the user that contains their travel destination",
                "required": true
            }
        ]
    }
    ```

1. Next, create a skprompt.txt file with the following text:

    ```html
    <message role="system">
    Instructions: Identify the destination the user wants to travel to.
    </message>
    <message role="user">
    I am so excited to take time off work! My partner and I are thinking about going to Santorini in Greece! I absolutely LOVE Greek food, I can't wait to be some place warm.
    </message>
    <message role="assistant">Santorini, Greece</message>

    <message role="user">{{$input}}</message>
    ```

    This prompt helps the large language model (LLM) filter the user's input and retrieve just the destination from the text.

1. In the 'SuggestDestinations' folder, create a config.json file with the following text:

    ```json
    {
    "schema": 1,
    "type": "completion",
    "description": "Recommend travel destinations to the user",
    "execution_settings": {
        "default": {
            "max_tokens": 1200,
            "temperature": 0.3
        }
    },
    "input_variables": [
        {
            "name": "input",
            "description": "Details about the user's travel plans",
            "required": true
        }
    ]
    ```

    In this config, you can raise the temperature a bit to make the output more creative.

1. Next, create a skprompt.txt file with the following text:

    ```html
    The following is a conversation with an AI travel assistant. 
    The assistant is helpful, creative, and very friendly.

    <message role="user">Can you give me some travel destination 
    suggestions?</message>

    <message role="assistant">Of course! Do you have a budget or 
    any specific activities in mind?</message>

    <message role="user">${input}</message>
    ```

    This prompt suggests travel destinations to the user based on their input. Now let's create a plugin to recommend activities at their destination.

1. In the 'SuggestActivities' folder, create a config.json file with the following text:

    ```json
    {
        "schema": 1,
        "type": "completion",
        "description": "Recommend activities at a travel destination to the user",
        "execution_settings": {
            "default": {
                "max_tokens": 4000,
                "temperature": 0.3
            }
        },
        "input_variables": [
            {
                "name": "history",
                "description": "Background information about the user",
                "required": true
            },
            {
                "name": "destination",
                "description": "The user's travel destination",
                "required": true
            }
        ]
    }
    ```

    In this config, you increase the `max_tokens` to allow more text for the history and generated text.

1. Next, create a skprompt.txt file with the following text:

    ```html
    You are a travel assistant. You are helpful, creative, and very friendly.
    Consider your previous conversation with the traveler: 
    {{$history}}

    The traveler would like some activity recommendations, things to do, and points 
    of interest for their trip. They want to go to {{$destination}}.
    Please provide them with a list of things they might like to do at their chosen destination.
    ```

    Now let's import and test your new prompts!

1. Update your Program.cs file with the following code:

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

    kernel.ImportPluginFromType<ConversationSummaryPlugin>();
    var prompts = kernel.ImportPluginFromPromptDirectory("Prompts/TravelPlugins");

    ChatHistory history = [];
    string input = @"I'm planning an anniversary trip with my spouse. We like hiking, 
        mountains, and beaches. Our travel budget is $15000";

    var result = await kernel.InvokeAsync<string>(prompts["SuggestDestinations"],
        new() {{ "input", input }});

    Console.WriteLine(result);
    history.AddUserMessage(input);
    history.AddAssistantMessage(result);
    ```

    In this code, you import the plugins you created. You also use a `ChatHistory` object to store the user's conversation. Finally, you pass some information to the `SuggestDestinations` prompt and record the results. Next, let's ask the user where they want to go so we can recommend some activities to them.

1. Add the following code to your Program.cs file:

    ```c#
    Console.WriteLine("Where would you like to go?");
    input = Console.ReadLine();

    result = await kernel.InvokeAsync<string>(prompts["SuggestActivities"],
        new() {
            { "history", history },
            { "destination", input },
        }
    );
    Console.WriteLine(result);
    ```

    In this code, you get some input from the user to find out where they want to go. Then you call the `SuggestActivities` prompt with the destination and the conversation history.

1. To test the code, enter `dotnet run` in the terminal.

    The final output may look similar to the following:

    ```output
    Absolutely! Japan is a wonderful destination with so much to see and do. Here are some recommendations for activities and points of interest:

    1. Visit Tokyo Tower: This iconic tower offers stunning views of the city and is a must-visit attraction.

    2. Explore the temples of Kyoto: Kyoto is home to many beautiful temples, including the famous Kiyomizu-dera and Fushimi Inari-taisha.

    3. Experience traditional Japanese culture: Attend a tea ceremony, try on a kimono, or take a calligraphy class to immerse yourself in Japanese culture.
    ```

    Now you created the beginnings of an AI travel assistant! Try changing the input to see how the LLM responds.

> [!IMPORTANT]
> Be sure not to delete any of the code you've written so far, you'll need it for the next module.