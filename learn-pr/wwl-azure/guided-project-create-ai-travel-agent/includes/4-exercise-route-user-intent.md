In this exercise, you detect the user's intent and route the conversation to the desired plugins. You can use a provided plugin to retrieve the user's intent. Let's get started!

1. Update your `Program.cs` file with the following code:

    ```c#
    kernel.ImportPluginFromType<CurrencyConverter>();
    var prompts = kernel.ImportPluginFromPromptDirectory("Prompts");

    Console.WriteLine("What would you like to do?");
    var input = Console.ReadLine();

    var intent = await kernel.InvokeAsync<string>(
        prompts["GetIntent"], 
        new() {{ "input",  input }}
    );

    ```

    In this code, you use the `GetIntent` prompt to detect the user's intent. You then store the intent in a variable called `intent`. Next, you route the intent to your `CurrencyConverter` plugin.

1. Add the following code to your `Program.cs` file:

    ```c#
    switch (intent) {
        case "ConvertCurrency": 
            var currencyText = await kernel.InvokeAsync<string>(
                prompts["GetTargetCurrencies"], 
                new() {{ "input",  input }}
            );
            var currencyInfo = currencyText!.Split("|");
            var result = await kernel.InvokeAsync("CurrencyConverter", 
                "ConvertAmount", 
                new() {
                    {"targetCurrencyCode", currencyInfo[0]}, 
                    {"baseCurrencyCode", currencyInfo[1]},
                    {"amount", currencyInfo[2]}, 
                }
            );
            Console.WriteLine(result);
            break;
        default:
            Console.WriteLine("Other intent detected");
            break;
    }
    ```

    The `GetIntent` plugin returns the following values: ConvertCurrency, SuggestDestinations, SuggestActivities, Translate, HelpfulPhrases, Unknown. You use a `switch` statement to route the user's intent to the appropriate plugin. 
    
    If the user's intent is to convert currency, you use the `GetTargetCurrencies` prompt to retrieve the currency information. Then you use the `CurrencyConverter` plugin to convert the amount.

    Next, you add some cases to handle the other intents. For now, let's use the automatic function calling capability of the Semantic Kernel SDK to route the intent to the available plugins.

1. Create the automatic function calling setting by adding the following code to your `Program.cs` file:

    ```c#
    kernel.ImportPluginFromType<CurrencyConverter>();
    var prompts = kernel.ImportPluginFromPromptDirectory("Prompts");

    OpenAIPromptExecutionSettings settings = new()
    {
        ToolCallBehavior = ToolCallBehavior.AutoInvokeKernelFunctions
    };

    Console.WriteLine("What would you like to do?");
    var input = Console.ReadLine();
    var intent = await kernel.InvokeAsync<string>(
        prompts["GetIntent"], 
        new() {{ "input",  input }}
    );
    ```

    Next, you add cases to the switch statement for the other intents.

1. Update your `Program.cs` file with the following code:

    ```c#
    switch (intent) {
        case "ConvertCurrency": 
            // ...Code you entered previously...
            break;
        case "SuggestDestinations":
        case "SuggestActivities":
        case "HelpfulPhrases":
        case "Translate":
            var autoInvokeResult = await kernel.InvokePromptAsync(input!, new(settings));
            Console.WriteLine(autoInvokeResult);
            break;
        default:
            Console.WriteLine("Other intent detected");
            break;
    }
    ```

    In this code, you use the `AutoInvokeKernelFunctions` setting to automatically call functions and prompts that are referenced in your kernel. If the user's intent is to convert currency, the `CurrencyConverter` plugin performs its task. 
    
    If the user's intent is to get destination or activity suggestions, translate a phrase, or get helpful phrases in a language, the `AutoInvokeKernelFunctions` setting automatically calls the existing plugins that were included in the project code.

    You can also add code to run the user's input as a prompt to the large language model (LLM) if it doesn't fall under any of these intent cases.

1. Update the default case with the following code:

    ```c#
    default:
        Console.WriteLine("Sure, I can help with that.");
        var otherIntentResult = await kernel.InvokePromptAsync(input!, new(settings));
        Console.WriteLine(otherIntentResult);
        break;
    ```

    Now if the user has a different intent, the LLM can handle the user's request. Let's try it out!

## Check your work

In this task, you run your application and verify your code is working correctly. 

1. Enter `dotnet run` in the terminal. When prompted, enter some text similar to the following prompt:

    ```output
    What would you like to do?
    How many TTD is 50 Qatari Riyals?    
    ```

1. You should see output similar to the following response:

    ```output
    $50 QAR is approximately $93.10 in Trinidadian Dollars (TTD)
    ```

1. Enter `dotnet run` in the terminal. When prompted, enter some text similar to the following prompt:

    ```output
    What would you like to do?
    I want to go somewhere that has lots of warm sunny beaches and delicious, spicy food!
    ```

1. You should see output similar to the following response:

    ```output
    Based on your preferences for warm sunny beaches and delicious, spicy food, I have a few destination recommendations for you:

    1. Thailand: Known for its stunning beaches, Thailand offers a perfect combination of relaxation and adventure. You can visit popular beach destinations like Phuket, Krabi, or Koh Samui, where you'll find crystal-clear waters and white sandy shores. Thai cuisine is famous for its spiciness, so you'll have plenty of mouthwatering options to try, such as Tom Yum soup, Pad Thai, and Green Curry.

    2. Mexico: Mexico is renowned for its beautiful coastal regions and vibrant culture. You can explore destinations like Cancun, Playa del Carmen, or Tulum, which boast stunning beaches along the Caribbean Sea. Mexican cuisine is rich in flavors and spices, offering a wide variety of dishes like tacos, enchiladas, and mole sauces that will satisfy your craving for spicy food.

    ...

    These destinations offer a perfect blend of warm sunny beaches and delicious, spicy food, ensuring a memorable trip for you. Let me know if you need any further assistance or if you have any specific preferences for your trip!
    ```

1. Enter `dotnet run` in the terminal. When prompted, enter some text similar to the following prompt:

    ```output
    What would you like to do?
    Can you give me a recipe for chicken satay?

1. You should see a response similar to the following response:

    ```output
    Sure, I can help with that.
    Certainly! Here's a recipe for chicken satay:

    ...
    ```

    The intent should be routed to your default case and the LLM should handle the request for a chicken satay recipe, how delicious!

    > [!NOTE]
    > If your code doesn't produce the output you expected, you can review the code in the **Solution** folder.

Next, let's modify the routing logic to provide some conversation history to certain plugins. Providing history allows the plugins to retrieve more contextually relevant responses to the user's requests.