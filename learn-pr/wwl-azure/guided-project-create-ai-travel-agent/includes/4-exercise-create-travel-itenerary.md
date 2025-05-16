In this exercise, you create a handlebars prompt function that instructs the model to get the length of the user's trip before offering an itinerary. Let's get started!

1. Navigate to the **Program.cs** file.

1. Add a handlebars prompt with the following text:

    ```c#
    string hbprompt = """
    <message role="system">Instructions: Before providing the the user with a travel itinerary, ask how many days their trip is.</message>
    <message role="user">I'm going to Rome. Can you create an itinerary for me?</message>
    <message role="assistant">Sure, how many days is your trip?</message>
    <message role="user">{{input}}</message>
    """;
    ```

1. Create a handlebars template configuration from the prompt:

    ```c#
    var templateFactory = new HandlebarsPromptTemplateFactory();
    var promptTemplateConfig = new PromptTemplateConfig()
    {
        Template = hbprompt,
        TemplateFormat = "handlebars",
        Name = "CreateItinerary",
    };
    ```

1. Create a plugin function from the prompt and add it to the kernel with the following code:

    ```c#
    var function = kernel.CreateFunctionFromPrompt(promptTemplateConfig, templateFactory);
    var plugin = kernel.CreatePluginFromFunctions("TravelItinerary", [function]);
    kernel.Plugins.Add(plugin);
    ```

    Now the kernel will be able to call your function when the user requests an itinerary.

1. Update the agent's conversation flow with the following code:

    ```c#
    var history = new ChatHistory();

    Console.WriteLine("Press enter to exit");
    Console.WriteLine("Assistant: How may I help you?");
    Console.Write("User: ");

    string input = Console.ReadLine()!;
    ```

1. Add the following code to create an input loop:

    ```c#
    while (input != "") 
    {
        history.AddUserMessage(input);
        await GetReply();
        Console.Write("User: ");
        input = Console.ReadLine()!;
    }
    ```

    Now you're ready to test your function!

1. Enter `dotnet run` in the terminal.

    In the console, enter a prompt that requests an itinerary for a destination. You should see a response similar to the following:

    ```output
    User: I want to go to Japan, can you create an itinerary for me?
    Assistant: Sure! I can help you create an itinerary for your trip to Japan. How many days will you be staying in Japan?
    User: 10 days
    Assistant: Great! Here is a suggested 10-day itinerary for your trip to Japan:

    Day 1: Arrival in Tokyo
    - Arrive in Tokyo and check into your hotel
    - Explore the lively neighborhoods of Shibuya and Harajuku
    - Visit the Meiji Shrine and enjoy the beautiful gardens

    (continued)
    ```

    You can also try prompting the model for destination recommendations. Let's instruct the model to request the user's budget before providing recommendations.

1. Create a prompt that instructs the model to request the user's budget:

    ```c#
    var history = new ChatHistory();
    history.AddSystemMessage("Before providing destination recommendations, ask the user if they have a budget for their trip.");
    ```

    Now the user can get more personalized suggestions for their travel plans. You can tune the prompt to request additional information as well.

1. Enter `dotnet run` in the terminal.

    Enter a prompt requesting travel destination recommendations. You should see a response similar to the following:

    ```output
    User: Can you give me some destination suggestions for my trip?
    Assistant: Sure! Before I provide recommendations, do you have a budget for your trip?
    User: My budget is $6000
    Assistant: Great! With a budget of $6000, you have plenty of options for your trip. Here are some destination suggestions in different price ranges:

    1. Bali, Indonesia: Known for its beautiful beaches and vibrant culture, Bali offers a mix of adventure and relaxation. You can find affordable accommodations and enjoy activities like surfing, snorkeling, and exploring ancient temples.

    (continued)
    ```

Now you have the beginnings of a helpful AI travel assistant. The user can provide a budget, length of stay, ask for currency conversions, and receive recommendations for their trip. Great work!